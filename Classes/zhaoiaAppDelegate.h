//
//  zhaoiaAppDelegate.h
//  zhaoia
//
//  Created by roscus on 10/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class zhaoiaViewController;

@interface zhaoiaAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    zhaoiaViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet zhaoiaViewController *viewController;

@end

