//
//  PhotoViewController.h
//  II2300-PRP
//
//  Created by kostas vaggelakos on 12/8/11.
//  Copyright (c) 2011 fsefsef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (void)startSlideShow;
@end
