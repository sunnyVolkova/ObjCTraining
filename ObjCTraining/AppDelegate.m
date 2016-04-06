//
//  AppDelegate.m
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initTabBarController];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)setStatusBarBackgroundColor: (UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)initTabBarController {
    NSString *storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    
    UINavigationController *homeNavigationController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
    UINavigationController *accountsNavigationController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"AccountsNavigationController"];
    UINavigationController *notificationsNavigationController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"NotificationsNavigationController"];
    UINavigationController *chatNavigationController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"ChatNavigationController"];
    
    NSArray *controllers = [NSArray arrayWithObjects:homeNavigationController, accountsNavigationController, notificationsNavigationController, chatNavigationController, nil];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [self.window setRootViewController:tabBarController];
    tabBarController.viewControllers = controllers;
}
@end
