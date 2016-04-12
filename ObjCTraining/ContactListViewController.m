//
//  ContactListViewController.m
//  ObjCTraining
//
//  Created by RWuser on 11/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ContactListViewController.h"
#import "ContactItem.h"
#import "ContactListTableViewCell+ConfigureForContactInfo.h"

@interface ContactListViewController ()
@property NSMutableArray *contacts;
@end

static NSString *const contactCellIdentifier = @"ContactListTableViewCell";
static NSString *const showContactInfoSegueIdentifier = @"ShowContactInfo";
static CGFloat const contactCellHeight = 72.0f;

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ContactListTableViewCell" bundle:nil] forCellReuseIdentifier:contactCellIdentifier];
    [self initDataSource];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contactCellIdentifier forIndexPath:indexPath];
    ContactItem *contactItem = [self.contacts objectAtIndex:indexPath.row];
    [cell setCellValuesWithContactInfo:contactItem];
    
    [cell setPhoneButtonDidTapBlock:^(id sender) {
        NSURL *phoneUrl = [NSURL URLWithString:[@"tel://" stringByAppendingString:contactItem.phoneNumber]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        }
    }];
    
    [cell setInfoButtonDidTapBlock:^(id sender) {
        [self performSegueWithIdentifier:showContactInfoSegueIdentifier sender:self];
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return contactCellHeight;
}

#pragma mark - Prepare data source

- (void)initDataSource {
    NSMutableArray *contacts = [NSMutableArray array];
    ContactItem *contactItem = [[ContactItem alloc] initWithName:@"Andy Yien" role:@"Bank of America" phoneNumber:@"+79281980498" avatarImageUrl:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV2U07zoDObAgvP1XnfohR330xfkFd6C07Qdzx-5iFPoW4Bgw3vQ"];
    [contacts addObject:contactItem];
    
    ContactItem *contactItem1 = [[ContactItem alloc] initWithName:@"Vicky Cannon" role:@"Wife" phoneNumber:@"+79281980498" avatarImageUrl:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV2U07zoDObAgvP1XnfohR330xfkFd6C07Qdzx-5iFPoW4Bgw3vQ"];
    [contacts addObject:contactItem1];
    
    ContactItem *contactItem2 = [[ContactItem alloc] initWithName:@"Marion Sims" role:@"Agent" phoneNumber:@"+79281980498" avatarImageUrl:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV2U07zoDObAgvP1XnfohR330xfkFd6C07Qdzx-5iFPoW4Bgw3vQ"];
    [contacts addObject:contactItem2];
    self.contacts = contacts;
}

@end
