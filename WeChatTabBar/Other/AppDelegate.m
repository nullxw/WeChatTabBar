//
//  AppDelegate.m
//  tabBarDemo
//
//  Created by wangxg on 15/10/25.
//  Copyright © 2015年 风往北吹. All rights reserved.
//

#import "AppDelegate.h"
#import "ChatViewController.h"
#import "ContactsViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"
#import "WXGTabBarController.h"

#import "WXGTabBar.h"
#import "WXGTabBarItem.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initRootViewController];
    
    return YES;
}

- (void)initRootViewController {
    
    WXGTabBarController * wxgtabBarController = [[WXGTabBarController alloc] init];
    
    ChatViewController * chatVC = [[ChatViewController alloc] init];
    UINavigationController * chatNav = [[UINavigationController alloc] initWithRootViewController:chatVC];
    
    ContactsViewController * contactsVC = [[ContactsViewController alloc] init];
    UINavigationController * contactsNav = [[UINavigationController alloc] initWithRootViewController:contactsVC];
    
    DiscoverViewController * discoverVC = [[DiscoverViewController alloc] init];
    UINavigationController * discoverNav = [[UINavigationController alloc] initWithRootViewController:discoverVC];
    
    MineViewController * mineVC = [[MineViewController alloc] init];
    UINavigationController * mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    NSArray * array = @[chatNav,contactsNav,discoverNav,mineNav];
    
    
    WXGTabBar * tabBar = [[WXGTabBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    
    WXGTabBarItem * chatItem = [WXGTabBarItem initWithTitle:@"微信"
                                              image:[UIImage imageNamed:@"tabbar_mainframe"]
                                              selectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"]];
    
    WXGTabBarItem * contactsItem = [WXGTabBarItem initWithTitle:@"通讯录"
                                                 image:[UIImage imageNamed:@"tabbar_contacts"]
                                                 selectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    
    WXGTabBarItem * discoverItem = [WXGTabBarItem initWithTitle:@"发现"
                                                 image:[UIImage imageNamed:@"tabbar_discover"]
                                                 selectedImage:[UIImage imageNamed:@"tabbar_discoverHL"]];
    
    WXGTabBarItem *mineItem = [WXGTabBarItem initWithTitle:@"我的"
                                                 image:[UIImage imageNamed:@"tabbar_me"]
                                                 selectedImage:[UIImage imageNamed:@"tabbar_meHL"]];
    
    tabBar.tabBarItems = @[chatItem, contactsItem, discoverItem, mineItem];
    wxgtabBarController.tabBar = tabBar;

    wxgtabBarController.viewControllers = array;
    
    self.window.rootViewController = wxgtabBarController;
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

@end
