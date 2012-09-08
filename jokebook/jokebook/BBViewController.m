//
//  BBViewController.m
//  CircleView
//
//  Created by Bharath Booshan on 6/8/12.
//  Copyright (c) 2012 Bharath Booshan Inc. All rights reserved.
//

#import "BBViewController.h"
#import "BBCell.h"
#import <QuartzCore/QuartzCore.h>
#import "EveryDayListViewController.h"
#import "DataOfJockBook.h"

#define KEY_TITLE @"title"
#define KEY_IMAGE_NAME @"image_name"
#define KEY_IMAGE @"image"
#define KEY_Url @"titleUrl"

@interface BBViewController ()
-(void)setupShapeFormationInVisibleCells;
-(void)loadDataSource;
-(float)getDistanceRatio;
@end

@implementation BBViewController
@synthesize listTitle;
@synthesize typeUrl;
@synthesize connection;
@synthesize titleData;
@synthesize List;
@synthesize imageNameStr;

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.navigationController.navigationBar.frame = CGRectMake(0, -44, 320, 44);
	// Do any additional setup after loading the view, typically from a nib.
    [mTableView setBackgroundColor:[UIColor clearColor]];
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.opaque=NO;
//    mTableView.showsHorizontalScrollIndicator=NO;
//    mTableView.showsVerticalScrollIndicator=NO;
    
    titleData = [[NSData alloc] init];
    List = [[NSArray alloc] init];
    
    UILabel *mainTitle = (UILabel*) [self.view viewWithTag:100];
    mainTitle.text = @"CRICKET \n LEGENDS";
    [self loadDataSource];
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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setupShapeFormationInVisibleCells];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupShapeFormationInVisibleCells];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mDataSource count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *test = @"table";
    BBCell *cell = (BBCell*)[tableView dequeueReusableCellWithIdentifier:test];
    if( !cell )
    {
        cell = [[BBCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:test];
        
    }
    NSDictionary *info = [mDataSource objectAtIndex:indexPath.row];
    [cell setCellTitle:[info objectForKey:KEY_TITLE]];
    [cell setIcon:[info objectForKey:KEY_IMAGE]];
    typeUrl =[info objectForKey:KEY_Url];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = [mDataSource objectAtIndex:indexPath.row];
    typeUrl =[NSURL URLWithString:[info objectForKey:KEY_Url]];
    listTitle = [info objectForKey:KEY_TITLE];
    imageNameStr= [info objectForKey:KEY_IMAGE_NAME];
    NSLog(@"imageName ------ is %@",imageNameStr);
    
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
    
    // 得到目标视图
    EveryDayListViewController *viewController = segue.destinationViewController;
    viewController.title = listTitle;
    
    
    
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
 //   NSLog(@"first is reponse%@",reponse);
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
    viewController.imageNameStr = self.imageNameStr;
    
    
    
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
  //  NSLog(@"strData is %@",data);
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




#define HORIZONTAL_RADIUS_RATIO 0.8
#define VERTICAL_RADIUS_RATIO 1.2
#define HORIZONTAL_TRANSLATION -130.0;

-(float)getDistanceRatio
{
    return (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? VERTICAL_RADIUS_RATIO : HORIZONTAL_RADIUS_RATIO);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setupShapeFormationInVisibleCells];
}

-(void)setupShapeFormationInVisibleCells
{
    NSArray *indexpaths = [mTableView indexPathsForVisibleRows];
    float shift = ((int)mTableView.contentOffset.y % (int)mTableView.rowHeight);  
    int totalVisibleCells =[indexpaths count];
    float y = 0.0;
    float radius = mTableView.frame.size.height/2.0f;
    float xRadius = radius;
    
    for( NSUInteger index =0; index < totalVisibleCells; index++ )
    {
        BBCell *cell = (BBCell*)[mTableView cellForRowAtIndexPath:[ indexpaths objectAtIndex:index]];
        CGRect frame = cell.frame;
        //we get the yPoint on the circle of this Cell
        y = (radius-(index*mTableView.rowHeight) );//ideal yPoint if the scroll offset is zero
        y+=shift;//add the scroll offset
        
        
        //We can find the x Point by finding the Angle from the Ellipse Equation of finding y
        //i.e. Y= vertical_radius * sin(t )
        // t= asin(Y / vertical_radius) or asin = sin inverse
        float angle = asinf(y/(radius));
        
        //Apply Angle in X point of Ellipse equation
        //i.e. X = horizontal_radius * cos( t )
        //here horizontal_radius would be some percentage off the vertical radius. percentage is defined by HORIZONTAL_RADIUS_RATIO
        //HORIZONTAL_RADIUS_RATIO of 1 is equal to circle
        float x = (floorf(xRadius*[self getDistanceRatio])) * cosf(angle );
        x = x + HORIZONTAL_TRANSLATION;
        
        frame.origin.x = x ;
        if( !isnan(x))
        {
            cell.frame = frame;
        }
    }
}

-(void)loadDataSource
{
    NSMutableArray *dataSource = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    
    mDataSource = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //generate image clipped in a circle
        for( NSDictionary * dataInfo in dataSource )
        {
            NSMutableDictionary *info = [dataInfo mutableCopy];
            UIImage *image = [UIImage imageNamed:[info objectForKey:KEY_IMAGE_NAME]];
            UIImage *finalImage = nil;
            UIGraphicsBeginImageContext(image.size);
            {
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGAffineTransform trnsfrm = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.0, -1.0));
                trnsfrm = CGAffineTransformConcat(trnsfrm, CGAffineTransformMakeTranslation(0.0, image.size.height));
                CGContextConcatCTM(ctx, trnsfrm);
                CGContextBeginPath(ctx);
                CGContextAddEllipseInRect(ctx, CGRectMake(0.0, 0.0, image.size.width, image.size.height));
                CGContextClip(ctx);
                CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, image.size.width, image.size.height), image.CGImage);
                finalImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            [info setObject:finalImage forKey:KEY_IMAGE];
            
            [mDataSource addObject:info];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [mTableView reloadData];
            [self setupShapeFormationInVisibleCells];
        });
    });
}

@end
