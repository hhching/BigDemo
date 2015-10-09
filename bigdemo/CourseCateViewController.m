//
//  CourseCateViewController.m
//  bigdemo
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "CourseCateViewController.h"
#import "AllCourseCell.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "CourseDetailViewController.h"
#import "CourseListModel.h"

@interface CourseCateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _type; //segment
    NSInteger _page; //页数
    NSInteger _limit; //每页个数
    NSInteger _charge;// 1:免费 2:收费

    NSString *_cateid;//课程分类ID
    
    NSMutableArray *_dataSourceArray;
    
    UIView *_lineView;
    NSInteger _currentIndex;  //纪录当前课程分类的按钮下标
}

@end

@implementation CourseCateViewController


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self initViews];
    [self initData];
    [self setuptableview];
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



-(void)initData
{
    _dataSourceArray = [[NSMutableArray alloc] init];
    _page = 1;
    _limit = 20;
    _charge = 1;
    _currentIndex = 0;
    if ([self.cateType isEqualToString:@"feizhibo"]) {
        //        NSLog(@"%@  IDArray:%@",self.cateNameArray,self.cateIDArray);
        _cateid = self.cateIDArray[0];
    }

}



-(void)setNav
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    backBtn.layer.borderWidth=1;
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
     [backBtn setImage:[UIImage imageNamed:@"file_tital_back_but"] forState:UIControlStateNormal];
    [backView addSubview:backBtn];
    
    NSArray *segmentArray = [[NSArray alloc] initWithObjects:@"免费",@"收费", nil];
    
    //segment
    UISegmentedControl *segmentCtr=[[UISegmentedControl alloc] initWithItems:segmentArray];
    segmentCtr.frame  =CGRectMake(screen_width/2-80, 30, 160, 30);
    segmentCtr.layer.borderWidth=1;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
   [segmentCtr setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *higlihtedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [segmentCtr setTitleTextAttributes:higlihtedAttributes forState:UIControlStateHighlighted];
    segmentCtr.tintColor = RGB(46, 158, 138);
    
    [segmentCtr addTarget:self action:@selector(OnTapSegmentCtr:) forControlEvents:UIControlEventValueChanged];
    [backView addSubview:segmentCtr];
    
    
    
}

-(void)OnTapBackBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnTapSegmentCtr:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    if (index==0) {
        _page=1;
        _charge =1;
    }else
    {
        _page=1;
        _charge = 2;
    }
    [self.tableView.header beginRefreshing];
}

-(void)initViews
{
    if([self.cateType isEqualToString:@"zhibo"])
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];
    }
    else
    {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, screen_width, 40)];
        scrollView.pagingEnabled=NO;
        scrollView.showsHorizontalScrollIndicator =NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.alwaysBounceHorizontal=YES;
        scrollView.backgroundColor = RGB(246, 246, 246);
        scrollView.layer.borderWidth=1;
        [self.view addSubview:scrollView];
        
        float btnWidth= 60;
        for (int i=0; i<self.cateNameArray.count; i++) {
            UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            nameBtn.frame = CGRectMake(btnWidth*i, 0, btnWidth, 40);
            nameBtn.tag = 10+i;
            nameBtn.font = [UIFont systemFontOfSize:13];
            nameBtn.layer.borderWidth=1;
            [nameBtn setTitle:self.cateNameArray[i] forState:UIControlStateNormal];
            [nameBtn setTitleColor:navigationBarColor forState:UIControlStateSelected];
            [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [nameBtn addTarget:self action:@selector(OnTapNameBtn:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:nameBtn];
            if (i==0) {
                _lineView = [[UIView alloc] initWithFrame:CGRectMake(nameBtn.center.x-20, 38, 40,20)];
                _lineView.backgroundColor = navigationBarColor;
                [scrollView addSubview:_lineView];
            }
            
            
            
        }
        scrollView.contentSize  =CGSizeMake(self.cateNameArray.count*btnWidth,0);
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, screen_width, screen_height-64-40) style:UITableViewStylePlain];
        
        self.tableView.dataSource = self;
        self.tableView.delegate  = self;
        self.tableView.layer.borderWidth=1;
        
        [self.view addSubview:self.tableView];
    }
}

-(void)OnTapNameBtn:(UIButton *)sender
{
    NSInteger index = sender.tag-10;
    if (index==_currentIndex) {
        return;
    }
    _currentIndex  = index;
    _cateid = _cateIDArray[index];
    _page=1;
    [UIView animateWithDuration:0.5 animations:^{
        float y = _lineView.center.y;
        NSLog(@"%f",y);
        _lineView.center = CGPointMake(sender.center.x, y);
    }];
    [self.tableView.header beginRefreshing];
}


-(void)setuptableview
{
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置header
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}

-(void)loadNewData{
    _page = 1;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getAllCourseData];
    });
}

-(void)loadMoreData{
    _page++;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getAllCourseData];
    });
}
-(void)getAllCourseData{
    NSString *urlStr = @"";
    if ([self.cateType isEqualToString:@"zhibo"]) {
        urlStr = [NSString stringWithFormat:@"http://pop.client.chuanke.com/?mod=search&act=mobile&from=iPhone&page=%ld&limit=%ld&today=1&charge=%ld",_page,_limit,_charge];
    }
    else{
        urlStr = [NSString stringWithFormat:@"http://pop.client.chuanke.com/?mod=search&act=mobile&from=iPhone&page=%ld&limit=%ld&cateid=%@&charge=%ld",_page,_limit,_cateid,_charge];
    }
    [[NetworkSingleton shareManager] getDataResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"课程分类查询成功");
        
        if (_page == 1) {
            [_dataSourceArray removeAllObjects];
        }
        
        NSMutableArray *ClassListArray = [responseBody objectForKey:@"ClassList"];
        for (int i = 0; i < ClassListArray.count; i++) {
             CateModel *jzCateM = [CateModel objectWithKeyValues:ClassListArray[i]];
            [_dataSourceArray addObject:jzCateM];
        }
        
        
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    } failureBlock:^(NSString *error){
        NSLog(@"课程分类查询失败：%@",error);
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"allcoursecell";
    AllCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell==nil) {
        cell  = [[AllCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 73.5, screen_width, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        [cell addSubview:lineView];
    }
    CateModel *jzCateM = _dataSourceArray[indexPath.row];
    [cell setCateM:jzCateM];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *cdVC = [[CourseDetailViewController alloc]init];
    CourseListModel *flModel = _dataSourceArray[indexPath.row];
    cdVC.SID=flModel.SID;
    cdVC.courseId=flModel.CourseID;
    [self.navigationController pushViewController:cdVC animated:YES ];

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
