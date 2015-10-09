//
//  CourseCateViewController.h
//  bigdemo
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCateViewController : UIViewController

@property(nonatomic,strong) UITableView *tableView;


//两种类型都必须传的类型
@property(nonatomic,strong) NSString *cateType;//课程类型


//非直播必要传的参数
@property(nonatomic,strong) NSMutableArray *cateNameArray;//课程名数组
@property(nonatomic, strong) NSMutableArray *cateIDArray; //课程ID数组
@end
