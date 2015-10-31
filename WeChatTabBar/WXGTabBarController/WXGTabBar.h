//
//  WXGTabBar.h
//  tabBarDemo
//
//  Created by wangxg on 15/10/27.
//  Copyright © 2015年 风往北吹. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WXGTabBarItemSelected)( NSInteger selectedIndex, NSInteger currentIndex);

@interface WXGTabBar : UIView

/**> tabBar上的按钮 */
@property (nonatomic, copy) NSArray * tabBarItems;

/**> */
@property (nonatomic, strong) WXGTabBarItemSelected tabBarItemSelected;


- (void)selectItemAtIndex:(CGFloat)index;

@end
