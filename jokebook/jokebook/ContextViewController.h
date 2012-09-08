//
//  ContextViewController.h
//  jokebook
//
//  Created by tongsheng lei on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "UILabel+JCUI.h"
#import "JCDemo2.h"
//#import "JCGridMenuColumn.h"
#import <UIKit/UIKit.h>
@interface ContextViewController : UIViewController {

    NSString *jockName;
    NSString *jockContext;
    
    UITextView *contextField;
    UIToolbar *toolBar;
    UIBarButtonItem *preBtn;
    UIBarButtonItem *centerBtn;
    UIBarButtonItem *nextBtn;
    
    UILabel *titleName;
    
    UISegmentedControl *yangseChanged;
    
        JCDemo2 *demo2;

}


@property (nonatomic, strong) JCDemo2 *demo2;
@property NSInteger demoLoaded;

@property (nonatomic,strong) IBOutlet UISegmentedControl *yangseChanged;
@property (nonatomic,strong)NSString *jockName;
@property (nonatomic,strong)NSString *jockContext;

@property (nonatomic,strong) IBOutlet UITextView *contextField;
@property (nonatomic,strong) IBOutlet UIToolbar *toolBar;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *preBtn;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *centerBtn;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *nextBtn;

@property (nonatomic,strong) IBOutlet UILabel *titleName;

@end
