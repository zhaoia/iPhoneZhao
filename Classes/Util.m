//
//  Util.m
//  zhaoia
//
//  Created by roscus on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
#import "JSON.h"

long TotalDownloadSize = 0L;

@implementation Util

+ (NSString *) md5:(NSString *)str{
	
	const char *cStr = str.UTF8String;
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString 
			stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",			
			result[0], result[1],			
			result[2], result[3],
			result[4], result[5],			
			result[6], result[7],			
			result[8], result[9],			
			result[10], result[11],			
			result[12], result[13],			
			result[14], result[15]			
			];	
}

+ (NSString *) requestURL:(NSString *)url{
	
	NSError *error;
	NSURLResponse *response;
	NSData *dataReply;
	NSString *stringReply;
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"GET"];
	dataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	TotalDownloadSize += [dataReply length];
	stringReply = [[NSString alloc] initWithData:dataReply encoding:NSUTF8StringEncoding];
	return stringReply;
}

+ (NSString *) getURL:(NSString *)keyword andPage:(int)page andPerPage:(int)per_page andSort:(NSString *)sort{
	NSString *source = [NSString stringWithFormat:@"appkey=%@&keyword=%@&page=%d&per_page=%d&sort=%@",appkey,keyword,page,per_page,sort];
	NSString *sign = [Util md5:[NSString stringWithFormat:@"%@&secretcode=%@",source,secretcode]];
	NSString *url = [NSString stringWithFormat:@"%@?%@&sign=%@",rootURL,source,sign];
	return url;
}

+ (NSDictionary *) parseJSON:(NSString *)json{
	if (json == nil)
		return nil;
	NSDictionary *dict = [json JSONValue];
	return dict;
}

+ (NSData *) getImageData:(NSString *)imageURL{
	NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageURL]];
	TotalDownloadSize += [mydata length];
	return mydata;
}

+ (void) browserURL:(NSString *)s{
	NSURL *URL = [NSURL URLWithString:s];
	[[UIApplication sharedApplication] openURL:URL];
}

+ (UIImage *) getImage:(NSString *)imageURL{
	NSData *imageData = [Util getImageData:imageURL];
	UIImage *img = [[UIImage alloc] initWithData:imageData];
	[imageData release];
	return img;
}

+ (NSString *) getShopName:(NSString *)url{
	NSString *shopName = @"";
	if ([url hasPrefix:@"http://www.360buy"]) {
		shopName = @"京东商城";
	} else if ([url hasPrefix:@"http://www.amazon"]) {
		shopName = @"卓越亚马逊";
	} else if ([url hasPrefix:@"http://list.3c.taobao"]) {
		shopName = @"淘宝电器城";
	} else if ([url hasPrefix:@"http://www.icson"]) {
		shopName = @"易讯商城";
	} else if ([url hasPrefix:@"http://www.newegg"]) {
		shopName = @"新蛋商城";
	}
	return shopName;
}

+ (BOOL) isEmptyString:(NSString *) string {
	if([string length] == 0) {
		return YES;
	} else if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0){
		//string is all whitespace
		return YES;
	}
	return NO;
}

+ (UIImage *)scaleImage:(UIImage *)sourceImage Size:(CGSize)targetSize{
	UIImage *newImage = nil;
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		if (widthFactor < heightFactor) 
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		if (widthFactor < heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
		} else if (widthFactor > heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	UIGraphicsBeginImageContext(targetSize);
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	[sourceImage drawInRect:thumbnailRect];
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage ;
}

+ (NSString *)getDetailURL:(NSString *)pid{
	return [NSString stringWithFormat:@"%@?pid=%@",detailRootURL,pid];
}

@end
