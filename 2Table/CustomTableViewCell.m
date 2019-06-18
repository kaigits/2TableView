//
//  CustomTableViewCell.m
//  2Table
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 zyk. All rights reserved.
//

#import "zykConfig.h"
#import "CustomTableViewCell.h"
#import "BottomTableViewController.h"

@interface CustomTableViewCell() 
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) BottomTableViewController * bottomVC;
@end

@implementation CustomTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.whiteColor;
        [self configContentView];
    }
    return self;
}

- (void)configContentView{
    if (!_scrollView) {
        self.scrollView = [UIScrollView new];
        self.scrollView.bounces = NO;
        CGFloat topHeight = (IS_IPHONE_X?24:0) + 100;
        CGFloat height = SCREEN_HEIGHT - topHeight;
        [self.scrollView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        [self addSubview:self.scrollView];
    }
}

- (void)loadDataWithCurrentVC:(UIViewController *)currentViewController
{
    if (!_bottomVC) {
        //可配置多个
        self.bottomVC = [[BottomTableViewController alloc] init];
        [currentViewController addChildViewController:self.bottomVC];
        [self.scrollView addSubview:self.bottomVC.view];
    }
}

 
@end
