//
//  MenuViewController.m
//  ObjCTraining
//
//  Created by RWuser on 13/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItemTableViewCell.h"
#import "BottomButtonTableViewCell.h"
#import "UIColor+LCAdditions.h"

typedef NS_ENUM(NSInteger, MenuItem) {
    MenuItemSettings,
    MenuItemProfile,
    MenuItemContacts,
    MenuItemActivityFeed,
    MenuItemContactUs,
    MenuItemTutorials,
    MenuItemsCount,
};

static NSString * const menuCellIdentifier = @"MenuCell";
static NSString * const logOutCellIdentifier = @"LogOutCell";

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuItemTableViewCell" bundle:nil] forCellReuseIdentifier:menuCellIdentifier];
    [self.menuTableView registerNib:[UINib nibWithNibName:@"BottomButtonTableViewCell" bundle:nil] forCellReuseIdentifier:logOutCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return MenuItemsCount;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return 52;
    } else {
        return 116;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        MenuItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
        cell.titleTextLabel.text =[MenuViewController nameForMenuItem:indexPath.row];
        return cell;
    } else {
        BottomButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:logOutCellIdentifier forIndexPath:indexPath];
        [cell.button setTitle:@"Log Out" forState:UIControlStateNormal&UIControlStateHighlighted&UIControlStateSelected];
        cell.cellDidSelectBlock = ^(id sender) {
            NSLog(@"logout");
        };
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch(indexPath.row) {
            case MenuItemSettings:
                //go to settings
                NSLog(@"go to settings");
                break;
            case MenuItemProfile:
                //go to profile
                break;
            case MenuItemContacts:
                //go to cintacts
                break;
            case MenuItemActivityFeed:
                //go to activity feed
                break;
            case MenuItemContactUs:
                //go to contact us
                break;
            case MenuItemTutorials:
                //go to tutorials
                break;
            default:
                [NSException raise:NSGenericException format:@"Unexpected menu item"];
        }
    } 
}

#pragma mark - Menu Items processing

+ (NSString *)nameForMenuItem:(MenuItem)menuItem
{
    switch(menuItem) {
        case MenuItemSettings:
            return @"Settings";
        case MenuItemProfile:
            return @"Profile";
        case MenuItemContacts:
            return @"Contacts";
        case MenuItemActivityFeed:
            return @"Activity Feed";
        case MenuItemContactUs:
            return @"Contact Us";
        case MenuItemTutorials:
            return @"Tutorials";
        default:
            [NSException raise:NSGenericException format:@"Unexpected menu item"];
            return @"";
    }
}

@end
