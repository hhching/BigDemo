//
//  CourseClassCell.m
//  bigdemo
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "CourseClassCell.h"
@interface CourseClassCell()
{
    UIImageView *_imageView;
    UILabel *_classNameLabel;/**< 课程名 */
    UILabel *_classHourseLabel;/**< 课程时长 */

}
@end

@implementation CourseClassCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, 1, 64)];
        lineView.layer.borderWidth=1;
        [self addSubview:lineView];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 22, 20, 20)];
        _imageView.layer.borderWidth=1;
        _imageView.image = [UIImage imageNamed:@"course_class_study_status_not"];
        [self addSubview:_imageView];
        
        _classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, screen_width-10-50, 30)];
        _classNameLabel.font = [UIFont systemFontOfSize:15];
        _classNameLabel.layer.borderWidth=1;
        _classNameLabel.layer.borderWidth=1;
        [self addSubview:_classNameLabel];
        
        //课程时长
        _classHourseLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, screen_width-10-50, 30)];
        _classHourseLabel.textColor = [UIColor lightGrayColor];
        _classHourseLabel.font = [UIFont systemFontOfSize:13];
         _classHourseLabel.layer.borderWidth=1;
        [self addSubview:_classHourseLabel];
        
        _classNameLabel.text = [NSString stringWithFormat:@"第%@节:%@",@"1",@"熟悉HTTP5、css3，熟悉常用算法、数据结构及设计模式"];
        _classHourseLabel.text = [NSString stringWithFormat:@"课程时长：%d分钟",145/60];

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

-(void)setClassM:(ClassListModel *)classM
{
    _classM = classM;
    _classNameLabel.text = [NSString stringWithFormat:@"第%@节:%@",classM.index,classM.ClassName];
    
    int length = [classM.VideoTimeLength intValue];
    _classHourseLabel.text = [NSString stringWithFormat:@"课程时长：%d分钟",length/60];
}

@end
