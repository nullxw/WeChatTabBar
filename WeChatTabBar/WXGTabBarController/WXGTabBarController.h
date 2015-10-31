//
//  WXGTabBarViewController.h
//  tabBarDemo
//
//  Created by wangxg on 15/10/27.
//  Copyright © 2015年 风往北吹. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WXGTabBar;

@interface WXGTabBarController : UIViewController

/**< 视图控制器集合 */
@property (nonatomic, copy)   NSArray * viewControllers;

/**< 设置选中的item */
@property (nonatomic, assign) NSInteger selectedIndex;

/**< 选中的视图控制器 */
@property(nonatomic, strong)  UIViewController * selectedViewController;

/**< tabBar */
@property(nonatomic, strong) WXGTabBar * tabBar;


@end