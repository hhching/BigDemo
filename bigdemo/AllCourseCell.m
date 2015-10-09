//
//  AllCourseCell.m
//  bigdemo
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "AllCourseCell.h"
#import "UIImageView+WebCache.h"

@interface AllCourseCell()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_classNumLabel;
    UILabel *_studentNumLabel;
    UILabel *_priceLabel;
    
    UIImageView *_classImageV;
    UIImageView *_studentImageV;
}

@end


@implementation AllCourseCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 72, 55)];
        _imageView.layer.borderWidth=1;
        [self addSubview:_imageView];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5,screen_width-90-10, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.layer.borderWidth=1;
        [self addSubview:_titleLabel];
        
        _classImageV = [[UIImageView alloc] initWithFrame:CGRectMake(90, 33, 12, 12)];
        _classImageV.layer.borderWidth=1;
        [_classImageV setImage:[UIImage imageNamed:@"course_class_nums_icon"]];
        [self addSubview:_classImageV];
        
        _classNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 30, screen_width-10-120, 20)];
        _classNumLabel.font = [UIFont systemFontOfSize:13];
        _classNumLabel.textColor = [UIColor lightGrayColor];
        
        [self addSubview:_classNumLabel];
        
        
        _studentImageV = [[UIImageView alloc] initWithFrame:CGRectMake(90, 53, 12, 12)];
        _studentImageV.layer.borderWidth=1;
        [_studentImageV setImage:[UIImage imageNamed:@"course_studs_nums_green"]];
        [self addSubview:_studentImageV];
        
        
        _studentNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, screen_width-10-50, 20)];
        _studentNumLabel.font = [UIFont systemFontOfSize:13];
        _studentNumLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_studentNumLabel];
        
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-10-70, 30, 70, 25)];
        _priceLabel.layer.borderWidth = 1;
         _priceLabel.text = @"￥199.00";
        _priceLabel.layer.borderColor = [[UIColor orangeColor] CGColor];
        _priceLabel.layer.cornerRadius = 5;
        _priceLabel.textColor = [UIColor orangeColor];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLabel];
        
    }
    return  self;
}



-(void)setAllCourseM:(AllCourseModel *)allCourseM
{
    _allCourseM = allCourseM;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:allCourseM.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _titleLabel.text = allCourseM.CourseName;
    _classNumLabel.text = [NSString stringWithFormat:@"%@课时",allCourseM.ClassNumber];
    _studentNumLabel.text = [NSString stringWithFormat:@"%@人",allCourseM.StudentNumber];
    if ([allCourseM.Cost isEqualToString:@"0"]) {
        _priceLabel.hidden = YES;
    }else{
        NSInteger cost = [allCourseM.Cost integerValue];
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",cost/100.0];
        _priceLabel.hidden = NO;
    }

}

/**< 课程分类模块传参时用 */
-(void)setCateM:(CateModel *)CateM
{
    _CateM=CateM;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:CateM.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _titleLabel.text = CateM.CourseName;
    _classNumLabel.text = [NSString stringWithFormat:@"%@课时",CateM.ClassNumber];
    _studentNumLabel.text = CateM.SchoolName;
    
    if ([CateM.Cost isEqualToString:@"0"]) {
        _priceLabel.hidden = YES;
    }else{
        NSInteger cost = [CateM.Cost integerValue];
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",cost/100.0];
        _priceLabel.hidden = NO;
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
