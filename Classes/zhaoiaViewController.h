//
//  zhaoiaViewController.h
//  zhaoia
//
//  Created by roscus on 10/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"

@interface zhaoiaViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
	
	UIButton *search;
	UITextField *input;
	UIImageView *logo;
	UITableView *table;
	UIButton *previous;
	UIButton *next;
	UILabel *pageLabel;
	UIAlertView *alert;
	UIButton *webSite;
	UILabel *intro;
	
	NSMutableArray *list;
	NSString *keyword;
	int page;
	int per_page;
	NSString *sort;
	int total_rows;
	float downloadTime;

}

@property (nonatomic, retain) IBOutlet UITextField *input;
@property (nonatomic, retain) IBOutlet UIButton *search;
@property (nonatomic, retain) IBOutlet UIImageView *logo;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIButton *previous;
@property (nonatomic, retain) IBOutlet UIButton *next;
@property (nonatomic, retain) IBOutlet UILabel *pageLabel;
@property (nonatomic, retain) IBOutlet UIButton *webSite;
@property (nonatomic, retain) IBOutlet UILabel *intro;
@property (nonatomic, retain) UIAlertView *alert;
@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain) NSString *keyword;
@property (nonatomic, retain) NSString *sort;


- (IBAction)goSearch:(id)sender;

- (IBAction)goPreviousPage:(id)sender;

- (IBAction)goNextPage:(id)sender;

- (IBAction)goWebSite:(id)sender;

- (NSDictionary *) getDictData;

- (void) searchAndShow;

- (void) pleaseWaitDialog;

- (void) showWarning:(NSString *)message;

- (void) showMainFrame:(BOOL)main;

@end

