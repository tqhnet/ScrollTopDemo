//
//  ViewController.m
//  scrollTexiaoDemo
//
//  Created by tqh on 2017/12/20.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import <MJRefresh.h>
#import "MouoChangeTopTool.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;    //列表
@property (nonatomic,strong) UIView *topView;           //顶部视图
@property (nonatomic,strong) UIView *topTabView;        //滑动后的顶部视图
@property (nonatomic,assign) BOOL topChange;            //顶部改变
@property (nonatomic,assign) BOOL start;
@property (nonatomic,strong) MouoChangeTopTool *topTool;

@end

@implementation ViewController

- (MouoChangeTopTool *)topTool {
    if (!_topTool) {
        _topTool = [[MouoChangeTopTool alloc]initWithTopView:self.topView changeTopView:self.topTabView scrollView:self.tableView];
    }
    return _topTool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"回到顶部" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemPressed)];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topTabView];
    [self.view addSubview:self.topView];

    __weak typeof(self) myself = self;
    self.topTool.changeTopBlock = ^(BOOL normal){
        if (normal) {
            myself.navigationItem.rightBarButtonItem = nil;
        }else {
            myself.navigationItem.rightBarButtonItem = right;
        }
    };
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 事件监听

- (void)rightItemPressed {
    
    [self.topTool resetWithScroll:self.tableView];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.topTool changeWithScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.topTool startScroll];
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor redColor];
        _topView.frame = CGRectMake(0, 64, SCREEN_WIDTH, TOP_HEIGHT);
    }
    return _topView;
}

- (UIView *)topTabView {
    if (!_topTabView) {
        _topTabView = [UIView new];
        _topTabView.backgroundColor = [UIColor yellowColor];
        _topTabView.frame = CGRectMake(0, 64, SCREEN_WIDTH, TOPTAB_HEIGHT);
    }
    return _topTabView;
}

@end
