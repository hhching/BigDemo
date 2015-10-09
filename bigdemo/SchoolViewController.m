//
//  SchoolViewController.m
//  bigdemo
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "SchoolViewController.h"
#import "SchoolCell.h"
#import "NSString+Size.h"
#import "SchoolModel.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "AllCourseViewController.h"

@interface SchoolViewController ()<UITableViewDelegate,UITableViewDataSource,SchoolDeletegate>
{
    SchoolModel *_jzSchoolM;
}

@end

@implementation SchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self initTableview];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getSchoolData];
    });
    // Do any additional setup after loading the view.
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

-(void)initTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    //self.tableView.separatorColor=[UIColor clearColor];
}


-(void)getSchoolData{
    NSString *urlStr = [NSString stringWithFormat:@"http://pop.client.chuanke.com/?mod=school&act=info&mode=&sid=%@&uid=%@",self.SID,UID];
    [[NetworkSingleton shareManager] getDataResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"请求学校数据成功");
        
        _jzSchoolM = [SchoolModel objectWithKeyValues:responseBody];
        
        [self.tableView reloadData];
    } failureBlock:^(NSString *error){
        NSLog(@"请求学校数据失败：%@",error);
    }];
}


//
-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_jzSchoolM != nil) {
        return 4;
    }
    return 0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if(section==1)
    {
        return 1;
    }
    if (section==2) {
        if (_jzSchoolM.TeacherList.count>3) {
            return 5;
        }else{
            return 1+_jzSchoolM.TeacherList.count;
        }
    }
    else
    {
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 266;
    }
    else if (indexPath.section ==1)
    {
       // NSString *testStr = @"I know this is an old post now but, I have just encountered this error, I found it very strange as the app was in testing so no fresh builds for a few days and it did this, all I did was reboot the phone and it solved it.";
        
//        NSString *testStr=@"这视频我看过了，这家伙是iPhone用户，拿iPhone与坚果比。视频中他说过这几句话：“我苹果用多了，所以我都不关后台的。”然后他开了十几个后台在测试流畅度。“跟主流旗舰手机来说。。。”、“这是我第一次体验千元机。。。”。这家伙把旗舰卖了卖了两个千元机，我不知道怎么评价这家伙了，反正视频弹幕里大部分都是在说这家伙。。。。";
//        CGSize labelSize = [testStr boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
        CGSize labelSize = [_jzSchoolM.Notice boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
        return labelSize.height+10;

        
    }else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
            return 40;
        }
        else if (indexPath.row==4)
        {
            return 30;
        }
        else
        {
            return 70;
        }
    }
    
    else
    {
        if (indexPath.row==0) {
//           NSString *testStr = @"我试了一下，我用米4，3G内存，开了17个应用，没有任何使用，只是打开，可用内存还剩下600M。我想2G内存的这么用，卡也很正常。反正我看完这个视频，第一印象就是这哥们黑的不是锤子，是安卓";
//            CGSize labelSize =[testStr boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
             CGSize labelSize = [_jzSchoolM.Brief boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
            return labelSize.height+30+10;

        }
        else
        {
            return 30;
        }
        
        
    }
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
       static   NSString * cellIndentifier = @"schollCell1";
        SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[SchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        if (_jzSchoolM!=nil) {
            
            [cell setSchoolM:_jzSchoolM];
            cell.delegate=self;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
       
    }
    else if (indexPath.section==1)
    {
        static NSString *cellIndentifier = @"schoolCel1";
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
            
            UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, screen_width-20, 20)];
            noticeLabel.tag = 100;
            noticeLabel.font = [UIFont systemFontOfSize:13];
            noticeLabel.layer.borderWidth=1;
            [cell addSubview:noticeLabel];
        }
       // NSString *testStr = @"I know this is an old post now but, I have just encountered this error, I found it very strange as the app was in testing so no fresh builds for a few days and it did this, all I did was reboot the phone and it solved it.";
        
//        NSString *testStr=@"这视频我看过了，这家伙是iPhone用户，拿iPhone与坚果比。视频中他说过这几句话：“我苹果用多了，所以我都不关后台的。”然后他开了十几个后台在测试流畅度。“跟主流旗舰手机来说。。。”、“这是我第一次体验千元机。。。”。这家伙把旗舰卖了卖了两个千元机，我不知道怎么评价这家伙了，反正视频弹幕里大部分都是在说这家伙。。。。";
//        CGSize labelSize = [testStr boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
        CGSize labelSize = [_jzSchoolM.Notice boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
        UILabel *noticeLabel = (UILabel *)[cell viewWithTag:100];
        noticeLabel.text=_jzSchoolM.Notice;
        noticeLabel.frame = CGRectMake(10, 5, screen_width-20, labelSize.height);
        noticeLabel.numberOfLines=0;
        noticeLabel.layer.borderWidth=1;
        cell.backgroundColor=tableView.backgroundColor;
        return cell;
    }
    else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
            static NSString *cellIndentifier=@"schoolCell20";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.textLabel.text=@"学校老师";
            return cell;
        }
        else if (indexPath.row==4)
        {
            static NSString *cellIndentifier = @"schoolCell24";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell==nil) {
                cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
                
            }
            cell.detailTextLabel.text=@"更多";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        static NSString *cellIndentifier = @"schoolCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
             UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
            imageView.layer.borderWidth=1;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius=25;
            imageView.tag=200;
            [cell  addSubview:imageView];
            
            
            UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, screen_width-10-70, 30)];
            nickNameLabel.textColor = navigationBarColor;
            nickNameLabel.font = [UIFont systemFontOfSize:15];
            nickNameLabel.tag = 201;
            nickNameLabel.layer.borderWidth=1;
            [cell addSubview:nickNameLabel];
            
            
            //说说
            UILabel *BriefLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, screen_width-10-70, 30)];
            BriefLabel.font = [UIFont systemFontOfSize:13];
            BriefLabel.textColor = [UIColor lightGrayColor];
            BriefLabel.tag = 202;
            BriefLabel.layer.borderWidth=1;
            [cell addSubview:BriefLabel];

        }
         UIImageView *imageView = (UIImageView *)[cell viewWithTag:200];
         UILabel *nickNameLabel = (UILabel *)[cell viewWithTag:201];
        UILabel *briefLabel = (UILabel *)[cell viewWithTag:202];
        NSDictionary *dic = _jzSchoolM.TeacherList[indexPath.row-1];
        nickNameLabel.text = [dic objectForKey:@"TeacherName"];
        briefLabel.text = [dic objectForKey:@"Brief"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"Avatar"]] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
        return  cell;
    }
    else
    {
        if (indexPath.row==0) {
            static NSString *cellIndentifier = @"schoolCell30";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell==nil) {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                UILabel *schoolLabel= [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 25)];
                schoolLabel.text =@"学校介绍";
                schoolLabel.layer.borderWidth=1;
                [cell addSubview:schoolLabel];
                
                
                UILabel *briefLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, screen_width-20, 20)];
                briefLabel.font = [UIFont systemFontOfSize:13];
                briefLabel.numberOfLines =0;
                briefLabel.tag=110;
                briefLabel.layer.borderWidth=1;
                [cell addSubview:briefLabel];
            }
            
//            NSString *testStr = @"我试了一下，我用米4，3G内存，开了17个应用，没有任何使用，只是打开，可用内存还剩下600M。我想2G内存的这么用，卡也很正常。反正我看完这个视频，第一印象就是这哥们黑的不是锤子，是安卓";
//            CGSize labelSize = [testStr boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
//            UILabel *briefLabel = (UILabel *)[cell viewWithTag:110];
            CGSize labelSize = [_jzSchoolM.Brief boundingRectWithSize:CGSizeMake(screen_width-20, 0) withFont:13];
            UILabel *briefLabel = (UILabel *)[cell viewWithTag:110];
            briefLabel.text = _jzSchoolM.Brief;

            briefLabel.text=_jzSchoolM.Brief;
            briefLabel.frame  =CGRectMake(10, 35, screen_width-20, labelSize.height);
            
            return cell;
            
        }
        else
        {
            static NSString *cellIndentifier = @"schoolCell31";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell==nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            }
            cell.detailTextLabel.text=@"更多";
            cell.detailTextLabel.font= [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.tag=311;
            return  cell;
        }
            }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)didSelectedAtIndex:(NSInteger)index
{
    if (index==0) {
        AllCourseViewController *AllCourseVC = [[AllCourseViewController alloc] init];
        AllCourseVC.DO = @"courseList";
        AllCourseVC.SID = self.SID;
        [self.navigationController pushViewController:AllCourseVC animated:YES];

    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
