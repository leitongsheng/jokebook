//
//  EveryDayListViewController.m
//  jokebook
//
//  Created by tongsheng lei on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EveryDayListViewController.h"
#import "DataOfJockBook.h"
#import "BBCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ContextViewController.h"

#define KEY_TITLE @"title"
#define KEY_IMAGE_NAME @"image_name"
#define KEY_IMAGE @"image"

@interface EveryDayListViewController ()
    
-(void)setupShapeFormationInVisibleCells;
//-(void)loadDataSource;
-(float)getDistanceRatio;

@end

@implementation EveryDayListViewController
@synthesize strUrl,jockName,arryList;
@synthesize listtableView;
@synthesize jockContext;
@synthesize connection;
@synthesize contextData;
@synthesize imageNameStr;

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
    //arryList = [[NSArray alloc] init];
   
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ItemBg.png"]];
     // listtableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ItemBg.png"]];
//    NSLog(@"List is %d",[arryList count]);
  //  listtableView.backgroundView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ItemBg.png"]];
//    //设置默认的分割线为自定义分割线
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_listborder01.png"]];
    [listtableView setSeparatorColor:color];
//    
//    listtableView.frame = CGRectMake(self.view.frame.origin.x, 44, self.view.frame.size.width, self.view.frame.size.height- 44);
//    listtableView = [[UITableView alloc] initWithFrame: CGRectMake(self.view.frame.origin.x, 44, self.view.frame.size.width, self.view.frame.size.height- 44) style:UITableViewStylePlain];
    [listtableView setBackgroundColor:[UIColor clearColor]];
  //  listtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    listtableView.opaque=NO;
//    listtableView.showsHorizontalScrollIndicator=NO;
//    listtableView.showsVerticalScrollIndicator=NO;
//    listtableView.delegate = self;
//    listtableView.dataSource = self;
    
//    [self.view addSubview:listtableView];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    [self setupShapeFormationInVisibleCells];
//    
//}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 //   [self setupShapeFormationInVisibleCells];
}


//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [arryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *test = @"table";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:test];
   // BBCell *cell = (BBCell*)[tableView dequeueReusableCellWithIdentifier:test];
    if( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:test];
      //  cell = [[BBCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:test];
        
    }
   // NSDictionary *info = [mDataSource objectAtIndex:indexPath.row];
   // cell.textLabel.text = [[arryList objectAtIndex:indexPath.row] objectForKey:@"title"];
  //  [cell setCellTitle:[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]];
    NSLog(@"000 is %@",imageNameStr);
    UIImage *image =[UIImage imageNamed:imageNameStr];
    
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

    cell.imageView.image = finalImage;
        [cell.imageView setTransform:CGAffineTransformMakeScale(0.4, 0.4)];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textColor = cell.selected ? [UIColor orangeColor] : [UIColor greenColor];
    
    UIImageView *pressCellView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_listbg_press.png"]];
    cell.selectedBackgroundView = pressCellView; 
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  //  [cell setIcon:finalImage];
    
    if (indexPath.row < 10 && indexPath.row >= 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"  00%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]];
     //   [cell setCellTitle:[NSString stringWithFormat:@"  00%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]]];
        return cell;
    }
    if (indexPath.row < 100 && indexPath.row >= 10) {
         cell.textLabel.text = [NSString stringWithFormat:@"  0%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]];
        // [cell setCellTitle:[NSString stringWithFormat:@"  0%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]]];
        return cell;
    }
    else {
         cell.textLabel.text = [NSString stringWithFormat:@"  %d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]];
        // [cell setCellTitle:[NSString stringWithFormat:@"  %d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]]];
        return cell;
    }


  //  [cell setIcon:[info objectForKey:KEY_IMAGE]];
    
    return cell;
    
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    if (indexPath.row < 10 && indexPath.row >= 0) {
//        cell.textLabel.text = [NSString stringWithFormat:@"00%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]];
//        return cell;
//    }
//    if (indexPath.row < 100 && indexPath.row >= 10) {
//        cell.textLabel.text = [NSString stringWithFormat:@"0%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]];
//        return cell;
//    }
//    else {
//        cell.textLabel.text = [NSString stringWithFormat:@"%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]];
//        return cell;
//    }
//    
//    
//    return cell;
}

//#define HORIZONTAL_RADIUS_RATIO 0.8
//#define VERTICAL_RADIUS_RATIO 1.3
//#define HORIZONTAL_TRANSLATION -100.0;
//
//-(float)getDistanceRatio
//{
//    return (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? VERTICAL_RADIUS_RATIO : HORIZONTAL_RADIUS_RATIO);
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self setupShapeFormationInVisibleCells];
//}
//
//-(void)setupShapeFormationInVisibleCells
//{
//    NSArray *indexpaths = [listtableView indexPathsForVisibleRows];
//    float shift = ((int)listtableView.contentOffset.y % (int)listtableView.rowHeight);  
//    int totalVisibleCells =[indexpaths count];
//    float y = 0.0;
//    float radius = listtableView.frame.size.height/2.0f;
//    float xRadius = radius;
//    
//    for( NSUInteger index =0; index < totalVisibleCells; index++ )
//    {
//        BBCell *cell = (BBCell*)[listtableView cellForRowAtIndexPath:[ indexpaths objectAtIndex:index]];
//        CGRect frame = cell.frame;
//        //we get the yPoint on the circle of this Cell
//        y = (radius-(index*listtableView.rowHeight) );//ideal yPoint if the scroll offset is zero
//        y+=shift;//add the scroll offset
//        
//        
//        //We can find the x Point by finding the Angle from the Ellipse Equation of finding y
//        //i.e. Y= vertical_radius * sin(t )
//        // t= asin(Y / vertical_radius) or asin = sin inverse
//        float angle = asinf(y/(radius));
//        
//        //Apply Angle in X point of Ellipse equation
//        //i.e. X = horizontal_radius * cos( t )
//        //here horizontal_radius would be some percentage off the vertical radius. percentage is defined by HORIZONTAL_RADIUS_RATIO
//        //HORIZONTAL_RADIUS_RATIO of 1 is equal to circle
//        float x = (floorf(xRadius*[self getDistanceRatio])) * cosf(angle );
//        x = x + HORIZONTAL_TRANSLATION;
//        
//        frame.origin.x = x ;
//        if( !isnan(x))
//        {
//            cell.frame = frame;
//        }
//    }
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strUrl =[NSURL URLWithString:[ [arryList objectAtIndex:indexPath.row] objectForKey:@"href"]];
    jockName = [[arryList objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(myTaskItem2) onTarget:self withObject:nil animated:YES];

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
    
    
    [self performSegueWithIdentifier:@"item1_2" sender:nil];
    
    
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
   
    

}

- (void)myTaskItem2
{
   

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
    //NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //设置缓存
    NSString *UrlString = [strUrl absoluteString];
    if ([UrlString length] == 0){
        NSLog(@"Nil or empty URL is given");
        return;
    }
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    //设置缓存大小为1m
    [urlCache  setMemoryCapacity:1*1024*1024];
    //
    strUrl = [NSURL URLWithString:UrlString];
    //创建一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:strUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
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
    
    contextData = [reponse data];
    if (contextData == nil) {
        contextData =  [[NSData alloc] initWithContentsOfURL:strUrl];
    }
    
    
    
    
    //获取数据
    DataOfJockBook *contextBook = [[DataOfJockBook alloc] init];
    NSArray *contextArry = [contextBook jockContext:contextData];
    @try {
        if ([contextArry count] == 1) {
            NSLog(@"    %@",[contextArry objectAtIndex:1]);
        }
        else {
            for (int i = 0; i <[contextArry count]; i++) {
                NSLog(@"    %d%@",i+1,[contextArry objectAtIndex:i]);
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"error");
    }
    @finally {
        
    }
    jockContext = [contextArry componentsJoinedByString:@" \n    "];
    
    
    // 得到目标视图
    ContextViewController *viewController = segue.destinationViewController;
    viewController.title = self.jockName;
    viewController .jockContext = self.jockContext;
    
    
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}


@end
