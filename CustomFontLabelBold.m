//
//  CustomFontLabelBold.m
//  Happy Hangman
//
//  Created by XIN XIN on 7/20/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import "CustomFontLabelBold.h"

@implementation CustomFontLabelBold

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"Lato-Bold" size:self.font.pointSize];
}

@end
