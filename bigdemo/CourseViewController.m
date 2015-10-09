//
//  CourseViewController.m
//  bigdemo
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "CourseViewController.h"
#import "ImageScrollCell.h"
#import "CourseCell.h"
#import "CourseDetailViewController.h"
#import "CourseListModel.h"
#import "NetworkSingleton.h"
#import "FocusListModel.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "AlbumCell.h"
#import "AlbumListModel.h"
#import "CourseCateViewController.h"
@interface CourseViewController ()<UITableViewDataSource,UITableViewDelegate,ImageScrollViewDelegate,AlbumDelegate>
{
    NSInteger _type;/**< segment */
    NSMutableArray *_focusImgurlArray;
    NSMutableArray *_focusListArray;/**< 第一个轮播数据 */
    
    NSMutableArray *_courseListArray;/**< 列表数据 */
    NSMutableArray *_albumListArray;/**< 第二个轮播数据 */
    NSMutableArray *_albumImgurlArray;/**< 第二个轮播图片URL数据 */
    
    NSMutableArray *_classCategoryArray;/**< 课程分类数组 */
    NSMutableArray *_iCategoryListArray;

}
@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setNav];
    [self initData];
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _focusListArray = [[NSMutableArray alloc] init];
    _focusImgurlArray = [[NSMutableArray alloc] init];
    _courseListArray = [[NSMutableArray alloc] init];
    _albumListArray = [[NSMutableArray alloc] init];
    _albumImgurlArray = [[NSMutableArray alloc] init];
    _classCategoryArray = [[NSMutableArray alloc] init];
    _iCategoryListArray = [[NSMutableArray alloc] init];
    //读取plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"classCategory" ofType:@"plist"];
    _classCategoryArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    //课程类型
    NSString *iCategoryListPath = [[NSBundle mainBundle] pathForResource:@"iCategoryList" ofType:@"plist"];
    _iCategoryListArray = [[NSMutableArray alloc] initWithContentsOfFile:iCategoryListPath];
}

-(void)setNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 98)];
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    
    //声明：原创所有，不要注释下面的UIButton
    UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nameBtn.frame = CGRectMake(10, 20, 60, 40);//左边，可以说作为参考的frame，不用怎么做适配
    nameBtn.font = [UIFont systemFontOfSize:15];
    [nameBtn setTitle:@"点击这" forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nameBtn addTarget:self action:@selector(OnNameBtn) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:nameBtn];
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-80, 20, 160, 30)];//中间，固定宽度的情况，已知按钮宽度，高度，y坐标，屏幕宽度，x＝屏幕宽度＊1/2－按钮宽度＊1/2
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"百度传课";
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    //搜索
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(screen_width-10-40, 20, 40, 40);//最右边，已知宽高，y坐标，屏幕宽度，x＝屏幕宽度－按钮距离右边的边距－按钮的宽度
    searchBtn.layer.borderWidth=1;
    [searchBtn setImage:[UIImage imageNamed:@"search_btn_unpre_bg"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(OnSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:searchBtn];
    
    //
    NSArray *segmentArray = [[NSArray alloc] initWithObjects:@"精选推荐",@"课程分类", nil];
    UISegmentedControl *segmentCtr = [[UISegmentedControl alloc] initWithItems:segmentArray];
    segmentCtr.frame = CGRectMake(36, 64, screen_width-36*2, 30);//中间，按钮宽度未确定，已知按钮x坐标，y坐标，高度，屏幕宽度，宽度＝屏幕宽度－x坐标＊2
    
    segmentCtr.selectedSegmentIndex = 0;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [segmentCtr setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [segmentCtr setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    segmentCtr.tintColor = RGB(46, 158, 138);
    [segmentCtr addTarget:self action:@selector(OnTapSegmentCtr:) forControlEvents:UIControlEventValueChanged];
    [backView addSubview:segmentCtr];
}

-(void)OnNameBtn{
    NSLog(@"test touch  !!!!");
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"test touch or not  !!!!");
}

//搜索
-(void)OnSearchBtn:(UIButton *)sender{
    
}


-(void)OnTapSegmentCtr:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    if (index == 0) {
        _type = 0;
    }else{
        _type = 1;
    }
    [self.tableView reloadData];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 98, screen_width, screen_height-98-49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.hidden = YES;
     [self setuptableview];
    
    
}


-(void)setuptableview
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置header
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
    
}

-(void)loadNewData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getRecommendData];
    });
}

//请求推荐课程数据
-(void)getRecommendData
{
    NSString *urlStr = @"http://pop.client.chuanke.com/?mod=recommend&act=mobile&client=2&limit=20";
    [[NetworkSingleton shareManager] getRecommendCourseResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"请求推荐课程数据成功");
        NSMutableArray *focusArray = [responseBody objectForKey:@"FocusList"];
        NSMutableArray *courseArray = [responseBody objectForKey:@"CourseList"];
        NSMutableArray *albumArray = [responseBody objectForKey:@"AlbumList"];
        
        [_focusListArray removeAllObjects];
        [_focusImgurlArray removeAllObjects];
        [_courseListArray removeAllObjects];
        [_albumListArray removeAllObjects];
        [_albumImgurlArray removeAllObjects];
        
        for (int i = 0; i < focusArray.count; ++i) {
            FocusListModel *jzFocusM = [FocusListModel objectWithKeyValues:focusArray[i]];
            [_focusListArray addObject:jzFocusM];
            [_focusImgurlArray addObject:jzFocusM.PhotoURL];
        }
        for (int i = 0; i < courseArray.count; ++i) {
            CourseListModel *jzCourseM = [CourseListModel objectWithKeyValues:courseArray[i]];
            [_courseListArray addObject:jzCourseM];
        }
        for (int i = 0; i < albumArray.count; ++i) {
            AlbumListModel *jzAlbumM = [AlbumListModel objectWithKeyValues:albumArray[i]];
            [_albumListArray addObject:jzAlbumM];
            [_albumImgurlArray addObject:jzAlbumM.PhotoURL];
        }
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failureBlock:^(NSString *error){
        [SVProgressHUD showErrorWithStatus:error];
        
        NSLog(@"请求推荐课程数据失败：%@",error);
        [self.tableView.header endRefreshing];
    }];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type == 0) {
       
        if (_courseListArray.count>0) {
            return _courseListArray.count+2;
        }else{
            return 0;
        }
        
    }else{
        return  _classCategoryArray.count;;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 0) {
        if (indexPath.row == 0) {
            return 155;
        }else if (indexPath.row == 1){
            return 90;
        }else{
            return 72;
        }
    }else{
        return 60;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == 0) {
        if (indexPath.row == 0) {
            static NSString *cellIndentifier = @"courseCell0";
            ImageScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[ImageScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 155)];
            }
           
            
            cell.imageScrollView.delegate = self;
            [cell setImageArr:_focusImgurlArray];
            return cell;
        }else if (indexPath.row == 1){
            static NSString *cellIndentifier = @"courseCell1";
            AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[AlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 90)];
                //下划线
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 89.5, screen_width, 0.5)];
                lineView.backgroundColor = separaterColor;
                [cell addSubview:lineView];
            }
            
            cell.delegate = self;
            [cell setImgurlArray:_albumImgurlArray];
            
            return cell;
        }else if (indexPath.row > 1){
            static NSString *cellIndentifier = @"courseCell2";
            CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[CourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                //            NSLog(@"%f/%f",cell.frame.size.width,cell.frame.size.height);
                //下划线
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 71.5, screen_width, 0.5)];
                lineView.backgroundColor = separaterColor;
                [cell addSubview:lineView];
            }
            
             CourseListModel *jzCourseM = _courseListArray[indexPath.row-2];
            [cell setJzCourseM:jzCourseM];//设置cell里面的内容
            
            return cell;
        }
        static NSString *cellIndentifier = @"courseCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        return cell;
    }else{
        static NSString *cellIndentifier = @"courseClassCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            //下划线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, screen_width, 0.5)];
            lineView.backgroundColor = separaterColor;
            [cell addSubview:lineView];
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
            imageView.tag = 10;
            [cell addSubview:imageView];
            //标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 100, 30)];
            titleLabel.tag = 11;
            [cell addSubview:titleLabel];
        }
        NSDictionary *dataDic = _classCategoryArray[indexPath.row];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:10];
        NSString *imageStr = [dataDic objectForKey:@"image"];
        [imageView setImage:[UIImage imageNamed:imageStr]];
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
        titleLabel.text = [dataDic objectForKey:@"title"];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }

}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_type == 0) {
        CourseDetailViewController *cdVC = [[CourseDetailViewController alloc]init];
    CourseListModel *flModel = _courseListArray[indexPath.row-2];
    cdVC.SID=flModel.SID;
    cdVC.courseId=flModel.CourseID;
    [self.navigationController pushViewController:cdVC animated:YES ];
    }else{
        CourseCateViewController *jzCateVC = [[CourseCateViewController alloc] init];
        if (indexPath.row == 0) {
            jzCateVC.cateType = @"zhibo";
        }else{
            NSDictionary *dic = _iCategoryListArray[indexPath.row-1];
            jzCateVC.cateType = @"feizhibo";
            jzCateVC.cateNameArray = [dic objectForKey:@"categoryName"];
            jzCateVC.cateIDArray = [dic objectForKey:@"categoryID"];
        }
        
        
        [self.navigationController pushViewController:jzCateVC animated:YES];
    }
    
    
    
}

-(void)didSelectImageAtIndex:(NSInteger)index
{
    CourseDetailViewController *cdVC = [[CourseDetailViewController alloc]init];
    FocusListModel *flModel = _focusListArray[index];
    cdVC.SID=flModel.SID;
    cdVC.courseId=flModel.CourseID;
    [self.navigationController pushViewController:cdVC animated:YES ];
    
}

#pragma mark - AlbumDelegate
-(void)didSelectedAlbumAtIndex:(NSInteger)index{
    NSLog(@"album index:%ld",index);
   
}
@end
