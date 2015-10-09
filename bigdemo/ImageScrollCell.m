//
//  ImageScrollCell.m
//  bigdemo
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "ImageScrollCell.h"

@implementation ImageScrollCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.imageScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 180) ImageArray:self.imageArr];
        [self.contentView addSubview:self.imageScrollView];
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height) ImageArray:self.imageArr];
        [self.contentView addSubview:self.imageScrollView];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImageArray:(NSArray *)imageArray{
    [self.imageScrollView setImageArray:imageArray];
}


-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    [self setImageArray:imageArr];
}

@end
