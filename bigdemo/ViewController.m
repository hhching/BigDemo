//
//  ViewController.m
//  bigdemo
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "ViewController.h"
#import "ImageScrollView.h"
#import "CourseDetailViewController.h"
#import "CourseCateViewController.h"
#import "SchoolViewController.h"
#import "CourseViewController.h"

@interface ViewController ()<ImageScrollViewDelegate>
{
    NSArray *_imgetestArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _imgetestArray=@[@"http://web.img.chuanke.com/fragment/2acf901944ab8a0029b552fdd33d6adc.jpg",@"http://web.img.chuanke.com/fragment/725cf5a88b0a6904799eac3d88791344.jpg",@"http://web.img.chuanke.com/fragment/edfbc5bcc2dbaa15fce9f9397caf8834.jpg",@"http://web.img.chuanke.com/fragment/800672cfcfedfd6c923bd5b5c0f68083.jpg"];
    CGRect frame = CGRectMake(0, 64, screen_width, 150);
    ImageScrollView *imageScrollView = [[ImageScrollView alloc] initWithFrame:frame ImageArray:_imgetestArray];
     NSLog(@" 界面的 scrollview x: %f y:%f  ",imageScrollView.scrollView.contentOffset.x,imageScrollView.scrollView.contentOffset.y);
    [imageScrollView setImageArray:_imgetestArray];
    NSLog(@" 界面的 scrollview x: %f y:%f  ",imageScrollView.scrollView.contentOffset.x,imageScrollView.scrollView.contentOffset.y);

    imageScrollView.layer.borderWidth=1;
    imageScrollView.delegate = self;
    [self.view addSubview:imageScrollView];
    
    
    UIButton *cateBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageScrollView.frame)+50, screen_width-20, 30)];
    cateBtn.backgroundColor = navigationBarColor;
    [cateBtn setTitle:@"分类" forState:UIControlStateNormal];
    [cateBtn addTarget:self action:@selector(cateBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cateBtn];
    
    
    UIButton *schoolBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(cateBtn.frame)+10, screen_width-20, 30)];
    schoolBtn.backgroundColor = navigationBarColor;
    [schoolBtn setTitle:@"学校" forState:UIControlStateNormal];
    [schoolBtn addTarget:self action:@selector(schoolBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:schoolBtn];
    
    UIButton *xianBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(schoolBtn.frame)+10, screen_width-20, 30)];
    xianBtn.backgroundColor = navigationBarColor;
    [xianBtn setTitle:@"项目" forState:UIControlStateNormal];
    [xianBtn addTarget:self action:@selector(xianBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xianBtn];

}

-(void)didSelectImageAtIndex:(NSInteger)index
{
    CourseDetailViewController *cdv = [[CourseDetailViewController alloc] init];
    cdv.SID=@"1921030";
    cdv.courseId=@"146041";
    [self.navigationController pushViewController:cdv animated:YES];
}


-(void)schoolBtnTouch
{
    SchoolViewController *schoolV = [[SchoolViewController alloc] init];
    [self.navigationController pushViewController:schoolV animated:YES];
}

-(void)xianBtnTouch
{
    //1.
    CourseViewController *VC1 = [[CourseViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC1];
    UIViewController *VC2 = [[UIViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:VC2];
    UIViewController *VC3 = [[UIViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:VC3];
    VC1.title = @"课程推荐";
    VC2.title = @"我的传课";
    VC3.title = @"离线下载";
    
    //2.
    NSArray *viewCtrs = @[nav1,nav2,nav3];
    
    //3.
     UITabBarController *rootTabbarCtr = [[UITabBarController alloc] init];
     [rootTabbarCtr setViewControllers:viewCtrs animated:YES];
    
  
    
    
    [self.navigationController pushViewController:rootTabbarCtr animated:YES];
}

-(void)cateBtnTouch
{
    CourseCateViewController *cateV = [[CourseCateViewController alloc] init];
    [cateV setValue:@"feizhibo" forKey:@"cateType"];
    NSArray *nameArray = [NSArray arrayWithObjects:@"test1", @"test2",@"test3",@"test4", @"test5",@"test6", nil];
    [cateV setValue:nameArray forKey:@"cateNameArray"];
    [self.navigationController pushViewController:cateV animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //http://pop.client.chuanke.com/?mod=recommend&act=mobile&client=2&limit=20
    //http://pop.client.chuanke.com/?mod=course&act=info&do=getClassList&sid=1921030&courseid=146041&version=2.4.1.2&uid=4597633  西班牙语课程
}

@end
