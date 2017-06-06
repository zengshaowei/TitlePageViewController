//
//  SWToolBar.h
//  EnjoyEasy
//
//  Created by 腾程－ios1 on 16/11/2.
//  Copyright © 2016年 腾程－zsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWToolBarDelegate <NSObject>
@required
- (void)toolBarDidSelectedItemAtIndex:(NSInteger)index;
@end

@interface SWToolBar : UIView
@property (nonatomic,strong)UIImage *barImg;
@property (nonatomic,strong)UIScrollView *scrView;
@property (nonatomic,strong)NSMutableArray *arrBtn;
/**  */
@property (nonatomic,strong)NSMutableArray *itemImages;
@property (nonatomic,strong)NSMutableArray *seletedItemImages;
@property (nonatomic,assign)UIEdgeInsets edgeInsets;
@property (nonatomic,strong)UIButton *currentBtn;
@property (nonatomic,assign)NSInteger currentBtnIndex;
/** */
@property (nonatomic,strong)UIImageView *movingV;
@property (nonatomic,assign)id <SWToolBarDelegate>swDelegate;

- (instancetype)initWithFrame:(CGRect)frame ItemCount:(NSInteger)count ItemsImageName:(NSArray *)imgNames ItemsWidth:(CGFloat)itemsWidth;
- (instancetype)initWithFrame:(CGRect)frame ItemsName:(NSArray *)Names ItemsWidth:(CGFloat)itemsWidth;
@end
