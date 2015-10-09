//
//  CourseCell.m
//  bigdemo
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "CourseCell.h"
#import "UIImageView+WebCache.h"
@interface CourseCell()
{
    UIImageView *_imageView;/**< 图 */
    UILabel *_titleLabel;/**< 大标题 */
    UILabel *_subtitleLabel;/**< 小标题 */
}
@end

@implementation CourseCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 52)];
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, screen_width-100, 30)];
    [self addSubview:_titleLabel];
    
     _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, screen_width-100, 40)];
    _subtitleLabel.font = [UIFont systemFontOfSize:13];
    _subtitleLabel.textColor = [UIColor lightGrayColor];
    _subtitleLabel.numberOfLines = 2;
    [self addSubview:_subtitleLabel];

    
}

-(void)setJzCourseM:(CourseListModel *)jzCourseM
{
    _jzCourseM = jzCourseM;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:jzCourseM.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _titleLabel.text = jzCourseM.CourseName;
    _subtitleLabel.text = jzCourseM.Brief;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
