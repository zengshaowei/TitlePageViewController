//
//  SWToolBar.m
//  EnjoyEasy
//
//  Created by 腾程－ios1 on 16/11/2.
//  Copyright © 2016年 腾程－zsw. All rights reserved.
//

#import "SWToolBar.h"

@implementation SWToolBar
{
    NSInteger _count;
    CGFloat _itemWidth;
    UIImageView *_barImgView;
}

- (instancetype)initWithFrame:(CGRect)frame ItemCount:(NSInteger)count ItemsImageName:(NSArray *)imgNames ItemsWidth:(CGFloat)itemsWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _count = count;
        _itemWidth = itemsWidth;
        [self imgNameChangeToImgWithImgNames:imgNames];

        [self createSubViews];
        self.currentBtn = _arrBtn[0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame ItemsName:(NSArray *)Names ItemsWidth:(CGFloat)itemsWidth{
    if (self = [super initWithFrame:frame]){
        _count = Names.count;
        _itemWidth = itemsWidth;
        [self createSubViews];
        [self setBtnTitles:Names];
        self.currentBtnIndex = 0;
        self.currentBtn = self.arrBtn[self.currentBtnIndex];
    }
    return self;
}
#pragma mark - private methed
- (void)createSubViews{
    _scrView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scrView];
    
    for (int i = 0 ; i < _count ; i ++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * _itemWidth, 0,_itemWidth,CGRectGetHeight(self.frame));
        btn.tag = 3100 + i;
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(selectedItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrView addSubview:btn];
        
        _scrView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), CGRectGetHeight(self.frame));
        [self.arrBtn addObject:btn];
    }
    // 游标
    _movingV = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.scrView.frame) - 1, _itemWidth-30, 1)];
    _movingV.backgroundColor = [UIColor grayColor];
    [self.scrView addSubview:_movingV];
    
    for (int i = 0; i < _itemImages.count ; i ++){
        [_arrBtn[i] setImage:_itemImages[i] forState:UIControlStateNormal];
    }
}

- (void)setBtnTitles:(NSArray *)Names{
    int i = 0;
    for (UIButton *btn in self.arrBtn) {
        [btn setTitle:Names[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        i ++;
    }
}

- (void)imgNameChangeToImgWithImgNames:(NSArray *)imgNames{
    for (NSString *imgName in imgNames) {
        [self.itemImages addObject:[UIImage imageNamed:imgName]];
        UIImage *selectedImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imgName]];
        [self.seletedItemImages addObject:selectedImg];
    }
}

#pragma mark - lazy
- (NSMutableArray *)arrBtn{
    if (!_arrBtn){
        _arrBtn = [NSMutableArray new];
    }
    return _arrBtn;
}

- (NSMutableArray *)itemImages{
    if (!_itemImages){
        _itemImages = [NSMutableArray new];
    }
    return _itemImages;
}

- (NSMutableArray *)seletedItemImages{
    if (!_seletedItemImages){
        _seletedItemImages = [NSMutableArray new];
    }
    return _seletedItemImages;
}

- (void)setCurrentBtn:(UIButton *)currentBtn{
    [_currentBtn setImage:_itemImages[_currentBtnIndex] forState:UIControlStateNormal];
    
    _currentBtn = currentBtn;
    _currentBtnIndex = currentBtn.tag - 3100;
    [_currentBtn setImage:_seletedItemImages[_currentBtnIndex] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.25 animations:^{
        _movingV.center = CGPointMake(currentBtn.center.x, _movingV.center.y);
    }];
}

- (void)setBarImg:(UIImage *)barImg{
    _barImg = barImg;
    if (!_barImgView){
        _barImgView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self insertSubview:_barImgView belowSubview:_scrView];
    }
    _barImgView.image = _barImg;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    _edgeInsets = edgeInsets;
    for (UIButton *btn in _arrBtn) {
        btn.imageEdgeInsets = edgeInsets;
    }
}

#pragma mark - events
- (void)selectedItemAction:(UIButton *)sender{
    self.currentBtn = sender;
    self.currentBtnIndex = sender.tag - 3100;
    [self.swDelegate toolBarDidSelectedItemAtIndex:_currentBtnIndex];
}

@end
