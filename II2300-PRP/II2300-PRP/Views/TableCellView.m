//
//  TableCellView.m
//  II2300-PRP
//
//  Created by kostas vaggelakos on 12/6/11.
//  Copyright (c) 2011 fsefsef. All rights reserved.
//

#import "TableCellView.h"

@implementation TableCellView

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}

- (void)setLabelText:(NSString *)_text;{
	cellText.text = _text;
}

- (void)setDescriptiveText:(NSString *)_text {
    descText.text = _text;
}


@end
