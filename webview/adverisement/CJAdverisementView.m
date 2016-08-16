//
//  CJAdverisementView.m
//  CJAdveriseDemo
//
//  Created by chenjie on 16/8/12.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJAdverisementView.h"

@interface CJAdverisementView ()<UIScrollViewDelegate>
{
    NSInteger _currentIndex;
}
@property(strong,nonatomic)UIScrollView * scrollView;
@property(strong,nonatomic)UIPageControl * pageControl;
@end

@implementation CJAdverisementView
+(instancetype)shareAdverise{
    return  [[self alloc]init];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
    }
    return self;
}
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];

    }
    return _scrollView;
}
- (UIPageControl *)pageControl{
    
    if (_pageControl==nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(self.bounds)-30, 100, 30)];
        _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}
- (void)setNumOfAdverises:(NSArray *)numOfAdverises{
    _numOfAdverises = numOfAdverises;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*3, 0);
    self.pageControl.numberOfPages = _numOfAdverises.count;
    [self addImageView];
    [self insertTimer];//添加定时
    [self addTapGesture];
}
//添加点击手势
- (void)addTapGesture{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tap];
}

- (void)tapGesture{
//   发送点击通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tapImageView" object:self userInfo:@{@"tapNum":[NSNumber numberWithInteger:_currentIndex]}];
}

- (void)insertTimer{
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerGo) userInfo:nil repeats:YES];
}
- (void)timerGo{
    _currentIndex++;
    if (_currentIndex>_numOfAdverises.count-1) {
        _currentIndex = 0;
    }
    [self addImageView];
    self.pageControl.currentPage = _currentIndex;
}
- (void)addImageView{
   //移除scrollView上的view
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    if (self.numOfAdverises.count>0) {
//        中
        UIImageView * midImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        midImageView.image = [UIImage imageNamed:_numOfAdverises[_currentIndex]];
        [self.scrollView addSubview:midImageView];
        
        UIImageView * leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        leftImageView.image = [UIImage imageNamed:_numOfAdverises[_currentIndex-1>=0?_currentIndex-1:_numOfAdverises.count-1]];
        [self.scrollView addSubview:leftImageView];
        
        UIImageView * rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds)*2, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        rightImageView.image = [UIImage imageNamed:_numOfAdverises[_currentIndex+1>_numOfAdverises.count-1?0:_currentIndex+1]];
        [self.scrollView addSubview:rightImageView];
        //设置scrollView偏移一个scrollView宽
        [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds), 0) animated:NO];
    }
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (_numOfAdverises.count>0) {
        if (index==0) {
            _currentIndex = _currentIndex-1>=0?_currentIndex-1:_numOfAdverises.count-1;
            [self addImageView];
        }else if (index==2){
            _currentIndex = _currentIndex+1>_numOfAdverises.count-1?0:_currentIndex+1;
            [self addImageView];
        }
        self.pageControl.currentPage = _currentIndex;
    }
}




@end
