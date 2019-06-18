//
//  BottomTableViewController.m
//  2Table
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 zyk. All rights reserved.
//

#import "zykConfig.h"
#import "BottomTableViewController.h"
NSString *const BottomTableScrollChangedNotification = @"BottomTableScrollChangedNotification";
NSString *const BottomTableLeaveTopNotification = @"BottomTableLeaveTopNotification";

@interface BottomTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) UITableView * tvContent;

@end

@implementation BottomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self.view addSubview:self.tvContent];
    CGFloat topHeight = (IS_IPHONE_X?24:0) + 100;
    CGFloat height = SCREEN_HEIGHT - topHeight;
    [self.tvContent setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    
    //滚动处理
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus:) name:BottomTableScrollChangedNotification object:nil];
}

#pragma mark - Notification
-(void)changeScrollStatus:(NSNotification *)objc
{
    _canScroll = YES;
}

#pragma mark - 关键代码
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.canScroll == NO)
    {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0)
    {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:BottomTableLeaveTopNotification object:nil];
    }
}

#pragma mark - UITableViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *region_Cell = @"MyCell";

     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:region_Cell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:region_Cell];

    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
     return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


#pragma mark - init
-(UITableView *)tvContent{
    if (!_tvContent) {
        _tvContent = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        _tvContent.delegate = self;
        _tvContent.dataSource = self;
    }
    return _tvContent;
}
@end
