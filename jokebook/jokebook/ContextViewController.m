//
//  ContextViewController.m
//  jokebook
//
//  Created by tongsheng lei on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContextViewController.h"

@interface ContextViewController ()

@end

@implementation ContextViewController
@synthesize centerBtn,contextField,titleName,toolBar,nextBtn,preBtn;
@synthesize jockName,jockContext;
@synthesize yangseChanged;
@synthesize demo2 = _demo2;
@synthesize demoLoaded = _demoLoaded;

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
    
        [self loadDemos];
    
    [self.yangseChanged addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    yangseChanged.selectedSegmentIndex = 1;
    

    //self.title = @"开心词典";
	// Do any additional setup after loading the view.
    //标题(过长的话自动换行)
//  self.titleName.font = [UIFont fontWithName:@"Georgia" size:17];
//    self.titleName.numberOfLines = 10;
//   // label.text = @"ddd0dsdsdsadsddddddddd";
//    CGSize size = CGSizeMake(300, 1000);
//    CGSize labelSize = [self.titleName.text sizeWithFont:self.titleName.font 
//                        constrainedToSize:size
//                                  lineBreakMode:UILineBreakModeClip];
//    self.titleName.frame = CGRectMake(self.titleName.frame.origin.x, self.titleName.frame.origin.y,
//                             self.titleName.frame.size.width, labelSize.height);
//    
//    self.titleName.text = self.jockName;
    
    //内容文本视图
    self.contextField.textColor = [UIColor orangeColor];
    self.contextField.font = [UIFont fontWithName:@"Arial" size:21.0];//设置字体名字和字体大小  
    
     //self.contextField.delegate = self;//设置它的委托方法  
     
     self.contextField.backgroundColor = [UIColor clearColor];//设置它的背景颜色

 
     self.contextField.scrollEnabled = YES;//是否可以拖动  
    
    self.contextField.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    self.contextField.text = self.jockContext;

}

-(void)Selectbutton:(int)sender{

    switch (yangseChanged.selectedSegmentIndex) {
        case 1:
            //内容文本视图
            self.contextField.textColor = [UIColor greenColor];
            break;
        case 0:
            //内容文本视图
            self.contextField.textColor = [UIColor whiteColor];
            break;
        default:
            //内容文本视图
            self.contextField.textColor = [UIColor orangeColor];
            break;
    }
}

- (void)loadDemos
{

    
    _demo2 = [[JCDemo2 alloc] init];
    [self.view addSubview:_demo2.view];
    

    
    [self loadDemo:1];
}

- (void)loadDemo:(NSInteger)demo
{
    switch (_demoLoaded) {
        case 1:
            [_demo2 close];
            break;
    }
    
    switch (demo) {
        case 1:
            [_demo2 open];
            break;

    }
    
    _demoLoaded = demo;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

@end
