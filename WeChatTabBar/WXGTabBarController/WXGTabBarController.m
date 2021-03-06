//
//  WXGTabBarViewController.m
//  tabBarDemo
//
//  Created by wangxg on 15/10/27.
//  Copyright © 2015年 风往北吹. All rights reserved.
//

#import "WXGTabBarController.h"
#import "GlobalConstant.h"

#import "WXGTabBar.h"
#import "WXGTabBarItem.h"


@interface WXGTabBarController ()<UIScrollViewDelegate>

/**< 视图控制器的视图滚动控制 */
@property (nonatomic, strong) UIScrollView * scrollView;


@property (nonatomic, strong) NSMutableArray * childViewFrames;

@property (nonatomic, strong) NSMutableDictionary * displayVC;


@end

@implementation WXGTabBarController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.tabBar];
    
    /**> block  */
    __weak __typeof(self)weakSelf = self;
    self.tabBar.tabBarItemSelected = ^(NSInteger selectedIndex, NSInteger currentIndex) {
        
        CGPoint targetP = CGPointMake(SCREEN_WIDTH*selectedIndex, 0);
        
        [weakSelf.scrollView setContentOffset:targetP animated:NO];
    };
    
    [self addViewControllerAtIndex:0];
    
    if (self.selectedIndex != 0) {
        [self.tabBar selectItemAtIndex:self.selectedIndex];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addViewControllerAtIndex:(NSInteger)index {
    
    UIViewController * vc = _viewControllers[index];
    vc.view.frame = [self.childViewFrames[index] CGRectValue];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
    [self.scrollView addSubview:vc.view];
    self.selectedViewController = vc;
    
    [self.displayVC setObject:vc forKey:@(index)];
}


#pragma mark - UIScrollviewDelegate

- (void)layoutChildViewControllers{
    int currentPage = (int)self.scrollView.contentOffset.x / SCREEN_WIDTH;
    int start,end;
    if (currentPage == 0) {
        start = currentPage;
        end = currentPage + 1;
    }else if (currentPage + 1 == self.viewControllers.count){
        start = currentPage - 1;
        end = currentPage;
    }else{
        start = currentPage - 1;
        end = currentPage + 1;
    }
    
    for (int i = start; i <= end; i++) {
        CGRect frame = [self.childViewFrames[i] CGRectValue];
        UIViewController *vc = [self.displayVC objectForKey:@(i)];
        if ([self isInScreen:frame]) {
            if (vc == nil) {
                [self addViewControllerAtIndex:i];
            }
        }else{
            if (vc) {
                [vc.view removeFromSuperview];
                [vc willMoveToParentViewController:nil];
                [vc removeFromParentViewController];
                
                [self.displayVC removeObjectForKey:@(i)];
            }
        }
    }
}
- (BOOL)isInScreen:(CGRect)frame {
    CGFloat x = frame.origin.x;
    CGFloat ScreenWidth = self.scrollView.frame.size.width;
    
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    if (CGRectGetMaxX(frame) > contentOffsetX && x-contentOffsetX < ScreenWidth) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self layoutChildViewControllers];

    CGFloat width  = scrollView.frame.size.width;
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat rate = contentOffsetX / width;
    [self.tabBar selectItemAtIndex:rate];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _selectedIndex = (int)scrollView.contentOffset.x / SCREEN_WIDTH;
}


#pragma mark - getter and setter

/*** getter  ***/
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(_viewControllers.count * self.view.bounds.size.width, 0);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (WXGTabBar *)tabBar {
    
    if (!_tabBar) {
    
        CGRect frame = CGRectMake(0, SCREEN_HEIGHT - TabBarHeight, SCREEN_WIDTH, TabBarHeight);
        _tabBar = [[WXGTabBar alloc] initWithFrame:frame];
        _tabBar.backgroundColor = [UIColor yellowColor];
    }
    return _tabBar;
}

- (NSMutableArray *)childViewFrames {
    
    if (_childViewFrames == nil) {
        _childViewFrames = [NSMutableArray array];
        for (int i = 0; i < self.viewControllers.count; i++) {
            CGRect frame = CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [_childViewFrames addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    return _childViewFrames;
}

- (NSMutableDictionary *)displayVC {
    
    if (_displayVC == nil) {
        _displayVC = [NSMutableDictionary dictionary];
    }
    return _displayVC;
}

/*** setter ***/

- (void)setSelectIndex:(int)selectIndex {
    
    _selectedIndex = selectIndex;
    if (self.tabBar) {
        [self.tabBar selectItemAtIndex:selectIndex];
    }
}

@end



