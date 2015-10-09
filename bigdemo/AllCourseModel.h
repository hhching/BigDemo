//
//  AllCourseModel.h
//  bigdemo
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllCourseModel : NSObject
@property(nonatomic, strong) NSString *CourseID;
@property(nonatomic, strong) NSString *PhotoURL;
@property(nonatomic, strong) NSString *Cost;
@property(nonatomic, strong) NSString *CourseName;
@property(nonatomic, strong) NSString *StudentNumber;

@property(nonatomic, strong) NSString *ClassNumber;
@property(nonatomic, strong) NSNumber *PrelectTime;

@end
