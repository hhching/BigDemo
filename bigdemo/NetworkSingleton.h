//
//  NetworkSingleton.h
//  bigdemo
//
//  Created by apple on 15/8/15.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define TIMEOUT 30
typedef void(^SuccessBlock) (id responseBody) ;
typedef void(^FailureBlock)(NSString *error);


@interface NetworkSingleton : NSObject
+(NetworkSingleton *)shareManager;
-(AFHTTPRequestOperationManager *)baseHttpRequest;

#pragma mark - 获取推荐课程
-(void)getRecommendCourseResult:(NSDictionary*) userInfo url:(NSString*)url successBlock:(SuccessBlock)successblock failureBlock:(FailureBlock) failureBlock;

#pragma mark - 获取课程详情
-(void)getClassListResult:(NSDictionary *) userInfo url:(NSString*)url successBlock:(SuccessBlock) successblock failureBlock:(FailureBlock) failureBlock;

#pragma mark - 获取课程评价
-(void)getClassEvalResult:(NSDictionary *) userInfo url:(NSString*)url successBlock:(SuccessBlock) successblock failureBlock:(FailureBlock) failureBlock;

#pragma mark - Get
-(void)getDataResult:(NSDictionary *) userInfo url:(NSString*) url successBlock:(SuccessBlock) successblock failureBlock:(FailureBlock) failureBlock;

#pragma mark - 获取搜索课程信息
-(void)getSearchResult:(NSDictionary *) userInfo url:(NSString*) url successBlock:(SuccessBlock) successblock failureBlock:(FailureBlock) failureBlock;


@end
