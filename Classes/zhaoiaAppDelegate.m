//
//  zhaoiaAppDelegate.m
//  zhaoia
//
//  Created by roscus on 10/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "zhaoiaAppDelegate.h"
#import "zhaoiaViewController.h"

@implementation zhaoiaAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
