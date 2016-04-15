//
//  MenuViewController.m
//  ObjCTraining
//
//  Created by RWuser on 13/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "MenuViewController.h"
#import "UIView+AddBorder.h"
#import "UIColor+LCAdditions.h"

typedef NS_ENUM(NSInteger, MenuItem) {
    MenuItemSettings = 0,
    MenuItemProfile,
    MenuItemContacts,
    MenuItemActivityFeed,
    MenuItemContactUs,
    MenuItemTutorials,
    MenuItemsCount,
};

static NSString * const menuCellIdentifier = @"MenuCell";
static NSString * const logOutCellIdentifier = @"LogOutCell";
static int const additionalSeparatorTag = 59;
static int const logOutButtonTag = 5;

@implementation MenuViewController

- (void)viewDidLoad {
    [self.menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:menuCellIdentifier];
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
        [cell.textLabel.leadingAnchor constraintEqualToAnchor:cell.leadingAnchor constant:41.0f];
        cell.textLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:16.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:98.0f/255.0f green:188.0f/255.0f blue:229.0f/255.0f alpha:1.0f];

        if ([cell.contentView viewWithTag:additionalSeparatorTag] == nil) {
            CGFloat additionalSeparatorThickness = 2.0f;
            UIView *additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - additionalSeparatorThickness, cell.frame.size.width, additionalSeparatorThickness)];
            additionalSeparator.backgroundColor = [UIColor whiteColor];
            additionalSeparator.tag = additionalSeparatorTag;
            [cell.contentView addSubview:additionalSeparator];
        }

        cell.textLabel.text = [[self class] nameForMenuItem:indexPath.row];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:logOutCellIdentifier forIndexPath:indexPath];
        [[cell.contentView viewWithTag:logOutButtonTag] addTopBorderWithColor:[UIColor lc_greyishColor] andWidth:1.0f];
        [[cell.contentView viewWithTag:logOutButtonTag] addBottomBorderWithColor:[UIColor lc_greyishColor] andWidth:1.0f];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        switch(indexPath.row) {
            case MenuItemSettings:
                //go to settings
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

- (IBAction)logOutButtonPressed:(id)sender {
    NSLog(@"logout");
}

#pragma mark - Menu Items processing

+ (NSDictionary *)MenuItemNames
{
    return @{@(MenuItemSettings) : @"Settings",
             @(MenuItemProfile) : @"Profile",
             @(MenuItemContacts) : @"Contacts",
             @(MenuItemActivityFeed) : @"Activity Feed",
             @(MenuItemContactUs) : @"Contact Us",
             @(MenuItemTutorials) : @"Tutorials"};
}

+ (NSString *)nameForMenuItem:(MenuItem)menuItem
{
    return [[self class] MenuItemNames][@(menuItem)];
}

@end
