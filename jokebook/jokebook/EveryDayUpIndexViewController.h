//
//  EveryDayUpIndexViewController.h
//  jokebook
//
//  Created by tongsheng lei on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CloudView.h"
@interface EveryDayUpIndexViewController : UIViewController<CloudViewDelegate,NSURLConnectionDataDelegate,MBProgressHUDDelegate>{
    NSString *listTitle;//下一页显示的标题
    NSURL *typeUrl;//对应类型的连接地址
    NSURLConnection *connection;
    NSData *titleData;//缓存数据
    NSArray  *List ;
    
    MBProgressHUD *HUD;

}
@property (nonatomic,strong) NSArray  *List ;
@property (nonatomic,strong) NSData *titleData;
@property (nonatomic,strong)  NSURLConnection *connection;
@property (nonatomic,strong)     NSString *listTitle;
@property (nonatomic,strong)     NSURL *typeUrl;//对应类型的连接地址
@end
