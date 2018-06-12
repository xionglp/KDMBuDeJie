//
//  XMGMeViewController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGSettingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGSquareItem.h"
#import <MJExtension/MJExtension.h>
#import "XMGSquareCell.h"
#import "XMGWebViewController.h"
#import "XMGNetworkTool.h"

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (XMGScreenW - (cols - 1) * margin) / cols
@interface XMGMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation XMGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupFootView];
    
    [self loadData];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

#pragma mark - 请求数据
- (void)loadData
{
    // 2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [XMGNetworkTool requestTypeGetUrl:budejie_api_open parameters:parameters success:^(id responseObject) {
        
        NSArray *dictArr = responseObject[@"square_list"];
        _squareItems = [XMGSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        [self resloveData];

        // 设置collectionView 计算collectionView高度 = rows * itemWH
        // Rows = (count - 1) / cols + 1  3 cols4
        NSInteger count = _squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        // 设置collectioView高度
        self.collectionView.xmg_height = rows * (itemWH+1);

        // 设置tableView滚动范围:自己计算
        self.tableView.tableFooterView = self.collectionView;
        // 刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
    }];
}

- (void)resloveData
{
    // 判断下缺几个,补齐更美观
    // 3 % 4 = 3 cols - 3 = 1
    // 5 % 4 = 1 cols - 1 = 3
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            XMGSquareItem *item = [[XMGSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
}

#pragma mark - 设置tableView底部视图
- (void)setupFootView{
    
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"XMGSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGSquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    
    XMGWebViewController *webVc = [[XMGWebViewController alloc] init];
    webVc.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.squareItems[indexPath.row];
    return cell;
}

- (void)setupNavBar
{
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];

    self.navigationItem.title = @"我的";
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
}

- (void)night:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)setting
{
    XMGSettingViewController *settingVc = [[XMGSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}

// 跳转界面 push 展示网页
/*
 1.Safari openURL :自带很多功能(进度条,刷新,前进,倒退等等功能),必须要跳出当前应用
 2.UIWebView (没有功能) ,在当前应用打开网页,并且有safari,自己实现,UIWebView不能实现进度条
 3.SFSafariViewController:专门用来展示网页 需求:即想要在当前应用展示网页,又想要safari功能 iOS9才能使用
 3.1 导入#import <SafariServices/SafariServices.h>
 
 4.WKWebView:iOS8 (UIWebView升级版本,添加功能 1.监听进度 2.缓存)
 4.1 导入#import <WebKit/WebKit.h>
 
 */

@end
