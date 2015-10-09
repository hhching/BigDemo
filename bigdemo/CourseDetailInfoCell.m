//
//  CourseDetailInfoCell.m
//  bigdemo
//
//  Created by apple on 15/8/22.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "CourseDetailInfoCell.h"
#import <UIImageView+WebCache.h>

@interface CourseDetailInfoCell ()
{
    UIImageView *_imageView;
    UILabel *_courseLabel;
    UILabel *_priceLabel;
    UILabel *_numLabel;
    UILabel *_schoolLabel;
    UIImageView *_numsImageView;
}

@end
@implementation CourseDetailInfoCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = navigationBarColor;
        [self initViews];
    }
    return self;
}



-(void)initViews
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 52)];
    [self addSubview:_imageView];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"http://web.img.chuanke.com/course/2015-08/11/3af741b82ad89d97b9c3982bb9c67ab3.jpg" ] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    
    _courseLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, screen_width-100, 20)];
    _courseLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_courseLabel];
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageView.frame)+10, 80, 30)];
    _priceLabel.layer.borderWidth=1;
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_priceLabel];
    
    
    _numsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame)+10, CGRectGetMaxY(_imageView.frame)+15, 18, 18)];
    _numsImageView.layer.borderWidth=1;
    [_numsImageView setImage:[UIImage imageNamed:@"course_studs_nums"]];
    [self addSubview:_numsImageView];
    
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numsImageView.frame)+5, CGRectGetMaxY(_imageView.frame)+10, 50, 30)];
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.font=[UIFont systemFontOfSize:15];
    _numLabel.layer.borderWidth=1;
    _numLabel.text=@"78人";
    [self addSubview:_numLabel];
    
    _schoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-130-20, CGRectGetMaxY(_imageView.frame)+10, 130, 25)];
    
    _schoolLabel.layer.borderWidth=1;
    _schoolLabel.layer.cornerRadius = 3;
    _schoolLabel.textColor = [UIColor whiteColor];
    _schoolLabel.layer.masksToBounds = YES;
    _schoolLabel.userInteractionEnabled = YES;
    _schoolLabel.font = [UIFont systemFontOfSize:13];
    _schoolLabel.layer.borderColor = [RGB(46, 158, 138) CGColor];
    [self addSubview:_schoolLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapSchoolLabel)];
    [_schoolLabel addGestureRecognizer:tap];
    UIImageView *arrowImageview = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_schoolLabel.frame)-13, CGRectGetMinY(_schoolLabel.frame), 13, 25)];
    [arrowImageview setImage:[UIImage imageNamed:@"course_school_classify_icon"]];
    [self addSubview:arrowImageview];

    
    
}


-(void)setCourseDM:(CourseDetailModel *) CourseDM
{
    _CourseDM = CourseDM;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:CourseDM.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    NSLog(@"%@",CourseDM.PhotoURL);
    _courseLabel.text=CourseDM.CourseName;
    _numLabel.text = [NSString stringWithFormat:@"%@人",CourseDM.StudentNumber];
    _schoolLabel.text = [NSString stringWithFormat:@"  %@",CourseDM.SchoolName];

    if ([_CourseDM.Cost isEqualToString:@"0"]) {
        _priceLabel.text=@"¥免费";
        
    }
    else
    {
        int cost = [_CourseDM.Cost intValue];
        _priceLabel.text= [NSString stringWithFormat:@"¥%.2f",cost/100.0];
    }
    
}


-(void)OnTapSchoolLabel{
    
    [self.delegate didSelectSchool];
}

@end
