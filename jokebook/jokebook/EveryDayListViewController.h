//
//  EveryDayListViewController.h
//  jokebook
//
//  Created by tongsheng lei on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface EveryDayListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
{
    NSURL *strUrl;
    NSString *jockName;
    NSString *jockContext;
    NSArray *arryList;
    UITableView *listtableView;
    NSURLConnection *connection;
    NSData *contextData;
    NSString *imageNameStr;
        MBProgressHUD *HUD;
    
}
@property (strong,nonatomic) NSString *imageNameStr;
@property (strong,nonatomic) NSData *contextData;
@property (strong,nonatomic) NSURLConnection *connection;
@property (strong,nonatomic)   IBOutlet UITableView *listtableView;
@property (strong,nonatomic)  NSURL *strUrl;
@property (strong,nonatomic)  NSString *jockName;
@property (strong,nonatomic)  NSArray *arryList;
@property (strong,nonatomic)  NSString *jockContext;

@end
