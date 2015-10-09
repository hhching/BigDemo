//
//  CourseListModel.h
//  bigdemo
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseListModel : NSObject
@property(nonatomic, strong) NSString *PhotoURL;
@property(nonatomic, strong) NSString *SID;
@property(nonatomic, strong) NSString *CourseID;
@property(nonatomic, strong) NSString *SchoolName;
@property(nonatomic, strong) NSString *CourseName;

@property(nonatomic, strong) NSString *PayEndTime;
@property(nonatomic, strong) NSString *Brief;
@property(nonatomic, strong) NSString *StudentNumber;
@property(nonatomic, strong) NSString *PayStudentLimit;
@property(nonatomic, strong) NSString *ClassNumber;

@property(nonatomic, strong) NSString *Type;
@property(nonatomic, strong) NSString *ClientType;
@property(nonatomic, strong) NSString *Sort;
@property(nonatomic, strong) NSString *CreateTime;
@property(nonatomic, strong) NSString *Pattern;

@property(nonatomic, strong) NSString *LinkURL;
@property(nonatomic, strong) NSString *ShowStartTime;
@property(nonatomic, strong) NSString *ShowEndTime;
@end
