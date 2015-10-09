//
//  ImageScrollView.h
//  bigdemo
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageScrollViewDelegate<NSObject>
-(void)didSelectImageAtIndex:(NSInteger)index;
@end

@interface ImageScrollView : UIView
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) NSArray *imgArray;
@property(nonatomic,assign)id<ImageScrollViewDelegate> delegate;

-(void)setImageArray:(NSArray*)imageArray;
-(ImageScrollView*)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imgArr;

@end
