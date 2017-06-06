//
//  SWTitleViewController.h
//  TitleViewController
//
//  Created by 曾少伟 on 2016/11/20.
//  Copyright © 2016年 曾少伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWToolBar.h"

@interface SWTitleViewController : UIViewController
@property (readonly,nonatomic,strong)NSArray *titles;
@property (readonly,nonatomic,strong)NSArray *arrVC;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,strong)UIPageViewController *pageVC;
@property (nonatomic,strong)SWToolBar *titleBar;
- (UIViewController *)currentViewController;

- (instancetype)initWithTitles:(NSArray *)titles TitleH:(CGFloat)titleH ViewControllers:(NSArray *)viewControllers;
@end

@interface UIViewController (SWTitleViewController)
@property (nonatomic,assign)BOOL isVisit;
@end
