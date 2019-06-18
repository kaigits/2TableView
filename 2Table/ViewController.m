//
//  ViewController.m
//  2Table
//
//  Created by apple on 2019/6/6.
//  Copyright © 2019 zyk. All rights reserved.
//
#import "zykConfig.h"

#import "ViewController.h"
#import "ZYKMoreGestureTableView.h"
#import "CustomTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CustomTableViewCell *tempCell;
@property (nonatomic, strong) ZYKMoreGestureTableView *tvContent;
@property(nonatomic,assign) BOOL canScroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tvContent];
    
    self.canScroll = YES;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"BottomTableLeaveTopNotification" object:nil];
}
#pragma mark - Notification
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
}

#pragma mark - UIScrollViewDelagte
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottom = [self.tvContent rectForSection:1].origin.y - (IS_IPHONE_X?24:0); 
    if (scrollView.contentOffset.y>=bottom) {//当subcell还没有滚动到
        scrollView.contentOffset = CGPointMake(0, bottom);
        if (self.canScroll) {
            self.canScroll = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BottomTableScrollChangedNotification" object:nil userInfo:nil];
        }
    }else{
        if (!self.canScroll) {//子cell没到顶
            scrollView.contentOffset = CGPointMake(0, bottom);
        }
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topTable"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"topTable"];
        }
        cell.textLabel.text = @"topTable";
        return cell;
    }else{
        CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tv22"];
        if (!cell) {
            cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tv22"];
        }
        [cell loadDataWithCurrentVC:self];
        return cell;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        header.backgroundColor = [UIColor grayColor];
        return header;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return 0.001;
    }
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return CGRectGetHeight(self.view.bounds);
}

#pragma mark - init
-(ZYKMoreGestureTableView *)tvContent{
    if (!_tvContent) {
        _tvContent = [[ZYKMoreGestureTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tvContent.delegate = self;
        _tvContent.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tvContent.estimatedRowHeight = 0;
            _tvContent.estimatedSectionFooterHeight = 0;
            _tvContent.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tvContent;
}


@end


