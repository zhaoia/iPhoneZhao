//
//  ProductImagePopUpDialog.m
//  zhaoia
//
//  Created by roscus on 10/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProductImagePopUpDialog.h"


@implementation ProductImagePopUpDialog

@synthesize backgroundImage;

- (id)initWithImage:(UIImage *)image{
    if (self = [super init]) {
        self.backgroundImage = image;
		self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	CGSize imageSize = self.backgroundImage.size;
	[self.backgroundImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
}

- (void) show {
	[super show];
	CGSize imageSize = self.backgroundImage.size;
	CGFloat size = imageSize.width > imageSize.height ? imageSize.width : imageSize.height;
	self.bounds = CGRectMake(0, 0, size, size);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)dealloc {
    [super dealloc];
}

@end
