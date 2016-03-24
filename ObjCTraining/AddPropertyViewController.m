//
//  FirstViewController.m
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "AddPropertyViewController.h"
#import "PropertyTableViewCell.h"
#import "HouseTypeDescription.h"

@interface AddPropertyViewController ()
@property NSArray<HouseTypeDescription *> *datasource;
@end

@implementation AddPropertyViewController
static NSString *houseTypeCellIdentifier = @"PropertyTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName: @"PropertyTableViewCell" bundle:nil] forCellReuseIdentifier:houseTypeCellIdentifier];
    [self initDataSource];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PropertyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:houseTypeCellIdentifier forIndexPath:indexPath];
    HouseTypeDescription *desription = [_datasource objectAtIndex: indexPath.row];
    [cell setCellValuesWithProperty: desription];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.width/3;
}

#pragma mark - Actions

- (IBAction)addYourOwnButtonPressed:(id)sender {
    NSLog(@"addYourOwnButtonPressed");
}

- (IBAction)addFromButtonPressed:(id)sender {
    NSLog(@"addFromButtonPressed");
}

- (IBAction)continueButtonPressed:(id)sender {
    NSLog(@"continueButtonPressed");
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
