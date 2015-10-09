//
//  SchoolModel.h
//  bigdemo
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolModel : NSObject
@property (nonatomic, strong) NSString       *SchoolName;
@property (nonatomic, strong) NSString       *PrelectNum;
@property (nonatomic, strong) NSString       *SchoolLogoUrl;
@property (nonatomic, strong) NSString       *HasCollect;
@property (nonatomic, strong) NSMutableArray *TeacherList;

@property (nonatomic, strong) NSString       *Brief;
@property (nonatomic, strong) NSString       *NickName;
@property (nonatomic, strong) NSNumber       *TotalAppraise;
@property (nonatomic, strong) NSString       *CreateTime;
@property (nonatomic, strong) NSString       *Notice;

@property (nonatomic, strong) NSString       *GoodRate;
@property (nonatomic, strong) NSString       *CourseSaleNumber;
@property (nonatomic, strong) NSString       *CollectNumber;
@property (nonatomic, strong) NSString       *StudentNumber;
@property (nonatomic, strong) NSString       *ChannelID;

@property (nonatomic, strong) NSString       *HtmlBrief;

@end
