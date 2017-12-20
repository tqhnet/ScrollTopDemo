//
//  MouoChangeTopTool.m
//  scrollTexiaoDemo
//
//  Created by tqh on 2017/12/20.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "UIView+Extension.h"
#import "MouoChangeTopTool.h"

@interface MouoChangeTopTool()

@property (nonatomic,assign) BOOL topChange;            //顶部改变
@property (nonatomic,assign) BOOL start;

@property (nonatomic,weak) UIView *topView;
@property (nonatomic,weak) UIView *topChangeView;
@property (nonatomic,weak) UIScrollView *scrollView;

@end

@implementation MouoChangeTopTool

- (instancetype)initWithTopView:(UIView *)view changeTopView:(UIView *)changeTopView scrollView:(UIScrollView *)scrollView {
    self = [super init];
    if (self) {
        self.offsetTop = 64;
        self.topView = view;
        self.topChangeView = changeTopView;
        self.scrollView = scrollView;
        self.scrollView.contentInset = UIEdgeInsetsMake(TOP_HEIGHT, 0, 0, 0);
    }
    return self;
}

- (void)startScroll {
    self.start = YES;
}
- (void)resetWithScroll:(UIScrollView *)scrollView {
    self.topView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.topView.y = self.offsetTop;
        scrollView.contentInset = UIEdgeInsetsMake(TOP_HEIGHT, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.topChange = NO;
        if (self.changeTopBlock) {
            self.changeTopBlock(YES);
        }
    }];
}

- (void)changeWithScroll:(UIScrollView *)scrollView {
    CGFloat f = -scrollView.contentOffset.y;
    
    if (self.topChange) {
        return;
    }
    
    if (f < TOP_HEIGHT + self.offsetTop) {
        self.topView.y = f - TOP_HEIGHT;
    }else {
        self.topView.y = self.offsetTop;
    }
    
    if (!self.start) {
        return;
    }
    if (f <= TOPTAB_HEIGHT+self.offsetTop) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.topView.y = -TOP_HEIGHT;
            scrollView.contentInset = UIEdgeInsetsMake(TOPTAB_HEIGHT, 0, 0, 0);
        } completion:^(BOOL finished) {
            self.topView.hidden = YES;
            if (self.changeTopBlock) {
                self.changeTopBlock(NO);
            }
        }];
        self.topChange = YES;
    }
}

@end
