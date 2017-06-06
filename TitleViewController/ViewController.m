//
//  ViewController.m
//  TitleViewController
//
//  Created by 曾少伟 on 2016/11/20.
//  Copyright © 2016年 曾少伟. All rights reserved.
//

#import "ViewController.h"
#import "SWTitleViewController.h"
#import "SWViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)action:(id)sender {
    SWViewController *firstVC = [SWViewController new];
    firstVC.view.backgroundColor = [UIColor yellowColor];
    firstVC.label.text = @"1";
    SWViewController *secondVC = [SWViewController new];
    secondVC.view.backgroundColor = [UIColor redColor];
    secondVC.label.text = @"2";
    SWViewController *thirdVC = [SWViewController new];
    thirdVC.view.backgroundColor = [UIColor greenColor];
    NSArray *arrVC = @[firstVC,secondVC,thirdVC];
    thirdVC.label.text = @"3";
    
    SWTitleViewController *titleVC = [[SWTitleViewController alloc]initWithTitles:@[@"1",@"2",@"3"] TitleH:64 ViewControllers:arrVC];
    [self presentViewController:titleVC animated:YES completion:nil];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
