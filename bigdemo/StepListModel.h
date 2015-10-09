//
//  StepListModel.h
//  bigdemo
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StepListModel : NSObject
@property(nonatomic, strong) NSString *StepID;
@property(nonatomic, strong) NSString *StepIndex;
@property(nonatomic, strong) NSString *StepName;
@property(nonatomic, strong) NSMutableArray *ClassList;
@end
