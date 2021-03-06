//
//  XMGSubTagViewController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/15.
//  Copyright © 2016年 小码哥. All rights reserved.
//  修改文件

#import "XMGSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "XMGSubTagCell.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "XMGNetworkTool.h"

static NSString * const ID = @"cell";

@interface XMGSubTagViewController ()
@property (nonatomic, strong) NSArray *subTags;
//@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@end

@implementation XMGSubTagViewController

// 接口文档: 请求url(基本url+请求参数) 请求方式
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 展示标签数据 -> 请求数据(接口文档) -> 解析数据(写成Plist)(image_list,sub_number,theme_name) -> 设计模型 -> 字典转模型 -> 展示数据
    [self loadData];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.title = @"推荐标签";
    
    // 处理cell分割线 1.自定义分割线 2.系统属性(iOS8才支持) 3.万能方式(重写cell的setFrame) 了解tableView底层实现了解 1.取消系统自带分割线 2.把tableView背景色设置为分割线的背景色 3.重写setFrame
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 220 220 221
    self.tableView.backgroundColor = XMGColor(220, 220, 221);
    
    // 提示用户当前正在加载数据 SVPro
    [SVProgressHUD showWithStatus:@"正在加载ing....."];
}
// 界面即将消失调用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

#pragma mark - 请求数据
- (void)loadData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    // 3.发送请求
    [XMGNetworkTool requestTypeGetUrl:budejie_api_open parameters:parameters success:^(id responseObject) {
        [SVProgressHUD dismiss];
        // 字典数组转换模型数组
        _subTags = [XMGSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    XMGSubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
