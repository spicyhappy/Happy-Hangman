//
//  CustomFontLabelBold.m
//  Happy Hangman
//
//  Created by XIN XIN on 7/20/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import "CustomFontLabel.h"

@implementation CustomFontLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"Lato" size:self.font.pointSize];
}

@end
