//
//  NetworkSingleton.m
//  bigdemo
//
//  Created by apple on 15/8/15.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "NetworkSingleton.h"


@implementation NetworkSingleton
+(NetworkSingleton *)shareManager{
    static NetworkSingleton *shareNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        shareNetworkSingleton = [[self alloc] init];
    
    });

    return shareNetworkSingleton;
}

-(AFHTTPRequestOperationManager *)baseHttpRequest{
  
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/json" ,nil];
    return manager;


}


#pragma mark -获取推荐课程内容
-(void)getRecommendCourseResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successblock failureBlock:(FailureBlock)failureBlock{

    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];

}


#pragma mark - 获取课程详情
-(void)getClassListResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successblock failureBlock:(FailureBlock)failureBlock{
    
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString * urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];

}

#pragma mark - 获取课程评价

-(void)getClassEvalResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successblock failureBlock:(FailureBlock)failureBlock{

    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorStr=[error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }]; 
}


#pragma mark - Get
-(void)getDataResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successblock failureBlock:(FailureBlock)failureBlock{
    
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation,id responseObject){successblock(responseObject);} failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);}];
    
}
#pragma mark - 获取搜索课程信息
-(void)getSearchResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successblock failureBlock:(FailureBlock)failureBlock{
    
    AFHTTPRequestOperationManager *manager =  [ self baseHttpRequest];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation,id responseObject){successblock(responseObject);}
         failure:^(AFHTTPRequestOperation *opeation ,NSError *error){
    
             NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
             failureBlock(errorStr);
    
    }];
    

}
@end
