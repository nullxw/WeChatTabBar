//
//  WXGTabBar.m
//  tabBarDemo
//
//  Created by wangxg on 15/10/27.
//  Copyright © 2015年 风往北吹. All rights reserved.
//

#import "WXGTabBar.h"
#import "WXGTabBarItem.h"

#define kTagGap     5000

@interface WXGTabBar ()

@property (nonatomic, strong) WXGTabBarItem * selItem;

@property (nonatomic, assign) BOOL isClick;

@end


@implementation WXGTabBar {
    
    CGRect m_tabBarRect;
}

#pragma mark - Life cycle

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self config:CGRectMake(0, SCREEN_HEIGHT-TabBarHeight, SCREEN_WIDTH, TabBarHeight)];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config:CGRectMake(0, SCREEN_HEIGHT-TabBarHeight, SCREEN_WIDTH, TabBarHeight)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self config:frame];
    }
    
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [self addItems];
}


#pragma mark - Private Methods

- (void)config:(CGRect)rect {
    
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, SCREEN_WIDTH, 5)];
    topLine.image = [UIImage imageNamed:@"tapbar_top_line"];
    [self addSubview:topLine];
    
    m_tabBarRect = rect;
}

- (void)addItems {
    
    CGFloat buttonWidth = SCREEN_WIDTH/_tabBarItems.count;
    CGFloat tabBarHeight = m_tabBarRect.size.height;
    
    for (int i=0; i<_tabBarItems.count; ++i) {
        
        WXGTabBarItem * item = [_tabBarItems objectAtIndex:i];
        item.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, tabBarHeight);
        item.tag = i + kTagGap;
        
        if (i == 0) {
            [item selectedItemWithoutAnimation];
            self.selItem = item;
        } else {
            [item deselectedItemWithoutAnimation];
        }
        
        [item addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:item];
    }
}


#pragma mark - event response
- (void)itemSelected:(WXGTabBarItem *)sender {
    
    WXGTabBarItem * item = sender;
    
    if (self.selItem == item) return;
    
    NSInteger currentIndex = self.selItem.tag - kTagGap;
    
    _tabBarItemSelected(item.tag - kTagGap, currentIndex);
}


#pragma mark - getter and setter

/*** setter ***/
- (void)setTabBarItems:(NSArray *)tabBarItems {
    
    _tabBarItems = tabBarItems;
    
    [tabBarItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[WXGTabBarItem class]]) {
            WXGTabBarItem * item = (WXGTabBarItem *)obj;
            if (obj == 0) {
                item.selected = YES;
            }
            
            item.tag = idx + kTagGap;
            [item addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:item];
        }
    }];
}

- (void)selectItemAtIndex:(CGFloat)progress {

    NSInteger tag = (NSInteger)progress + kTagGap;
    CGFloat rate = progress - tag + kTagGap;
    WXGTabBarItem *currentItem = (WXGTabBarItem *)[self viewWithTag:tag];
    WXGTabBarItem *nextItem = (WXGTabBarItem *)[self viewWithTag:tag+1];
    
    if (rate == 0.0) {
        rate = 1.0;
        self.selItem.rate = 0;
        self.selItem = currentItem;
        self.selItem.rate = 1;
        return;
    }
    
    currentItem.rate = 1-rate;
    nextItem.rate = rate;
}

@end
