//
//  SettingsViewController.h
//  II2300-PRP
//
//  Created by kostas vaggelakos on 11/30/11.
//  Copyright (c) 2011 fsefsef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "MBProgressHUD.h"


@interface SettingsViewController : UIViewController{
    SBJSON *jsonParser;
    MBProgressHUD *hud;
    NSString *token;
    IBOutlet UILabel *statusTxt;
}

@property (nonatomic, copy) NSString *token;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)login:(id)sender;

@end
