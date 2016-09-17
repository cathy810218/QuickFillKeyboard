//
//  HelpViewController.m
//  QuickFillKeyboard
//
//  Created by Cathy Oun on 1/19/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//
// Reference Material: NFXTourViewController

#import "HelpViewController.h"

@interface HelpViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation HelpViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"help.title", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor: [UIColor whiteColor]];
    
    UIImage *img1 = [UIImage imageNamed:@"1settings"];
    UIImage *img2 = [UIImage imageNamed:@"2general"];
    UIImage *img3 = [UIImage imageNamed:@"3keyboard"];
    UIImage *img4 = [UIImage imageNamed:@"4add"];
    UIImage *img5 = [UIImage imageNamed:@"5quick"];
    UIImage *img6 = [UIImage imageNamed:@"6done"];
    UIImage *img7 = [UIImage imageNamed:@"7global"];
    UIImage *img8 = [UIImage imageNamed:@"8final"];
    
    NSArray *images = @[img1,img2,img3,img4,img5,img6,img7,img8];
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // size and position
    CGRect scrollViewRect = CGRectZero;
    scrollViewRect.size.height = self.view.bounds.size.height/3 * 2;
    scrollViewRect.size.width = self.view.bounds.size.width/3 * 2;
    CGPoint scrollViewCenter = CGPointZero;
    scrollViewCenter.x = self.view.center.x;
    scrollViewCenter.y = self.view.center.y;
    CGSize scrollViewContentSize = CGSizeZero;
    scrollViewContentSize.height = scrollViewRect.size.height;
    scrollViewContentSize.width = scrollViewRect.size.width * images.count;
    
    CGPoint pagingContentCenter = CGPointZero;
    pagingContentCenter.x = self.view.center.x;
    pagingContentCenter.y = scrollViewCenter.y + (scrollViewRect.size.height/2) + 20;
    
    
    // scrollView setup
    self.scrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    self.scrollView.center = scrollViewCenter;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = scrollViewContentSize;
    self.scrollView.pagingEnabled = true;
    self.scrollView.bounces = false;
    self.scrollView.delegate = self;
    self.scrollView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.scrollsToTop = false;
    self.scrollView.layer.cornerRadius = 2;
    [self.view addSubview:self.scrollView];
    
    // pageView setup
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:1];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.6 alpha:1];
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
    [self.pageControl sizeToFit];
    self.pageControl.center = pagingContentCenter;
    [self.view addSubview:self.pageControl];
    
    for (int i = 0; i < images.count; i++) {
        CGRect imgRect = CGRectMake(self.scrollView.bounds.size.width * i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:imgRect];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = true;
        imgView.image = images[i];
        [self.scrollView addSubview:imgView];
        [self.view addSubview:self.scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int)round(scrollView.contentOffset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = page;
}

@end
