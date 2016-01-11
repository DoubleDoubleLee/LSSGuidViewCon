//
//  LSSGuidViewController.m
//  LSSGuidViewCon
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 double Lee. All rights reserved.
//

#import "LSSGuidViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LSSGuidViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollV;
@property(nonatomic,strong)UIPageControl * pageCon;

@end

@implementation LSSGuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollV];
    [self.view addSubview:self.pageCon];
    self.title=@"引导页";
    [self loadGuidView];
    // Do any additional setup after loading the view.
}
-(void)loadGuidView{
    
    for (int i=0; i<6; i++) {
        UIImageView * imageV=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT)];
        
        imageV.image=[UIImage imageNamed:[NSString stringWithFormat:@"0%d.jpg",i+1]];
        imageV.userInteractionEnabled=YES;
        [self.scrollV addSubview:imageV];
        
        if (i==5) {
            UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/3*2, 100, 50)];
            [btn setTitle:@"点击进入" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
            
            [imageV addSubview:btn];
        }
        
    }
}
-(void)click{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"succ"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.changeVC();
    
}
-(UIScrollView*)scrollV{
    if (!_scrollV) {
        _scrollV=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollV.pagingEnabled=YES;
        _scrollV.delegate=self;
        _scrollV.contentSize = CGSizeMake(WIDTH * 6, HEIGHT);
        _scrollV.bounces=NO;
        _scrollV.showsHorizontalScrollIndicator=NO;
        _scrollV.showsVerticalScrollIndicator=NO;
    }
    return _scrollV;
}
-(UIPageControl*)pageCon{
    if (!_pageCon) {
        _pageCon=[[UIPageControl alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/4*3, 100, 30)];
        _pageCon.pageIndicatorTintColor=[UIColor whiteColor];
        _pageCon.currentPageIndicatorTintColor=[UIColor colorWithRed:1.000 green:0.305 blue:0.664 alpha:1.000];
        _pageCon.numberOfPages=6;
    }
    return _pageCon;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index=scrollView.contentOffset.x/WIDTH;
    _pageCon.currentPage=index;

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
