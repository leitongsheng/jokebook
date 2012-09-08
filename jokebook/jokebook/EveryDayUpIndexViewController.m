//
//  EveryDayUpIndexViewController.m
//  jokebook
//
//  Created by tongsheng lei on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EveryDayUpIndexViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "EveryDayListViewController.h"
#import "DataOfJockBook.h"


@interface EveryDayUpIndexViewController ()

@end

@implementation EveryDayUpIndexViewController
@synthesize listTitle;
@synthesize typeUrl;
@synthesize connection;
@synthesize titleData;
@synthesize List;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleData = [[NSData alloc] init];
    List = [[NSArray alloc] init];
   //self.navigationController.navigationBarHidden = NO;
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"IMG_0078.png"];
//    [self.view addSubview:imageView];
    //    [imageView release];
      // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Item1Bg.png"]];
    CloudView *cloud = [[CloudView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 44, self.view.frame.size.width, self.view.frame.size.height-44)
                                           andNodeCount:31];
    
    cloud.delegate = self;
    [self.view addSubview:cloud];

	// Do any additional setup after loading the view.
}

- (void)didSelectedNodeButton:(CloudButton *)button
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    NSLog(@"---%d",button.tag);
    listTitle = button.titleLabel.text;
      NSLog(@"--listTitle-%@",listTitle);
  

    

}

- (void)myTask
{
    // Do something usefull in here instead of sleeping ...
   // sleep(3);
    // 创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    animation.delegate = self;
    // 设定动画时间
    animation.duration = 0.7;
    // 设定动画快慢(开始与结束时较慢)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    
    // 设定动画方向
    //   animation.subtype = kCATransitionFromLeft;
    //        // 动画开始
    

        [self performSegueWithIdentifier:@"item1_1" sender:nil];

    
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //    if ([[segue identifier] isEqualToString:@"xiangxi"]){
    //下一视图返回按钮
//    self.navigationItem.backBarButtonItem=  [[UIBarButtonItem alloc]initWithTitle:@"返回"
//                                                                            style:UIBarButtonItemStylePlain
//                                                                           target:nil                                                                       
//                                                                           action:nil];
    
       
    // 得到目标视图
    EveryDayListViewController *viewController = segue.destinationViewController;
    viewController.title = listTitle;
    
    //测试
    if ([listTitle isEqualToString:@"夫妻"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_2_1.html"];
    }
    if ([listTitle isEqualToString:@"古代"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_3_1.html"];
    }
    if ([listTitle isEqualToString:@"恶心"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_29_1.html"];
    }
    if ([listTitle isEqualToString:@"经营"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_10_1.html"];
    }
    if ([listTitle isEqualToString:@"明星"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_18_1.html"];
    }
    if ([listTitle isEqualToString:@"爱情"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_4_1.html"];
    }
    if ([listTitle isEqualToString:@"恐怖"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_16_1.html"];
    }
    if ([listTitle isEqualToString:@"歌词"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_6_1.html"];
    }
    if ([listTitle isEqualToString:@"校园"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_17_1.html"];
    }
    if ([listTitle isEqualToString:@"体育"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_11_1.html"];
    }
    if ([listTitle isEqualToString:@"名著"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_34_1.html"];
    }
    if ([listTitle isEqualToString:@"宗教"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_26_1.html"];
    }
    if ([listTitle isEqualToString:@"儿童"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_1_1.html"];
    }
    if ([listTitle isEqualToString:@"文艺"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_7_1.html"];
    }
    if ([listTitle isEqualToString:@"医疗"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_5_1.html"];
    }
    if ([listTitle isEqualToString:@"电脑"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_8_1.html"];
    }
    if ([listTitle isEqualToString:@"愚人"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_20_1.html"];
    }
    if ([listTitle isEqualToString:@"恋爱"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_33_1.html"];
    }
    if ([listTitle isEqualToString:@"司法"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_12_1.html"];
    }
    if ([listTitle isEqualToString:@"英语"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_24_1.html"];
    }
    if ([listTitle isEqualToString:@"交通"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_13_1.html"];
    }
    if ([listTitle isEqualToString:@"原创"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_14_1.html"];
    }
    if ([listTitle isEqualToString:@"交往"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_19_1.html"];
    }
    if ([listTitle isEqualToString:@"综合"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_22_1.html"];
    }
    if ([listTitle isEqualToString:@"动物"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_15_1.html"];
    }
    if ([listTitle isEqualToString:@"求爱"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_32_1.html"];
    }
    if ([listTitle isEqualToString:@"民间"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_27_1.html"];
    }
    if ([listTitle isEqualToString:@"趣闻"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_28_1.html"];
    }
    if ([listTitle isEqualToString:@"饶舌"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_31_1.html"];
    }
    if ([listTitle isEqualToString:@"爆笑"]) {
        typeUrl = [NSURL URLWithString:@"http://xiaohua.zol.com.cn/list_35_1.html"];
    }
   //设置缓存
    NSString *UrlString = [typeUrl absoluteString];
    if ([UrlString length] == 0){
        NSLog(@"Nil or empty URL is given");
        return;
    }
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    //设置缓存大小为1m
    [urlCache  setMemoryCapacity:1*1024*1024];
    //
    typeUrl = [NSURL URLWithString:UrlString];
    //创建一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:typeUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    //从请求中获取缓存输出
    NSCachedURLResponse *reponse = [urlCache cachedResponseForRequest:request];
    NSLog(@"first is reponse%@",reponse);
    //判断是否缓存
    if (reponse != nil) {
        NSLog(@"如果有缓存从缓存输出，从缓存获取数据");
        [request setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    }
    else {
        // [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        
    }
    self.connection = nil;
    /* 创建NSURLConnection*/
    NSURLConnection *newConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    self.connection = newConnection;
    
    titleData = [reponse data];
    if (titleData == nil) {
        titleData =  [[NSData alloc] initWithContentsOfURL:typeUrl];
    }
    

    
    viewController.strUrl = typeUrl;
    //网络加载数据
    DataOfJockBook *dataMenuList = [[DataOfJockBook alloc] init];
    List = [dataMenuList jockList:titleData];
   
    viewController.arryList = List;
    
    

}

- (void)  connection:(NSURLConnection *)connection
  didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"将接收输出");
}
- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse{
    NSLog(@"即将发送请求");
    return(request);
}
- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data{
    NSLog(@"接受数据");
    NSLog(@"数据长度为 = %lu", (unsigned long)[data length]);
 //   NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"strData is %@",data);
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    NSLog(@"将缓存输出");
    //网络加载数据
    
//    DataOfJockBook *dataMenuList = [[DataOfJockBook alloc] init];
//    List = [dataMenuList jockList:[cachedResponse data]];
    return(cachedResponse);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"请求完成");

}
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error{
    NSLog(@"请求失败");
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

@end
