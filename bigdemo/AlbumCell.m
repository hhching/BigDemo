//
//  AlbumCell.m
//  bigdemo
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "AlbumCell.h"
#import "UIImageView+WebCache.h"

@interface AlbumCell ()
{
    UIScrollView *_scrollView;
}
@end
@implementation AlbumCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 0, frame.size.width, frame.size.height)];
         _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        for (int i = 0; i < 10; ++i) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width*2/5+5)*i, 5, screen_width*2/5, frame.size.height-10)];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 5;
            //            [imageView setImage:[UIImage imageNamed:@"lesson_default"]];
            imageView.tag = i+20;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImage:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:imageView];
        }
    }
    return self;
}

-(void)setImgurlArray:(NSArray *)imgurlArray
{
    _scrollView.contentSize = CGSizeMake((screen_width*2/5+5)*imgurlArray.count+5, _scrollView.frame.size.height);
    for (int i = 0; i < imgurlArray.count; i++) {
        UIImageView *imageView = (UIImageView *)[_scrollView viewWithTag:20+i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgurlArray[i]] placeholderImage:[UIImage imageNamed:@"lesson_default"]];


        }
}

-(void)OnTapImage:(UITapGestureRecognizer *)sender{
    UIImageView *imageView = (UIImageView *)sender.view;
    int tag = (int)imageView.tag-20;
    [self.delegate didSelectedAlbumAtIndex:tag];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
