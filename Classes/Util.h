//
//  Util.h
//  zhaoia
//
//  Created by roscus on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

#define rootURL @"http://192.168.1.101:3000/service/get_product_lists/"
#define detailRootURL @"http://www.zhaoia.com/detail"

//
// mail to api@hellom2.com to ask for appkey and secretcode 
#define appkey @""
#define	secretcode @""
//
//

extern long TotalDownloadSize;

@interface Util : NSObject {
	
}

/* 由 md5,getURL,requestURL,parseJSON 四个函数即可获得
 * 查询结果。
 *
 * @params: keyword page per_page sort
 * @sort: ""(default) or "asc" or "desc"
 *
 * NSString *url=[getURL:keyword andPage:page andPerPage:per_page andSort:sort];
 * NSString *response=[requestURL url];
 * NSDictionary *dict=[parseJSON response];
 *
 * @dict: {"total_rows":..., "product_lists":[ {"price":..., ...}, {...}, ... ]}
 *
 */

// 计算字符串的MD5,返回大写16进制
+ (NSString *) md5:(NSString *)str;

// 
+ (NSString *) requestURL:(NSString *)url;

// 由关键字，页数，每页显示个数，排序方式组合出查询的URL
+ (NSString *) getURL:(NSString *)keyword andPage:(int)page andPerPage:(int)per_page andSort:(NSString *)sort;

// 对查询返回的结果（json字符串）进行解析，返回一个字典
+ (NSDictionary *) parseJSON:(NSString *)json;

+ (NSData *) getImageData:(NSString *)imageURL;

+ (void) browserURL:(NSString *)s;

+ (UIImage *) getImage:(NSString *)imageURL;

+ (NSString *) getShopName:(NSString *)url;

+ (BOOL) isEmptyString:(NSString *)string;

+ (UIImage *)scaleImage:(UIImage *)sourceImage Size:(CGSize)targetSize;

+ (NSString *)getDetailURL:(NSString *)pid;

@end
