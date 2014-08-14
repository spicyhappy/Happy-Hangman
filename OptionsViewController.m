//
//  OptionsViewController.m
//  Happy Hangman
//
//  Created by XIN XIN on 7/20/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import "OptionsViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Set slider ranges
    self.wordLengthSlider.maximumValue = [defaults integerForKey:@"wordLengthMax"];
    self.wordLengthSlider.minimumValue = [defaults integerForKey:@"wordLengthMin"];
    self.allowedGuessesSlider.maximumValue = 26;
    self.allowedGuessesSlider.minimumValue = 1;
    
    // Set initial values
    self.wordLengthSlider.value = [defaults integerForKey:@"wordLength"];
    self.allowedGuessesSlider.value = [defaults integerForKey:@"allowedGuesses"];
    self.wordLengthLabel.text = [NSString stringWithFormat:@"%i", [defaults integerForKey:@"wordLength"]];
    self.allowedGuessesLabel.text = [NSString stringWithFormat:@"%i", [defaults integerForKey:@"allowedGuesses"]];
    [self.easyModeSwitch setOn:[defaults integerForKey:@"easyMode"]];
}

#pragma mark - Actions

- (IBAction)done:(id)sender {
    // Save values to system
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: (int)self.wordLengthSlider.value forKey:@"wordLength"];
    [defaults setInteger: (int)self.allowedGuessesSlider.value forKey:@"allowedGuesses"];
    
    // Save easy mode
    if (self.easyModeSwitch.on)
        [defaults setInteger:YES forKey:@"easyMode"];
    else
        [defaults setInteger:NO forKey:@"easyMode"];
    
    [self.delegate optionsViewControllerDidFinish:self];
}

- (IBAction)handleWordSlider {
    self.wordLengthLabel.text = [NSString stringWithFormat:@"%i", (int)self.wordLengthSlider.value];
}
- (IBAction)handleGuessSlider {
    self.allowedGuessesLabel.text = [NSString stringWithFormat:@"%i", (int)self.allowedGuessesSlider.value];
}

@end
