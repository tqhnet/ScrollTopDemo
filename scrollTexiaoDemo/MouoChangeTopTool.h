//
//  MouoChangeTopTool.h
//  scrollTexiaoDemo
//
//  Created by tqh on 2017/12/20.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//最初顶部视图高度
#define TOP_HEIGHT 100
//改变后顶部视图高度
#define TOPTAB_HEIGHT 50

/**改变顶部视图工具（特效）*/
@interface MouoChangeTopTool : NSObject

@property (nonatomic,assign) CGFloat offsetTop;                     //偏移
@property (nonatomic,copy) void (^changeTopBlock)(BOOL normal);     //改变时的回调

- (instancetype)initWithTopView:(UIView *)view changeTopView:(UIView *)changeTopView scrollView:(UIScrollView *)scrollView;

//开始拖拽的时候
- (void)startScroll;

//滚动
- (void)changeWithScroll:(UIScrollView *)scrollView;

//重置
- (void)resetWithScroll:(UIScrollView *)scrollView;

@end
