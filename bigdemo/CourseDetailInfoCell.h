//
//  CourseDetailInfoCell.h
//  bigdemo
//
//  Created by apple on 15/8/22.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
@protocol CourseDetailInfoDelegate<NSObject>
-(void)didSelectSchool;
@end

@interface CourseDetailInfoCell : UITableViewCell

@property(nonatomic,strong) CourseDetailModel *CourseDM;

@property(nonatomic,assign) id<CourseDetailInfoDelegate> delegate;

@end
