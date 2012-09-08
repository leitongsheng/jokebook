//
//  folkSongViewController.m
//  jokebook
//
//  Created by tongsheng lei on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "folkSongViewController.h"
#import "DataOfJockBook.h"
#import "QuadCurveMenu.h"
#import <QuartzCore/QuartzCore.h>

@interface folkSongViewController ()

@end

@implementation folkSongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBg.png"]];
	// Do any additional setup after loading the view, typically from a nib.
    //测试数据
    DataOfJockBook *dataOfJockBook = [[DataOfJockBook alloc] init];
    NSURL *listUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_3_1.html"];
    [dataOfJockBook theCountOfPages:listUrl];
//   [dataOfJockBook jockList:listUrl]; 
//    NSURL *contextUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/detail1/382.html"];
   // [dataOfJockBook jockContext:contextUrl];
    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage_item1 = [UIImage imageNamed:@"item1.png"];
    UIImage *starImage_item2 = [UIImage imageNamed:@"item2.png"];
    UIImage *starImage_item3 = [UIImage imageNamed:@"item3.png"];
    UIImage *starImage_item4 = [UIImage imageNamed:@"item4.png"];
    UIImage *starImage_item5 = [UIImage imageNamed:@"item5.png"];
    UIImage *starImage_item6 = [UIImage imageNamed:@"item6.png"];
    
    QuadCurveMenuItem *starMenuItem1 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage_item1 
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem2 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage_item2 
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem3 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage_item3 
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem4 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage_item4 
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem5 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage_item5
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem6 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage_item6
                                                        highlightedContentImage:nil];
//    QuadCurveMenuItem *starMenuItem7 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
//                                                               highlightedImage:storyMenuItemImagePressed 
//                                                                   ContentImage:starImage
//                                                        highlightedContentImage:nil];
//    QuadCurveMenuItem *starMenuItem8 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
//                                                               highlightedImage:storyMenuItemImagePressed 
//                                                                   ContentImage:starImage
//                                                        highlightedContentImage:nil];
//    QuadCurveMenuItem *starMenuItem9 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
//                                                               highlightedImage:storyMenuItemImagePressed 
//                                                                   ContentImage:starImage
//                                                        highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, starMenuItem6, nil];
    
    CGRect rect = self.view.bounds;
    if (rect.size.height == 460) 
    {
        rect = CGRectMake(0, 0, rect.size.width, rect.size.height - 44);
    }
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:rect menus:menus];
    
    menu.delegate = self;
    menu.expanding = YES;
    
    [self.view addSubview:menu];
    
    
}

#pragma mark Delegate Methods
- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    // 创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    animation.delegate = self;
    // 设定动画时间
    animation.duration = 0.7;
    // 设定动画快慢(开始与结束时较慢)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    
    // 设定动画方向
    animation.subtype = kCATransitionFromLeft;
    
    if (idx == 0) {
          [self performSegueWithIdentifier:@"item1" sender:nil];
    }
  
    
    //        // 动画开始
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

@end
