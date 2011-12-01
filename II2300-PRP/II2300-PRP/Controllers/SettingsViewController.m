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

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)login:(id)sender {
    
    NSURL *loginURL = [NSURL URLWithString:@"http://91.123.201.165:10000/login"];
    ASIHTTPRequest *loginRequest = [ASIHTTPRequest requestWithURL:loginURL];
    [loginRequest setCompletionBlock:^{
        
        NSString *response = loginRequest.responseString;
        NSLog(@"response:%@",response);
        NSError *error = nil;
        id responseObject = [jsonParser objectWithString:response error:&error];
        if (error) {
            
            NSLog(@"error parsing json object:%@",[error localizedDescription]);
        
        }
        
        self.token = [responseObject objectForKey:@"token"];
        NSLog(@"self.token = %@",token);
        [self getSchedules];
    
    }];
    
    
    [loginRequest setFailedBlock:^{
        
        NSLog(@"fail to get login response");
        
    }];
    
    [loginRequest startAsynchronous];
    
    // this should be invoked after getschedule query response is fetched successfully in -(void)getSchedules.
    [self configureSchedules];
    
}

-(void)getSchedules{
    
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

-(void)configureSchedules{
    
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
