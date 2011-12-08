//
//  SettingsViewController.m
//  II2300-PRP
//
//  Created by kostas vaggelakos on 11/30/11.
//  Copyright (c) 2011 fsefsef. All rights reserved.
//

#import "SettingsViewController.h"
#import "MainMenuViewController.h"

@interface SettingsViewController(Private)

-(void)getSchedules;
-(void)configureSchedules;

@end

@implementation SettingsViewController
@synthesize token;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        jsonParser = [[SBJSON alloc] init]; 
        
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)dealloc {
    [jsonParser release];
    [hud release];
    [token release];
    [super dealloc];
}

#pragma mark - Action handlers

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)login:(id)sender 
{    
    NSURL *loginURL = [NSURL URLWithString:@"http://91.123.201.165:10000/login"];
    ASIHTTPRequest *loginRequest = [ASIHTTPRequest requestWithURL:loginURL];
    
    // Show a loading screen til we get response
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Trying to login";
    
    [loginRequest setCompletionBlock:^{
        [hud hide:YES];
        
        NSString *response = loginRequest.responseString;
        NSLog(@"[LOGIN] Response from server: %@", response);
        
        NSError *error = nil;
        id responseObject = [jsonParser objectWithString:response error:&error];
        if (error) {
            NSLog(@"error parsing json object:%@",[error localizedDescription]);
        }
        
        token = [NSString stringWithFormat:@"%d", [responseObject objectForKey:@"token"]];
        NSLog(@"[LOGIN] Token received by server: %@", token);
        
        if ([token length] == 0) {
            NSLog(@"[LOGIN] Login did not receive any token, user not authenticated");
            [statusTxt setText:@"Login unsucessful"];
        } else {
            NSLog(@"[LOGIN] Login sucessful!");
            [statusTxt setText:@"Login sucessful!"];
            [NSThread sleepForTimeInterval:1];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [self getSchedules];
    }];
    
    
    [loginRequest setFailedBlock:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"[LOGIN] Failed to get login response");
        [statusTxt setText:@"Couldn't connect to the server!"];
    }];
    
    [loginRequest startAsynchronous];
    
    [self configureSchedules];
}

- (IBAction)editEnd:(id)sender 
{
    [sender resignFirstResponder];
}

#pragma mark - Function for fetching data

-(void)getSchedules
{    
    NSURL *scheduleQueryURL = [NSURL URLWithString:@"http://91.123.201.165:10000/getSchedule"];
    ASIHTTPRequest *scheduleQueryRequest = [ASIHTTPRequest requestWithURL:scheduleQueryURL];
    
    [scheduleQueryRequest setCompletionBlock:^{
        
        NSString *response = scheduleQueryRequest.responseString;
        NSLog(@"response:%@",response);
        NSError *error = nil;
        id responseObject = [jsonParser objectWithString:response error:&error];
        NSLog(@"responseObject:%@",responseObject);
        
        [self configureSchedules];
        
    }];
    
    [scheduleQueryRequest setFailedBlock:^{
        NSLog(@"failed to get schedules");
    }];
    
    [scheduleQueryRequest startAsynchronous];
}

-(void)configureSchedules
{    
    MainMenuViewController *mainMenuViewController = [self.navigationController.viewControllers objectAtIndex:0];
    
    [mainMenuViewController.schedules removeAllObjects];
    
    for (int i = 0; i < 4; i++) {
        
        NSString *medicineName = [NSString stringWithFormat:@"Medicine %d", i];
        NSDate *timeToTake = [NSDate dateWithTimeIntervalSinceNow:(i * 1000)];
        NSString *medicineDescription = [NSString stringWithFormat:@"This is the description for medicine %d", i];
        NSDictionary *schedule = [NSDictionary dictionaryWithObjectsAndKeys:medicineName, @"medicineName", timeToTake, @"timeToTake", medicineDescription, @"medicineDescription", nil];
        
        [mainMenuViewController.schedules addObject:schedule];
        
    }
    
    [mainMenuViewController.scheduleTableView reloadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
