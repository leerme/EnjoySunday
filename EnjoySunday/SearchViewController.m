//
//  SearchViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SearchViewController.h"
#import "NetInterface.h"
#import "AFNetworking.h"
#import "SearchDetailView.h"
@interface SearchViewController ()
{
    BOOL _isSearch;
    UISearchBar *_search;
}
@property(nonatomic)UIView *searchView;
@property(nonatomic)NSArray *totalArray;
@property(nonatomic)SearchDetailView *searchDetailView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isSearch=NO;
    [self createNav];
    _searchDetailView=[SearchDetailView searchDetailView];
    [self.view addSubview:_searchDetailView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)loadData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:SEARCH_URL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (responseObject) {
                 //[self loadDataFromSelectTableViewCache];
                 NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
                 if (!objects) {
                     return;
                 }
                 NSDictionary *dic=objects[@"data"];
                 _totalArray=dic[@"hot_words"];
                 //NSLog(@"%@",_totalArray);
                 [self createContent];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
         }
     ];

}

-(void)createContent
{
    UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10+64, 100, 25)];
    contentLabel.text=@"大家都在搜";
    contentLabel.font=[UIFont systemFontOfSize:15];
    contentLabel.textColor=[UIColor grayColor];
    [self.view addSubview:contentLabel];
    CGFloat intorval=10;
    CGFloat btnW=([UIScreen mainScreen].bounds.size.width-6*intorval)/5;
    CGFloat btnH=30;
    CGFloat btnY=5+64+35;
    CGFloat btnX=intorval;
    UIButton *lastBtn;
    int j= -1;
    for(int i=0;i<_totalArray.count;i++)
    {
        if([_totalArray[i] isEqualToString:@"T.iber.com"])
        {
            j=i;
        }
            
        if(i<9)
        {
            if(i<=5)
            {
                btnX=i==5?intorval:intorval+i*(intorval+btnW);
            }else
            {
                btnX=CGRectGetMaxX(lastBtn.frame)+intorval;
            }
            btnY=i<5?btnY:104+btnH+5;
        }else
        {
            if(i==9)
            {
               btnY=CGRectGetMaxY(lastBtn.frame)+5;
            }
            btnX=intorval+(i-9)*(intorval+btnW);
        }
        btnW=i==j?2*btnW+intorval:([UIScreen mainScreen].bounds.size.width-6*intorval)/5;
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        //NSLog(@"%@",NSStringFromCGRect(btn.frame));
        [btn setTitle:_totalArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [self.view addSubview:btn];
        btn.layer.borderWidth=0.3;
        btn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        lastBtn=btn;
    }
}
-(void)btnClick:(UIButton *)btn
{
    self.navigationItem.leftBarButtonItem=nil;
    CGRect frame=_searchView.frame;
    frame.size.width=[UIScreen mainScreen].bounds.size.width-140;
    frame.origin.x=84;
    _searchView.frame=frame;
    
    _searchView.frame=frame;
    _search.frame=_searchView.bounds;
    [_searchView addSubview:_search];
    self.navigationItem.titleView=_searchView;
    
    
    CGRect searchFrame=_searchDetailView.frame;
    searchFrame.origin.y=64;
    _searchDetailView.frame=searchFrame;
    _searchDetailView.url=[[NSString stringWithFormat:SEARCHDETAIL_URL,btn.titleLabel.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",[[NSString stringWithFormat:SEARCHDETAIL_URL,btn.titleLabel.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    [self.view bringSubviewToFront:_searchDetailView];
    _isSearch=YES;
}
-(void)createNav
{
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=right;
    
    _search=[[UISearchBar alloc] init];
    _search.placeholder=@"搜索商品、专题";
    [_search becomeFirstResponder];
   
    _searchView=[[UIView alloc] initWithFrame:CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width-60, 40)];
    _search.frame=_searchView.bounds;

    UIView *view=_search.subviews[0];
    for (UIView *v in view.subviews) {
        if([v isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [v removeFromSuperview];
        }
    }
    [_searchView addSubview:_search];

    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithCustomView:_search];
    self.navigationItem.leftBarButtonItem=left;
    
}


-(void)cancel
{
    if(_isSearch)
    {
        CGRect frame=_search.frame;
        frame.size.width=[UIScreen mainScreen].bounds.size.width-60;
        _search.frame=frame;
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:_search];
        self.navigationItem.titleView=nil;
        
        CGRect searchFrame=_searchDetailView.frame;
        searchFrame.origin.y=[UIScreen mainScreen].bounds.size.height;
        _searchDetailView.frame=searchFrame;
        _isSearch=NO;
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
