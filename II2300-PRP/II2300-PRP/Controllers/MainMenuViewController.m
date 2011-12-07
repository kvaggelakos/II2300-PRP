//
//  ViewController.m
//  II2300-PRP
//
//  Created by kostas vaggelakos on 11/29/11.
//  Copyright (c) 2011 fsefsef. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SettingsViewController.h"

#define SCHEDULE_CELL_NAME @"SCHEDULE_CELL.xib"

@implementation MainMenuViewController
@synthesize scheduleTableView;
@synthesize clockLabel;
@synthesize schedules;
@synthesize tableCell;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        self.schedules = [NSMutableArray array];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"myPills - Pillbox";
}

- (void)viewDidUnload
{
    [self setScheduleTableView:nil];
    [self setClockLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)settingsButtonPressed:(id)sender
{
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc {
    [scheduleTableView release];
    [clockLabel release];
    [super dealloc];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource callback methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.schedules.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)
    indexPath{

    static NSString *MyIdentifier = @"tableCellView";
	
    NSDictionary *schedule = [self.schedules objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
	TableCellView *cell = (TableCellView *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"TableCellView" owner:self options:nil];
		cell = tableCell;
	}
	
	[cell setLabelText: [schedule objectForKey:@"medicineName"]];
    [cell setDescriptiveText:[NSString stringWithFormat:@"TO BE TAKEN AT:%@", [formatter stringFromDate:[schedule objectForKey:@"timeToTake"]]]];
	
    return cell;
}




- (IBAction)medicineTaken:(id)sender {
}

- (IBAction)showFamilyPhotos:(id)sender {
}
@end
