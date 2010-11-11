//
//  ProductCell.m
//  zhaoia
//
//  Created by roscus on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

@synthesize title;
@synthesize price;
@synthesize review;
@synthesize shop;
@synthesize image;
@synthesize pic;
@synthesize imgSrc;
@synthesize url;
@synthesize indicator;
@synthesize sign;
@synthesize detail;
@synthesize titleString;
@synthesize priceString;
@synthesize reviewString;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)dealloc {
	
	[title release];
	[price release];
	[review release];
	[shop release];
	[image release];
	[pic release];
	[imgSrc release];
	[url release];
	[indicator release];
	[detail release];
	[sign release];
	[detail release];
	[titleString release];
	[priceString release];
	[reviewString release];
    [super dealloc];
}

- (void) setWithData:(NSDictionary *)data{
	NSString *new_sign = (NSString *)[data objectForKey:@"id"];
	if (self.sign && [self.sign compare:new_sign] == NSOrderedSame){
		NSLog(@"use the same image");
	} else {
		self.pic = nil;
		self.sign = new_sign;
	}

	self.titleString = (NSString *)[data objectForKey:@"title"];
	self.priceString = [self validPrice:(NSNumber *)[data objectForKey:@"price"]];
	self.reviewString= [NSString stringWithFormat:@"评论:%d",[self validReview:(NSNumber *)[data objectForKey:@"review"]]];
	self.url = (NSString *)[data objectForKey:@"url"];
	self.imgSrc = (NSString *)[data objectForKey:@"image"];
	//self.pic = nil;
	[self reset];
	[self setAll];
	NSLog(@"product cell title:%@",self.titleString);
	NSLog(@"product cell price:%@",self.priceString);
	NSLog(@"product cell review:%@",self.reviewString);
	NSLog(@"product cell image:%@",self.imgSrc);
	NSLog(@"product cell url:%@",self.url);
	NSLog(@"product cell sign:%@",self.sign);
}

- (void) setTitleView{
	self.title.text = self.titleString;
}

- (void) setPriceView{
	self.price.text = self.priceString;
}

- (void) setReviewView{
	self.review.text = self.reviewString;
}

- (void) setAll{
	[self setTitleView];
	[self setPriceView];
	[self setReviewView];
	[self setShopIcon:self.url];
	if (pic == nil) {
		[self addIndicator];
		[NSThread detachNewThreadSelector:@selector(setImageViewWithThread) toTarget:self withObject:nil];
	} else {
		[self setImageView];
	}
}

- (void) reset{
	[self.shop setBackgroundImage:nil forState:UIControlStateNormal];
	[self.shop setTitle:nil forState:UIControlStateNormal];
}

- (void) setImageView{
	[self.image setImage:[Util scaleImage:self.pic Size:CGSizeMake(108.0f, 78.0f)] forState:UIControlStateNormal];
}

- (void) setImageViewHandler{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"downlaod image:%@",self.imgSrc);
	UIImage *img = [Util getImage:self.imgSrc];
	self.pic = img;
	[self removeIndicator];
	[self setImageView];
	[img release];
	[pool release];
}

- (void) setImageViewWithThread{
	[self performSelectorOnMainThread: @selector(setImageViewHandler) withObject:nil waitUntilDone:NO];
}

- (void) addIndicator{
	indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	indicator.center = CGPointMake(image.bounds.size.width/2, image.bounds.size.height/2);
	[indicator startAnimating];
	[image addSubview:indicator];
}

- (void) removeIndicator{
	[indicator removeFromSuperview];
	[indicator release];
}

- (IBAction)goProductWebSite:(id)sender{
	[Util browserURL:self.url];
}

- (IBAction)popProductImage:(id)sender{
	UIImage *scaledImage = [Util scaleImage:self.pic Size:CGSizeMake(300.0f, 300.0f)];
	ProductImagePopUpDialog *pop = [[ProductImagePopUpDialog alloc] initWithImage:scaledImage];
	[pop show];
	[pop release];
}

- (IBAction)seeDetail:(id)sender{
	NSString *u = [Util getDetailURL:self.sign];
	[Util browserURL:u];
}

- (void)setShopIcon:(NSString *)productURL{
	NSString *imageName;
	if ([productURL hasPrefix:@"http://www.360buy"]) {
		imageName = @"360buy_icon.jpg";
	} else if ([productURL hasPrefix:@"http://www.amazon"]) {
		imageName = @"amazon_icon.png";
	} else if ([productURL hasPrefix:@"http://list.3c.taobao"]) {
		imageName = @"taobao_3c_icon.png";
	} else if ([productURL hasPrefix:@"http://www.icson"]) {
		imageName = @"icson_icon.png";
	} else if ([productURL hasPrefix:@"http://www.newegg"]) {
		imageName = @"newegg_icon.png";
	} else {
		imageName = nil;
		NSLog(@"get shop name error:%@",productURL);
	}
	UIImage *shopIconImage = [UIImage imageNamed:imageName];
	if (shopIconImage != nil) {
		[self.shop setBackgroundImage:shopIconImage forState:UIControlStateNormal];
	} else {
		[self.shop setTitle:[Util getShopName:productURL] forState:UIControlStateNormal];
	}
}

- (NSString *)validPrice:(NSNumber *)p{
	int n = [p intValue];
	if (n <= 0) {
		return @"暂无价格";
	} else {
		return [NSString stringWithFormat:@"¥ %d",n];
	}
}

- (int)validReview:(NSNumber *)r{
	int n = [r intValue];
	return n < 0 ? 0 : n;
}

@end
