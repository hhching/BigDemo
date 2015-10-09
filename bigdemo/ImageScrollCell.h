//
//  ImageScrollCell.h
//  bigdemo
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface ImageScrollCell : UITableViewCell

@property(nonatomic,strong)ImageScrollView *imageScrollView;
@property(nonatomic,strong)NSArray *imageArr;

-(void)setImageArray:(NSArray *)imageArray;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

@end
