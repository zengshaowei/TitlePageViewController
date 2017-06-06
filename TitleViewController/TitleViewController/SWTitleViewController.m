//
//  SWTitleViewController.m
//  TitleViewController
//
//  Created by 曾少伟 on 2016/11/20.
//  Copyright © 2016年 曾少伟. All rights reserved.
//

#import "SWTitleViewController.h"
#import <objc/runtime.h>

@interface SWTitleViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,SWToolBarDelegate>
@end

@implementation SWTitleViewController
- (instancetype)initWithTitles:(NSArray *)titles TitleH:(CGFloat)titleH ViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        _titles = titles;
        _arrVC = viewControllers;
        
        [self createTitleBarWithTitles:self.titles TitleH:(CGFloat)titleH];
        [self createPageViewController];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentIndex = 0;
    
}
#pragma mark -UI
- (void)createTitleBarWithTitles:(NSArray *)titles TitleH:(CGFloat)titleH{
    self.titleBar = ({
        SWToolBar *topBar = [[SWToolBar alloc]initWithFrame:CGRectMake(0, 0, ScreenW, titleH) ItemsName:self.titles ItemsWidth:ScreenW/self.titles.count];
        topBar.swDelegate = self;
        [self.view addSubview:topBar];
        topBar;
    });
}

- (void)createPageViewController{
    self.pageVC = ({
        UIPageViewController *pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        pageVC.view.frame = self.titleBar?CGRectMake(0, CGRectGetHeight(self.titleBar.frame), ScreenW, ScreenH - CGRectGetHeight(self.titleBar.frame)):self.view.bounds;
        [pageVC setViewControllers:@[self.arrVC[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        pageVC.delegate = self;
        pageVC.dataSource = self;
        [self.view addSubview:pageVC.view];
        [self addChildViewController:pageVC];
        pageVC;
    });
}

#pragma mark -pagevc delegate dataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.arrVC indexOfObject:viewController];
    
    if (index == 0) {
        return nil;
    }
    index --;
    NSLog(@"before%ld",index);
    return self.arrVC[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.arrVC indexOfObject:viewController];
    
    if (index == self.arrVC.count - 1) {
        return nil;
    }
    index ++;
    NSLog(@"after!%ld",index);
    return self.arrVC[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    //NSLog(@"vc index %ld",[self.arrVC indexOfObject:pageViewController.viewControllers[0]]);
   // NSLog(@"vcs~~~~~ count %ld",[self.arrVC indexOfObject:pageViewController.viewControllers[0]]);
    
    UIViewController *lastVC = self.arrVC[self.currentIndex];
    lastVC.isVisit = NO;
    
    self.currentIndex = [self.arrVC indexOfObject:pageViewController.viewControllers[0]];
    if (self.titleBar) self.titleBar.currentBtn = self.titleBar.arrBtn[self.currentIndex];
    
    UIViewController *currentVC = self.arrVC[self.currentIndex];
    currentVC.isVisit = YES;
}
#pragma mark -SWToolBar delegate
- (void)toolBarDidSelectedItemAtIndex:(NSInteger)index{
    [self.pageVC setViewControllers:@[self.arrVC[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    UIViewController *lastVC = self.arrVC[self.currentIndex];
    lastVC.isVisit = NO;
    
    self.currentIndex = index;
    
    UIViewController *currentVC = self.arrVC[self.currentIndex];
    currentVC.isVisit = YES;
}

#pragma mark -method
- (UIViewController *)currentViewController{
    return self.arrVC[self.currentIndex];
}

@end

static BOOL isVisit = NO;

@implementation UIViewController (SWTitleViewController)

- (BOOL)isVisit{
    
    return [objc_getAssociatedObject(self, &isVisit) boolValue];
}

- (void)setIsVisit:(BOOL)isVisit{
    objc_setAssociatedObject(self, &isVisit, @(isVisit), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

