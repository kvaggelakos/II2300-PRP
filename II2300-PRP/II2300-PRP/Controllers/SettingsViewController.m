//
//  SettingsViewController.m
//  II2300-PRP
//
//  Created by kostas vaggelakos on 11/30/11.
//  Copyright (c) 2011 fsefsef. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController(Private)

-(void)getSchedules;

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
    
    
}

-(void)getSchedules{
    
    NSURL *scheduleQueryURL = [NSURL URLWithString:@"http://91.123.201.165:10000/getSchedule"];
    ASIHTTPRequest *scheduleQueryRequest = [ASIHTTPRequest requestWithURL:scheduleQueryURL];
    
    [scheduleQueryRequest setCompletionBlock:^{
        
        NSString *response = scheduleQueryRequest.responseString;
        NSLog(@"response:%@",response);
        
    }];
    
    [scheduleQueryRequest setFailedBlock:^{
        
        NSLog(@"failed to get schedules");
        
    }];
    
    [scheduleQueryRequest startAsynchronous];
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
