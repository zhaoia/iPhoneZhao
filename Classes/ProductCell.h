//
//  ProductCell.h
//  zhaoia
//
//  Created by roscus on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import	"Util.h"
#import "ProductImagePopUpDialog.h"

@interface ProductCell : UITableViewCell {
	
	UILabel *title;
	UILabel *price;
	UILabel *review;
	UIButton *shop;
	UIButton *image;
	UIImage *pic;
	UIButton *detail;
	
	NSString *titleString;
	NSString *priceString;
	NSString *reviewString;
	NSString *url;
	NSString *imgSrc;
	NSString *sign;
	UIActivityIndicatorView *indicator;

}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *price;
@property (nonatomic, retain) IBOutlet UILabel *review;
@property (nonatomic, retain) IBOutlet UIButton *shop;
@property (nonatomic, retain) IBOutlet UIButton *image;
@property (nonatomic, retain) IBOutlet UIButton *detail;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;
@property (nonatomic, retain) UIImage *pic;
@property (nonatomic, retain) NSString *imgSrc;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) NSString *priceString;
@property (nonatomic, retain) NSString *reviewString;
@property (nonatomic, retain) NSString *sign;

- (void)setTitleView;
- (void)setPriceView;
- (void)setReviewView;
- (void)setImageView;

- (void)setAll;
- (void)reset;

- (void)setImageViewHandler;

- (void)setShopIcon:(NSString *)productURL;

- (void)setWithData:(NSDictionary *)data;

- (void)addIndicator;

- (void)removeIndicator;

- (IBAction)goProductWebSite:(id)sender;

- (IBAction)popProductImage:(id)sender;

- (IBAction)seeDetail:(id)sender;

- (NSString *)validPrice:(NSNumber *)p;

- (int)validReview:(NSNumber *)r;

@end
