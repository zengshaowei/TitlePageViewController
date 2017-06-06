//
//  SWViewController.m
//  TitleViewController
//
//  Created by 曾少伟 on 2016/11/21.
//  Copyright © 2016年 曾少伟. All rights reserved.
//

#import "SWViewController.h"
#import "SWTitleViewController.h"

@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 200)];
        [self.view addSubview:label];
        label;
    });
}

- (void)setIsVisit:(BOOL)isVisit{
    [super setIsVisit:isVisit];
    NSLog(@"label~%@,isvisit~%d",self.label.text,isVisit);
}
@end
