//
//  ViewController.h
//  II2300-PRP
//
//  Created by kostas vaggelakos on 11/29/11.
//  Copyright (c) 2011 fsefsef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface MainMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (IBAction)settingsButtonPressed:(id)sender;

@property (retain, nonatomic) IBOutlet UITableView *scheduleTableView;
@property (retain, nonatomic) IBOutlet UILabel *clockLabel;
- (IBAction)medicineTaken:(id)sender;
- (IBAction)showFamilyPhotos:(id)sender;

@end
