//
//  DataOfJockBook.m
//  jokebook
//
//  Created by tongsheng lei on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataOfJockBook.h"
#import "TFHpple.h"

@implementation DataOfJockBook

//获取笑话目录（夫妻）
- (NSMutableArray *) jockList:(NSData *)siteData{
    
   // NSData *siteData = [[NSData alloc] initWithContentsOfURL:URL];
    
    NSString *strData = [[NSString alloc]initWithData:siteData encoding:NSUTF8StringEncoding];
 //   NSLog(@"strData is ------%@",strData);
	
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:siteData];
    
	NSArray *elements = [xpathParser searchWithXPathQuery:@"//html/body/center/div[2]/div[2]/div[1]/div[2]/div/div/div[1]/a"];
    
	NSMutableArray *jockList = [[NSMutableArray alloc] init];
    
    //NSLog(@">>image count is: %d",[elements count]) ;
    
    for (int i = 0; i < [elements count]; i ++) {
        
        TFHppleElement *element = [elements objectAtIndex:i];  
        NSString *strTitle = [element objectForKey:@"title"]; 
        
         // NSLog(@"element is %@",strTitle);
        NSString *strUrl = [NSString  stringWithFormat:@"http://xiaohua.zol.com.cn/%@",[element objectForKey:@"href"]]; 
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        TFHppleElement *element = [elements objectAtIndex:i];  
//        NSString *str = [element content];
        if (strTitle) {
          //  [jockList addObject:strTitle];
            [dict setValue:strTitle forKey:@"title"];
           // NSLog(@"strTitle is %@",strTitle);
        }
        if (strUrl) {
           // [jockList addObject:strUrl];
            [dict setValue:strUrl forKey:@"href"];
            //NSLog(@"strUrl is %@",strUrl);
        }
        
        [jockList addObject:dict];
        
    }
    
    return jockList;



}


//获取笑话内容（夫妻）
- (NSMutableArray *) jockContext:(NSData *)contextData
{
    //NSData *siteData = [[NSData alloc] initWithContentsOfURL:URL];
   // NSString *strData = [[NSString alloc]initWithData:siteData encoding:NSUTF8StringEncoding];
   // NSLog(@"strData is %@",strData);
	
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:contextData];
    
	NSArray *elements = [xpathParser searchWithXPathQuery:@"//html/body/center/div[2]/div[2]/div[1]/div[2]/div[2]"];
    
	NSMutableArray *jockContext = [[NSMutableArray alloc] init];
    
    //NSLog(@">>image count is: %d",[elements count]) ;
    
    for (int i = 0; i < [elements count]; i ++) {
        
        TFHppleElement *element = [elements objectAtIndex:i];  

        NSArray *str = [element children];
             //  NSLog(@"strCount is %d",[str count]);
        for (int i = 0 ; i < [str count]; i ++) {
             TFHppleElement *elementContext = [str objectAtIndex:i];  
             NSString *strContext = [elementContext content]; 
            if (strContext) {
                [jockContext addObject:strContext];
            }
           // NSLog(@"strTitle  ---- is  --%@",strContext);
        }
        

        
    }
    
    return jockContext;


}

- (NSInteger) theCountOfPages:(NSURL *)url
{
    NSData *siteData = [[NSData alloc] initWithContentsOfURL:url];
    NSString *strData = [[NSString alloc]initWithData:siteData encoding:NSUTF8StringEncoding];
    NSLog(@"strData is %@",strData);
    
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:siteData];
    
	NSArray *elements = [xpathParser searchWithXPathQuery:@"//html/body/center/div[2]/div[2]/div[1]/div[1]/div[6]/a"];
    
//	NSMutableArray *jockContext = [[NSMutableArray alloc] init];
    
    TFHppleElement *element = [elements objectAtIndex:0];
      NSArray *str = [element children];
    
    TFHppleElement *elementContext = [str objectAtIndex:0];  
    NSString *strContext = [elementContext content]; 
    NSLog(@"strTotalPages is %@",strContext);

}

@end
