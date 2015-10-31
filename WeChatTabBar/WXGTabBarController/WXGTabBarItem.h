//
//  WXGTabBarItem.h
//  tabBarDemo
//
//  Created by wangxg on 15/10/27.
//  Copyright © 2015年 风往北吹. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - macro definition

@class WXGTabBarItem;

@interface WXGTabBarItem : UIControl

/**> 默认状态图片 */
@property (nonatomic, strong) UIImageView * normalImageView;

/**> 选中状态图片 */
@property (nonatomic, strong) UIImageView * selectedImageView;

/**> 按钮文字 */
@property (nonatomic, strong) UILabel * titleLabel;

/**>  设置rate,并刷新标题状态 */
@property (nonatomic, assign) CGFloat rate;

@property (nonatomic, assign, getter=isItemSelected) BOOL itemSelected;

+ (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

- (void)selectedItemWithoutAnimation;
- (void)deselectedItemWithoutAnimation;

@end


