//
//  XMGNetworkTool.m
//  BuDeJie
//
//  Created by xlp on 2018/6/6.
//  Copyright © 2018年 小码哥. All rights reserved.
//  封装一个请求工具类

#import "XMGNetworkTool.h"
#import "AFNetworking.h"

NSString * const budejie_api_open = @"http://api.budejie.com/api/api_open.php";

@implementation XMGNetworkTool

+(void)requestTypeGetUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    //1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.发送get请求
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
};

+(void)requestTypePOSTUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    //1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.发送POST请求
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
