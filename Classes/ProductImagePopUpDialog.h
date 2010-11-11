//
//  ProductImagePopUpDialog.h
//  zhaoia
//
//  Created by roscus on 10/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductImagePopUpDialog : UIAlertView {

	UIImage *backgroundImage;
}

@property(readwrite, retain) UIImage *backgroundImage;

- (id) initWithImage:(UIImage *)backgroundImage;

@end
