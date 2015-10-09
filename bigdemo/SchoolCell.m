//
//  SchoolCell.m
//  bigdemo
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "SchoolCell.h"
#import "UIImageView+WebCache.h"

@interface SchoolCell()
{
    UIImageView *_bigImageView;
    UIImageView *_smallImageView;
    
    UIView  *_backView1;
    UIView  *_backView2;
    UIView *_backView3;
    UIView *_backView4;
    
    UILabel *_kechengLabel;
    UILabel *_zhiboLabel;
}

@end

@implementation SchoolCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(246, 246, 246);
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210-screen_width, screen_width, screen_width)];
        _bigImageView.layer.borderWidth=1;
        [_bigImageView setImage:[UIImage imageNamed:@"school_pic9.jpg"]];
        [self addSubview:_bigImageView];
        
        _smallImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 210-30, 60, 60)];
        _smallImageView.layer.cornerRadius = 5;
        _smallImageView.layer.masksToBounds = YES;
        _smallImageView.layer.borderWidth=1;
        [self addSubview:_smallImageView];
        
        

        float minx = 70;
        float width = (screen_width-minx)/4;
        _backView1 = [[UIView alloc] initWithFrame:CGRectMake(minx, 210, width, 56)];
        _backView1.layer.borderWidth=1;
        [self addSubview:_backView1];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapCourse)];
        [_backView1 addGestureRecognizer:tap1];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, width, 20)];
        label1.textColor=[UIColor lightGrayColor];
        label1.text=@"课程";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.layer.borderWidth=1;
        [_backView1 addSubview:label1];
        
        
        _kechengLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, 20)];
        _kechengLabel.text=@"1";
        _kechengLabel.textAlignment = NSTextAlignmentCenter;
        _kechengLabel.font = [UIFont systemFontOfSize:13];
        _kechengLabel.layer.borderWidth=1;
        [_backView1 addSubview:_kechengLabel];
        
        _backView2 = [[UIView alloc] initWithFrame:CGRectMake(minx+width, 210, width, 56)];
        _backView2.layer.borderWidth=1;
        [self addSubview:_backView2];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, width, 20)];
        label2.textColor=[UIColor lightGrayColor];
        label2.text=@"直播";
        label2.textAlignment = NSTextAlignmentCenter;
        label2.layer.borderWidth=1;
        [_backView2 addSubview:label2];
        
        
        _zhiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, 20)];
        _zhiboLabel.text=@"4";
        _zhiboLabel.textAlignment = NSTextAlignmentCenter;
        _zhiboLabel.font = [UIFont systemFontOfSize:13];
        _zhiboLabel.layer.borderWidth=1;
        [_backView2 addSubview:_zhiboLabel];

        
        
        _backView3= [[UIView alloc] initWithFrame:CGRectMake(minx+width*2, 210, width, 56)];
        _backView3.layer.borderWidth=1;
        [self addSubview:_backView3];
        
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, width, 20)];
        label3.text=@"分享";
        label3.layer.borderWidth=1;
        label3.textAlignment=NSTextAlignmentCenter;
        [_backView3 addSubview:label3];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(width/2-27, 0, 55, 55);
        btn1.layer.borderWidth=1;
        [_backView3 addSubview:btn1];
    
        
        
        
        
        _backView4 = [[UIView alloc] initWithFrame:CGRectMake(minx+width*3, 210, width, 56)];
        _backView4.layer.borderWidth=1;
        [self addSubview:_backView4];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, width, 20)];
        label4.text=@"放到桌面";
        label4.layer.borderWidth=1;
        label4.textAlignment=NSTextAlignmentCenter;
        [_backView4 addSubview:label4];

        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(width/2-27, 0, 55, 55);
        btn2.layer.borderWidth=1;
        [_backView4 addSubview:btn2];

        
        
        
        
        
        
    }
    return self;
}

-(void)OnTapCourse{
    [self.delegate didSelectedAtIndex:0];
}

-(void)OnTapOnline{
    if ([_schoolM.PrelectNum isEqualToString:@"0"]) {
        return;
    }
    [self.delegate didSelectedAtIndex:1];
}


-(void)OnTapBtn1{
    [self.delegate didSelectedAtIndex:2];
}
-(void)OnTapBtn2{
    [self.delegate didSelectedAtIndex:3];
}

-(void)setSchoolM:(SchoolModel *)schoolM
{
    _schoolM  = schoolM;
    [_smallImageView sd_setImageWithURL:[NSURL URLWithString:_schoolM.SchoolLogoUrl] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _kechengLabel.text=_schoolM.CourseSaleNumber;
    _zhiboLabel.text=_schoolM.PrelectNum;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
