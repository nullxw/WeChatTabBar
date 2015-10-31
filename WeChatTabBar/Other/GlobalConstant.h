//
//  GlobalConstant.h
//  懂车行
//
//  Created by 郭昌雪 on 15/10/21.
//  Copyright © 2015年 刘冰. All rights reserved.
//

#ifndef GlobalConstant_h
#define GlobalConstant_h


//自定义颜色 ColorWihtRGB(r,g,b,a)
#define ColorWihtRGB(r,g,b,a) [UIColor  colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//获取屏幕 宽度、高度
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TEXTFONT(r)   [UIFont fontWithName:@"Helvetica" size:r]
#define IsIOS7        ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)
#define StatusBar           20
#define NavigationbarHeight 44
#define TopBarHeight        64
#define TabBarHeight        49
#define TEXTFONT(r)   [UIFont fontWithName:@"Helvetica" size:r]
#define MainTableView (tableView != washCarTableView && tableView != sortTableView && tableView != shaiXuanTableView && tableView != leftTab && tableView != rightTab)

#endif /* GlobalConstant_h */
