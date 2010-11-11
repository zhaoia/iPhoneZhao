//
//  zhaoiaViewController.m
//  zhaoia
//
//  Created by roscus on 10/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "zhaoiaViewController.h"

@implementation zhaoiaViewController

@synthesize search;
@synthesize input;
@synthesize logo;
@synthesize table;
@synthesize previous;
@synthesize next;
@synthesize pageLabel;
@synthesize list;
@synthesize keyword;
@synthesize sort;
@synthesize alert;
@synthesize webSite;
@synthesize intro;

- (NSDictionary *)getDictData{
	
	NSString *url = [Util getURL:keyword andPage:page andPerPage:per_page andSort:sort];
	NSLog(@"view controller request url:%@",url);
	NSDate *startDate = [[NSDate date] retain];
	NSString *response = [Util requestURL:url];
	NSDate *endDate = [NSDate date];
	downloadTime = [endDate timeIntervalSinceDate:startDate];
	NSLog(@"view controller response json:%@",response);
	if (response == nil){
		return nil;
	} else {
		NSDictionary *dict = [Util parseJSON:response];
		[response release];
		NSString *error = (NSString *)[dict objectForKey:@"error"];
		if (error != nil){
			NSLog(@"error:%@",error);
			return nil;
		} else 
			return dict;
	}
}

- (void)searchAndShow{
	[self pleaseWaitDialog];
	NSDictionary *dict = [self getDictData];
	[alert dismissWithClickedButtonIndex:0 animated:YES];
	total_rows = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"total_rows"]] intValue];
	NSLog(@"view controller total_rows:%d",total_rows);
	if (list == nil) {
		list = [[NSMutableArray alloc] init];
	} else {
		[list removeAllObjects];
	}
	NSArray *product_lists = (NSArray *)[dict objectForKey:@"product_lists"];
	for (id product in product_lists){
		[list addObject:product];
	}
	if (list == nil || [list count] == 0) {
		[self showWarning:@"Search no result"];
	} else {
		[self showMainFrame:NO];	
		[previous setEnabled:(BOOL)(page > 1)];
		[next setEnabled:(BOOL)(page*per_page < total_rows)];
		pageLabel.text = [NSString stringWithFormat:@"%d",page];
		[table reloadData];
	}
}	

- (IBAction)goSearch:(id)sender{
	per_page = 8;
	sort = @"";
	page = 1;
	keyword = input.text;
	if ([Util isEmptyString:keyword]) {
		keyword = nil;
		[self showMainFrame:YES];
		[self showWarning:@"You have input nothing!"];
	} else {
		NSLog(@"input keyword:%@",keyword);
		[previous setEnabled:NO];
		[self searchAndShow];
	}
}

- (IBAction)goPreviousPage:(id)sender{
	NSLog(@"go previous page");
	page = page - 1;
	[self searchAndShow];
}

- (IBAction)goNextPage:(id)sender{
	NSLog(@"go next page");
	page = page + 1;
	[self searchAndShow];
}

- (IBAction)goWebSite:(id)sender{
	[Util browserURL:@"http://www.zhaoia.com"];
}

- (void)dealloc {
	[search release];
	[input release];
	[logo release];
	[table release];
	[previous release];
	[next release];
	[pageLabel release];
	[list release];
	[keyword release];
	[sort release];
	[alert	release];
	[webSite release];
	[intro release];
    [super dealloc];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [list count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSUInteger row = [indexPath row];
	NSDictionary *dic = [self.list objectAtIndex:row];
	static NSString * identifier = @"ProductCell";
	ProductCell *cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil){
		NSArray *topLevelObjects=[[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (ProductCell *) currentObject;
				break;
			}
		}
	}
	[cell setWithData:dic];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 12;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 12.0)];
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor blackColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:10];
	headerLabel.frame = CGRectMake(0.0, 0.0, 300.0, 12.0);
	headerLabel.text = [NSString stringWithFormat:@"About %d Results(%.2fs) Total Download %.2f KB",total_rows,downloadTime,TotalDownloadSize/1000.0];
	[customView addSubview:headerLabel];
	[headerLabel release];
	return customView;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization				
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	downloadTime = 0.0;
	[self showMainFrame:YES];
    [super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)pleaseWaitDialog{
	alert = [[[UIAlertView alloc] initWithTitle:@"Loading...\nPlease Wait" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil] autorelease];
	[alert show];
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	indicator.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-50);
	[indicator startAnimating];
	[alert addSubview:indicator];
	[indicator release];
}

- (void)showWarning:(NSString *)message{
	UIAlertView *warn = [[[UIAlertView alloc] initWithTitle:@"Warning" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[warn show];
	/*
	UILabel *theTitle = [warn valueForKey:@"_titleLabel"];
	[theTitle setTextColor:[UIColor yellowColor]];
	UILabel *theBody = [warn valueForKey:@"_bodyTextLabel"];
	[theBody setTextColor:[UIColor blackColor]];
	UIImage *theImage = [UIImage imageNamed:@"zhaoia_product.png"];    
	theImage = [theImage stretchableImageWithLeftCapWidth:310 topCapHeight:125];
	CGSize theSize = [warn frame].size;
	UIGraphicsBeginImageContext(theSize);    
	[theImage drawInRect:CGRectMake(0, 0, theSize.width, theSize.height)];    
	theImage = UIGraphicsGetImageFromCurrentImageContext();    
	UIGraphicsEndImageContext();
	warn.layer.contents = (id)[theImage CGImage];
	 */
}

- (void) showMainFrame:(BOOL)main{
	logo.hidden = !main;
	webSite.hidden = !main;
	intro.hidden = !main;
	table.hidden = main;
	previous.hidden = main;
	next.hidden = main;
	pageLabel.hidden = main;
}

- (BOOL) textFieldShouldReturn:(UITextField*) textField {
    [textField resignFirstResponder]; 
    return YES;
}

@end
