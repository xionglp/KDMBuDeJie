//
//  XMGNetworkTool.h
//  BuDeJie
//
//  Created by xlp on 2018/6/6.
//  Copyright © 2018年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const budejie_api_open;

@interface XMGNetworkTool : NSObject

/**
 发送一个get请求
 */
+(void)requestTypeGetUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 发送一个POST请求
 */
+(void)requestTypePOSTUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
