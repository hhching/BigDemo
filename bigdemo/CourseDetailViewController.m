//
//  CourseDetailViewController.m
//  bigdemo
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseDetailInfoCell.h"
#import "NetworkSingleton.h"


#import "MJRefresh.h"
#import "MJExtension.h"
#import "CourseClassCell.h"
#import "SchoolViewController.h"


#import "KRVideoPlayerController.h"
#import "ClassListModel.h"
#import "StepListModel.h"
#import "SVProgressHUD.h"


@interface CourseDetailViewController()<UITableViewDataSource,UITableViewDelegate,CourseDetailInfoDelegate>
{
    CourseDetailModel *_CourseDM;
    NSMutableArray *_dataSourceArray;
    
}
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@end


@implementation CourseDetailViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self= [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)viewDidLoad
{
    //[self loadNewData];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
   
    [self setNav];
    [self initData];
    [self initTableView];
    
    
    
}
-(void)initData{
    _dataSourceArray = [[NSMutableArray alloc] init];
}
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width,screen_height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    _tableView.layer.borderWidth=1;
    [self setuptableview];
    
    
   
}


-(void)setNav
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = navigationBarColor;
    backView.layer.borderWidth=1;
    [self.view addSubview:backView];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"file_tital_back_but"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.layer.borderWidth=1;
    [backView addSubview:backBtn];
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-60, 20, 120, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"课程详情";
    titleLabel.layer.borderWidth=1;
    [backView addSubview:titleLabel];
    //收藏
    UIButton *collectBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(screen_width-40, 20, 40, 40);
    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collect"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collected"] forState:UIControlStateSelected];
    //    [collectBtn addTarget:self action:@selector(OnTapCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
    collectBtn.layer.borderWidth=1;
    [backView addSubview:collectBtn];
    
}


//
-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setuptableview
{
     //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置header
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
    [self loadNewData];

}

-(void)loadNewData
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getClassListData];
    });
    
}


-(void)getClassListData
{
    NSString *urlStr = [NSString stringWithFormat:@"http://pop.client.chuanke.com/?mod=course&act=info&do=getClassList&sid=%@&courseid=%@&version=%@&uid=%@",self.SID,self.courseId,VERSION,UID];
    NSLog(@"%@",urlStr);
    [[NetworkSingleton shareManager] getClassListResult:nil url:urlStr successBlock:^(id responseBody) {
        NSLog(@"获取课程列表成功！！");
        _CourseDM = [CourseDetailModel objectWithKeyValues:responseBody];
    
        [_dataSourceArray removeAllObjects];
        
        
        for (int i = 0; i < _CourseDM.StepList.count; i++) {
            StepListModel *jzStepListM = [StepListModel objectWithKeyValues:_CourseDM.StepList[i]];
            [_dataSourceArray addObject:jzStepListM];
            for (int j = 0; j < jzStepListM.ClassList.count; j++) {
                ClassListModel *jzClassM = [ClassListModel objectWithKeyValues:jzStepListM.ClassList[j]];
                if (j == jzStepListM.ClassList.count-1) {
                    jzClassM.isLast = @"1";
                }else{
                    jzClassM.isLast = @"0";
                }
                jzClassM.index = [NSString stringWithFormat:@"%d",j+1];
                [_dataSourceArray addObject:jzClassM];
            }
        }
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    } failureBlock:^(NSString *error) {
        [self.tableView.header endRefreshing];
        NSLog(@"获取课程失败！");
    }];
    
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_CourseDM !=nil)
    {
        return 2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
    {
        return  _dataSourceArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 55;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110;
    }else{
        if ([_dataSourceArray[indexPath.row] isKindOfClass:[StepListModel class]]) {
            return 43;
        }else{
            return 64;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
//        UIView *u = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 10)];
//        u.backgroundColor=[UIColor redColor];
//        return u;
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 55)];
    headerView.layer.borderWidth=1;
    headerView.backgroundColor=navigationBarColor;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width/6-12, 5, 25, 25)];
    
    [imageView1 setImage:[UIImage imageNamed:@"course_catalog_icon"]];
    imageView1.layer.borderWidth=1;
    [headerView addSubview:imageView1];

    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), screen_width/3, 20)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:13];
    label1.text = @"目录";
    label1.layer.borderWidth=1;
    [headerView addSubview:label1];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTap1:)];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-12, 5, 25, 25)];
    [imageView2 setImage:[UIImage imageNamed:@"course_info_icon"]];
    imageView2.userInteractionEnabled = YES;
    [imageView2 addGestureRecognizer:tap1];
    imageView2.layer.borderWidth=1;
    [headerView addSubview:imageView2];
    
    UITapGestureRecognizer *tap11  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTap11)];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/3, CGRectGetMaxY(imageView1.frame), screen_width/3, 20)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:13];
    label2.text = @"详情";
    label2.userInteractionEnabled = YES;
    label2.layer.borderWidth=1;
    [label2 addGestureRecognizer:tap11];
    [headerView addSubview:label2];

    
     UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTap2)];
    
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width*5/6-12, 5, 25, 25)];
    [imageView3 setImage:[UIImage imageNamed:@"course_catalog_icon"]];
    imageView3.userInteractionEnabled = YES;
    [imageView3 addGestureRecognizer:tap2];
    imageView3.layer.borderWidth=1;
    [headerView addSubview:imageView3];
    
    
    UITapGestureRecognizer *tap21 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTap21)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(screen_width*2/3, CGRectGetMaxY(imageView1.frame), screen_width/3, 20)];

    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont systemFontOfSize:13];
    label3.text = @"评价";
    label3.userInteractionEnabled = YES;
    [label3 addGestureRecognizer:tap21];
    label3.layer.borderWidth=1;
    [headerView addSubview:label3];
    
    label3.text = [NSString stringWithFormat:@"评价(%@)",@"11"];
    
    
    return headerView;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *cellIndentifier = @"detailCell0";
        CourseDetailInfoCell *cell  = [tableView  dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell==nil) {
            cell = [[CourseDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
      
        if (_CourseDM!=nil) {
            [cell setCourseDM:_CourseDM];
        }
        cell.delegate=self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {if ([_dataSourceArray[indexPath.row] isKindOfClass:[StepListModel class]]) {//章
        static NSString *cellIndentifier = @"detailCell10";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            //下划线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42.5, screen_width, 0.5)];
           // lineView.layer.borderWidth=1;
            lineView.backgroundColor = navigationBarColor;
            [cell addSubview:lineView];
        }
        StepListModel *stepM = _dataSourceArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"第%@章:%@",stepM.StepIndex,stepM.StepName];
        cell.textLabel.layer.borderWidth=1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{//节
        static NSString *cellIndentifier = @"detailCell11";
         CourseClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[CourseClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            //下划线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(40, 63.5, screen_width, 0.5)];
            lineView.tag = 10;
            lineView.backgroundColor = [UIColor redColor];
            //lineView.layer.borderWidth=1;
            [cell addSubview:lineView];
        }
        
       
         ClassListModel *jzClassM = _dataSourceArray[indexPath.row];
        if ([jzClassM.isLast isEqualToString:@"1"]) {
            UIView *lineView = (UIView *)[cell viewWithTag:10];
            lineView.frame = CGRectMake(0, 63.5, screen_width, 0.5);
        }
        [cell setClassM:jzClassM];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    }
}




-(void)OnTap1:(UITapGestureRecognizer *)sender{
    [self pushInfoVC];
}
-(void)OnTap11{
    [self pushInfoVC];
}
-(void)pushInfoVC{
//    JZCourseInfoViewController *jzCourseInfoVC = [[JZCourseInfoViewController alloc] init];
//    jzCourseInfoVC.Brief = _jzCourseDM.Brief;
//    [self.navigationController pushViewController:jzCourseInfoVC animated:YES];
    NSLog(@"详情");
}

-(void)OnTap2{
    [self OnTap21];
}
-(void)OnTap21{
//    JZCourseEvaluationViewController *jzEvalVC = [[JZCourseEvaluationViewController alloc] init];
//    jzEvalVC.courseID = self.courseId;
//    jzEvalVC.SID = self.SID;
//    [self.navigationController pushViewController:jzEvalVC animated:YES];
    NSLog(@"评价");
}


-(void)didSelectSchool
{
    SchoolViewController *scVC = [[SchoolViewController alloc] init];
    scVC.SID=_CourseDM.SID;
    [self.navigationController pushViewController:scVC animated:YES];
}

- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if ([_dataSourceArray[indexPath.row] isKindOfClass:[ClassListModel class]]) {
        
        ClassListModel *jzClassM = _dataSourceArray[indexPath.row];
        if (jzClassM.VideoUrl == nil) {
            [SVProgressHUD showErrorWithStatus:@"当前课程视频暂时没有"];
            
            return;
        }
        
        
        NSString *fileUrl = [jzClassM.VideoUrl[0] objectForKey:@"FileURL"];
        NSURL *videoURL  = [NSURL URLWithString:fileUrl];
        [self playVideoWithURL:videoURL];
        

    }

}




@end
