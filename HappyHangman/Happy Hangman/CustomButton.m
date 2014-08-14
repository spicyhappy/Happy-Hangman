//
//  CustomButton.m
//  Happy Hangman
//
//  Created by XIN XIN on 7/20/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont fontWithName:@"Lato" size:self.titleLabel.font.pointSize];
}

- (void)drawRect:(CGRect)rect {
    if ([self isEnabled]) {
        [self setBackgroundColor:[UIColor redColor]];
    }
    else {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}


@end
