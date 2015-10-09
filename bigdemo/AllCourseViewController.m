//
//  AllCourseViewController.m
//  bigdemo
//
//  Created by apple on 15/10/5.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "AllCourseViewController.h"
#import "NetworkSingleton.h"
#import "AllCourseModel.h"
#import "MJExtension.h"
#import "AllCourseCell.h"
#import "CourseDetailViewController.h"

@interface AllCourseViewController()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArray;
    
}

@end

@implementation AllCourseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataSourceArray = [[NSMutableArray alloc] init];
    [self setNav];
    [self initTableview];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getAllCourseData];
    });
    
}
-(void)setNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"file_tital_back_but"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-60, 20, 120, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"学校课程";
    [backView addSubview:titleLabel];
    

}


-(void)initTableview{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}


-(void)getAllCourseData{
    NSString *urlStr = [NSString stringWithFormat:@"http://pop.client.chuanke.com/?mod=school&act=info&do=%@&sid=%@&uid=%@",self.DO,self.SID,UID];
    [[NetworkSingleton shareManager] getDataResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"请求所有课程成功");
        NSMutableArray *dataArray = responseBody;
        for (int i = 0; i < dataArray.count; i++) {
            AllCourseModel *jzAllCourseM = [AllCourseModel objectWithKeyValues:dataArray[i]];
            [_dataSourceArray addObject:jzAllCourseM];
        }
        
        [self.tableView reloadData];
        
    } failureBlock:^(NSString *error){
        NSLog(@"请求所有课程失败：%@",error);
    }];
}

-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"allcourseCell";
    AllCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[AllCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 73.5, screen_width, 0.5)];
        lineView.backgroundColor = separaterColor;
        [cell addSubview:lineView];
    }
    
    AllCourseModel *jzAllCourseM = _dataSourceArray[indexPath.row];
    [cell setAllCourseM:jzAllCourseM];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    //    if ([self.DO isEqualToString:@"courseList"]) {//所有课程
    //
    //    }else{//所有直播课程
    //
    //    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AllCourseModel *jzAllCourseM = _dataSourceArray[indexPath.row];
    CourseDetailViewController *jzCourseDVC = [[CourseDetailViewController alloc] init];
    jzCourseDVC.SID = self.SID;
    jzCourseDVC.courseId = jzAllCourseM.CourseID;
    [self.navigationController pushViewController:jzCourseDVC animated:YES];
}

@end
