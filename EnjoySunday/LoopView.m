//
//  LoopView.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "LoopView.h"
#import "UIKit+AFNetworking.h"

#define HEIGHT 200

@interface LoopView()

@property(nonatomic)UIImageView *imageView;
@property(nonatomic)NSInteger index;
@property(nonatomic)UIPageControl *pageControl;
@property(nonatomic)NSTimer *timer;

@property(nonatomic)UIScrollView *a;

@end

@implementation LoopView

+(id)loopView
{
    return [[self alloc] init];
}

-(id)init
{
    if(self=[super init])
    {
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEIGHT);
    }
    return self;
}
-(void)setImageArray:(NSArray *)imageArray
{
    _index=0;
    _imageArray=imageArray;
    self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEIGHT)];

    [self addSubview:self.imageView];
//    UIView *image=[[UIView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 200)];
//    image.userInteractionEnabled=YES;
//    image.backgroundColor=[UIColor clearColor];
//    [self.superview.superview.superview addSubview:image];
    
    
    [self.imageView setImageWithURL:[NSURL URLWithString:_imageArray[_index]]];
    self.imageView.userInteractionEnabled=YES;
    //添加滑动手势
    UISwipeGestureRecognizer *leftSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *rightSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:leftSwipe];
    [self.imageView addGestureRecognizer:rightSwipe];
//    [image addGestureRecognizer:leftSwipe];
//    [image addGestureRecognizer:rightSwipe];
    //添加单机手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
    [self.imageView addGestureRecognizer:tap];
//    [image addGestureRecognizer:tap];
    
    _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT-30, [UIScreen mainScreen].bounds.size.width, 30)];
    [self addSubview:_pageControl];
    _pageControl.currentPage=0;
    _pageControl.numberOfPages=_imageArray.count;
    
    [self start];
    
}

-(void)imageClick:(UITapGestureRecognizer*)tap
{
    if(_imageClick)
    {
        _imageClick(_pageControl.currentPage);
    }
}

-(void)swipe:(UISwipeGestureRecognizer*)swipe
{
    //UIImageView *image=(UIImageView *)swipe.view;
    
    [self stop];
    if(swipe.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        self.index = _index+1;
        [self left];
    }
    if(swipe.direction==UISwipeGestureRecognizerDirectionRight)
    {
        self.index = _index-1;
        [self right];
    }
    [self start];
    
}
-(void)right
{
    if(_index<0)
    {
        _index=2;
    }
    CATransition *transition=[CATransition animation];
    transition.type=@"cube";
    transition.subtype=kCATransitionFromLeft;
    transition.duration=0.5;
    transition.timingFunction = UIViewAnimationOptionCurveEaseInOut;//进来加速 出去减速
    transition.startProgress = 0;
    transition.endProgress = 1;
    
    [self.imageView.layer addAnimation:transition forKey:@"left"];
    [self.imageView setImageWithURL:[NSURL URLWithString:_imageArray[_index]]];
    _pageControl.currentPage=_index;
}
-(void)left
{
    if(_index>=_imageArray.count)
    {
        _index=0;
    }
    CATransition *transition=[CATransition animation];
    transition.type=@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.duration=0.5;
    transition.timingFunction = UIViewAnimationOptionCurveEaseInOut;//进来加速 出去减速
    transition.startProgress = 0;
    transition.endProgress = 1;
    
    [self.imageView.layer addAnimation:transition forKey:@"right"];
    [self.imageView setImageWithURL:[NSURL URLWithString:_imageArray[_index]]];
    _pageControl.currentPage=_index;
}
-(void)startAnimation
{
    
    CATransition *transition=[CATransition animation];
    transition.type=@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.duration=0.5;
    transition.timingFunction = UIViewAnimationOptionCurveEaseInOut;//进来加速 出去减速
    transition.startProgress = 0;
    transition.endProgress = 1;
    _index++;
    if(_index>=_imageArray.count)
    {
        _index=0;
    }
    [self.imageView.layer addAnimation:transition forKey:@"transition"];
    [self.imageView setImageWithURL:[NSURL URLWithString:_imageArray[_index]]];
    _pageControl.currentPage=_index;
    
}

-(void)start
{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)stop
{
    //[self.imageView.layer removeAnimationForKey:@"transiton"];
    [self.timer invalidate];
    self.timer = nil;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEIGHT);
}

@end
