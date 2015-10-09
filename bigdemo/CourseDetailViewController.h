//
//  CourseDetailViewController.h
//  bigdemo
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "ViewController.h"
#import "CourseDetailModel.h"

@interface CourseDetailViewController :UIViewController

@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) NSString *SID;
@property(strong,nonatomic) NSString *courseId;

@end
