//
//  DataOfJockBook.h
//  jokebook
//
//  Created by tongsheng lei on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataOfJockBook : NSObject


//获取笑话目录（夫妻）
- (NSMutableArray *) jockList:(NSData *)siteData;
//获取笑话内容（夫妻）
- (NSMutableArray *) jockContext:(NSData *)contextData;

//获取笑话总页数
- (NSInteger) theCountOfPages:(NSURL *)url;

@end
