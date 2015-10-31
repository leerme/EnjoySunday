//
//  MyTabbarController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "MyTabbarController.h"

#import "SundayViewController.h"
#import "SingleMainViewController.h"
#import "ClassifyViewController.h"
#import "MineViewController.h"
#import "NetInterface.h"
@interface MyTabbarController ()

@end

@implementation MyTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SundayViewController * sundayViewController = [[SundayViewController alloc] init];
    [self setItemWithController:sundayViewController title:@"过周末" imageName:@"tab_good.png" selectedImageName:nil];
    
    SingleMainViewController * singleViewController = [[SingleMainViewController alloc] init];
    [self setItemWithController:singleViewController title:@"单品" imageName:@"tab_list.png" selectedImageName:nil];
    
    ClassifyViewController * classifyViewController = [[ClassifyViewController alloc] init];
    [self setItemWithController:classifyViewController title:@"分类" imageName:@"tab_new.png" selectedImageName:nil];
    
    MineViewController * mineViewController = [[MineViewController alloc] init];
    [self setItemWithController:mineViewController title:@"我" imageName:@"tab_heart.png" selectedImageName:nil];
}

- (void)setItemWithController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    controller.navigationItem.title = title;
    controller.tabBarItem.title = title;
    
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.view.backgroundColor = [UIColor whiteColor];
    //controller.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    NSDictionary * attributes = @{NSForegroundColorAttributeName:GLOBLE_COLOR};
    [controller.tabBarItem setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:controller];
    
    nav.navigationBar.barTintColor = GLOBLE_COLOR;
    self.tabBar.tintColor = GLOBLE_COLOR;
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
