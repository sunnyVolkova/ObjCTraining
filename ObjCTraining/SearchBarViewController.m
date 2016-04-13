//
//  SearchBarViewController.m
//  ObjCTraining
//
//  Created by RWuser on 13/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "SearchBarViewController.h"

@implementation SearchBarViewController
- (void)viewDidLoad {
    self.searchBar.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:0.5f];
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    self.searchBar.tintColor = [UIColor colorWithRed:142.0f/255.0f green:142.0f/255.0f blue:147.0f/255.0f alpha:1.0f];
   
    for (UIView *subView in self.searchBar.subviews)
    {
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]]) {
                UITextField *searchField = (UITextField *)secondLevelSubview;
                searchField.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.5f];
                searchField.textColor = [UIColor colorWithRed:142.0f/255.0f green:142.0f/255.0f blue:147.0f/255.0f alpha:1.0f];
                break;
            }
        }
    }
}
@end
