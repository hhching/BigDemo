//
//  ImageScrollView.m
//  bigdemo
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "ImageScrollView.h"
#import "UIImageView+WebCache.h"
@interface ImageScrollView()<UIScrollViewDelegate>
{
    NSTimer *_timer;
    int _pageNumber;
}
@end
@implementation ImageScrollView
-(ImageScrollView*) initWithFrame:(CGRect)frame ImageArray:(NSArray *)imgArr{
    self  = [super initWithFrame:frame];
    if (self) {
        //create scrollview
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.contentSize = CGSizeMake(4*screen_width, 0);
        self.scrollView.pagingEnabled =YES;
        self.scrollView.delegate = self;
        self.scrollView.layer.borderWidth=1;
        self.scrollView.showsHorizontalScrollIndicator = NO;
       
        //add imgs
        for (int i=0; i<10; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame=CGRectMake(i*screen_width,0, screen_width, frame.size.height);
            imageView.tag=i+10;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImage:)];
            [imageView addGestureRecognizer:tap];
            imageView.layer.borderWidth=1;
            imageView.userInteractionEnabled = YES;

            
            //            当视图对象的userInteractionEnabled设置为NO的时候，用户触发的事件，如触摸，键盘等，将会被该视图忽略（其他  视图照常响应），并且该视图对象也会从事件响应队列中被移除。 当userInteractionEnabled设为YES时，则事件可以正常的传递给该视图对象。 userInteractionEnabled的属性默认值就是YES。
//            ps：响应者链是能够响应事件的对象组成的链，事件在该链上传递，最终结果事件或被处理或被抛弃。所以一个对象在不在响应者链里是其能否响应事件的首要前提条件！
            
            
            [self.scrollView addSubview:imageView];
        }
        [self addSubview:self.scrollView];
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(screen_width/2-40, frame.size.height-40, 80, 30)];
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages= 6;
        [self addSubview:self.pageControl];
       // [self addTimer];
        
    }
    NSLog(@"开头的scrollview x: %f y:%f  ",self.scrollView.contentOffset.x,self.scrollView.contentOffset.y);
    return self;
}




-(void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)nextPage
{
    int page = (int)self.pageControl.currentPage;
    if (page==_pageNumber-1) {
        page=0;
    }
    else{
        page++;
    }
    CGFloat x = page*self.scrollView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(x, 0);
}



-(void)OnTapImage:(UITapGestureRecognizer *) sender
{
    UIImageView *imageView = (UIImageView*)sender.view;
    int tag = (int)imageView.tag-10;
    [self.delegate didSelectImageAtIndex:tag];
    
}


-(void)removeTimer
{
    [_timer invalidate];
}


-(void)setImageArray:(NSArray *)imageArray
{
    _pageNumber = (int)imageArray.count;
    self.scrollView.contentSize = CGSizeMake(imageArray.count*screen_width, 0);
    self.pageControl.numberOfPages = imageArray.count;
    for (int i=0; i<imageArray.count; i++) {
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:i+10];
        imageView.backgroundColor=[UIColor redColor];
        NSString *imageName = [NSString stringWithFormat:@"%@",imageArray[i]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
        NSLog(@"%f  ",imageView.frame.origin.y);
        
    }
   
}


#pragma mark - UIScrollViewDelegate
//while scrolling
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"  scrollview x: %f y:%f  ",scrollView.contentOffset.x,scrollView.contentOffset.y);
   // self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x=scrollView.contentOffset.x;
    int page = (x+scrollViewW/2)/scrollViewW;
    self.pageControl.currentPage = page;
}

//beginning dragging
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   //[self removeTimer];
    
    NSLog(@" xx scrollview.y %f  ",scrollView.contentOffset.y);
    NSLog(@"%@",@"2");
    
}

//end dragging
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   // self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
   // [self addTimer];
    NSLog(@"%@",@"3");
}


-(void)dealloc
{
    [self removeTimer];
}


@end


//screenWidth出错主要是没有添加全聚文件  pch
