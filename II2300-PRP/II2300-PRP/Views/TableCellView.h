//
//  TableCellView.h
//  II2300-PRP
//
//  Created by kostas vaggelakos on 12/6/11.
//  Copyright (c) 2011 fsefsef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellView : UITableViewCell {
    IBOutlet UILabel *cellText;
    IBOutlet UILabel *descText;
}

- (void)setLabelText:(NSString *)_text;
- (void)setDescriptiveText:(NSString *)_text;

@end
