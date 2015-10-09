//
//  SchoolCell.h
//  bigdemo
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolModel.h"

@protocol SchoolDeletegate <NSObject>

@optional
-(void)didSelectedAtIndex:(NSInteger) index;

@end

@interface SchoolCell : UITableViewCell


@property(nonatomic,assign)id<SchoolDeletegate> delegate;
@property(nonatomic,strong) SchoolModel  *schoolM;

@end
