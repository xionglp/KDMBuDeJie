//
//  XMGEssenceViewController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGTopicButton.h"
#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGWordViewController.h"
#import "XMGPictureViewController.h"

@interface XMGEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) XMGTopicButton *previousButton;
@property (nonatomic, strong) UIView *topicLine;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *titlesView;

@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    [self addChildVcViewIntoScrollView:0]; //默认加载第一个控制器
}

#pragma mark - 布局子控件样式
- (void)setupScrollView
{
    //不允许自动修改scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.frame = self.view.bounds;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    [self addChildViewController:[[XMGAllViewController alloc] init]];
    [self addChildViewController:[[XMGVideoViewController alloc] init]];
    [self addChildViewController:[[XMGVoiceViewController alloc] init]];
    [self addChildViewController:[[XMGPictureViewController alloc] init]];
    [self addChildViewController:[[XMGWordViewController alloc] init]];
    
    NSInteger count = self.childViewControllers.count;
    scrollView.contentSize = CGSizeMake(scrollView.xmg_width * count , 0);
}

- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.isViewLoaded) return;
    
    UIView *childVcView = childVc.view;
    CGFloat scrollViewW = self.scrollView.xmg_width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.xmg_height);
    [self.scrollView addSubview:childVcView];
}

- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    self.titlesView = titlesView;
    titlesView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    titlesView.frame = CGRectMake(0, 64, self.view.xmg_width, 35);
    [self.view addSubview:titlesView];
    
    NSArray *titleArr = @[@"全部",@"视频",@"音频",@"图片",@"段子"];
    NSInteger btnCount = titleArr.count;
    CGFloat btnW = self.view.xmg_width / btnCount;
    CGFloat btnH = titlesView.xmg_height;
    for (int i = 0; i < btnCount; i++) {
        XMGTopicButton *topicBtn = [[XMGTopicButton alloc] initWithFrame:CGRectZero];
        topicBtn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        topicBtn.tag = i;
        [topicBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [topicBtn addTarget:self action:@selector(topicButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:topicBtn];
    }
    
    //设置下划线
    XMGTopicButton *firstButton = titlesView.subviews.firstObject;
    UIView *topicLine = [[UIView alloc] init];
    self.topicLine = topicLine;
    topicLine.xmg_height = 2;
    topicLine.xmg_y = titlesView.xmg_height - topicLine.xmg_height;
    topicLine.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    [titlesView addSubview:topicLine];
    
    firstButton.selected = YES;
    self.previousButton = firstButton;
    
    [firstButton.titleLabel sizeToFit];
    topicLine.xmg_width = firstButton.titleLabel.xmg_width;
    topicLine.xmg_centerX = firstButton.xmg_centerX;
}

- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark - 自定义相应事件函数
- (void)topicButtonClick:(UIButton *)button
{
    self.previousButton.selected = NO;
    button.selected = YES;
    self.previousButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.topicLine.xmg_width = button.titleLabel.xmg_width;
        self.topicLine.xmg_centerX = button.xmg_centerX;
        
        CGFloat offSetX = self.scrollView.xmg_width * (button.tag);
        self.scrollView.contentOffset = CGPointMake(offSetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildVcViewIntoScrollView:button.tag];
    }];
}

- (void)game
{
    //打印当前函数名
    XMGFunc;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手指松开的时候调用
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    XMGTopicButton *button = self.titlesView.subviews[index];
    [self topicButtonClick:button];
}

@end
