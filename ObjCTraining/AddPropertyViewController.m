//
//  FirstViewController.m
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "AddPropertyViewController.h"
#import "HouseTypeTableViewCell.h"
#import "HouseTypeDescription.h"

@interface AddPropertyViewController ()
@property NSArray<HouseTypeDescription *> *datasource;
@end

@implementation AddPropertyViewController

- (IBAction)addYourOwnButtonPressed:(id)sender {
    NSLog(@"addYourOwnButtonPressed");
}
- (IBAction)addFromButtonPressed:(id)sender {
    NSLog(@"addFromButtonPressed");
}
- (IBAction)continueButtonPressed:(id)sender {
    NSLog(@"continueButtonPressed");
}

static NSString *houseTypeCellIdentifier = @"HouseTypeTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName: @"HouseTypeTableViewCell" bundle:nil] forCellReuseIdentifier:houseTypeCellIdentifier];
    [self initDataSource];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HouseTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:houseTypeCellIdentifier];
    if ([_datasource objectAtIndex: indexPath.row]) {
        cell.typeName.text = [_datasource objectAtIndex:indexPath.row].typeDescription;
        cell.typeImage.image = [UIImage imageNamed:[_datasource objectAtIndex:indexPath.row].imageName];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.frame.size.width/3;
}

- (void) initDataSource {
    NSMutableArray *datasource = [NSMutableArray array];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Primary Residense" imageName: @"house1"]];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Single Family Home" imageName: @"house2"]];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Condo" imageName: @"house3"]];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Town House" imageName: @"house4"]];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Second Home" imageName: @"house5"]];
    _datasource = [NSArray arrayWithArray:datasource];
}
@end
