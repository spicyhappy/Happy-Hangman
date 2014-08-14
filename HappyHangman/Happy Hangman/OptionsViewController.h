//
//  OptionsViewController.h
//  Happy Hangman
//
//  Created by XIN XIN on 7/20/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OptionsViewController;

@protocol OptionsViewControllerDelegate
- (void)optionsViewControllerDidFinish:(OptionsViewController *)controller;
@end

@interface OptionsViewController : UIViewController

@property (weak, nonatomic) id <OptionsViewControllerDelegate> delegate;

// UI elements
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthLabel;
@property (weak, nonatomic) IBOutlet UISlider *allowedGuessesSlider;
@property (weak, nonatomic) IBOutlet UILabel  *allowedGuessesLabel;
@property (weak, nonatomic) IBOutlet UISwitch *easyModeSwitch;

// UI actions
- (IBAction)done:(id)sender;
- (IBAction)handleWordSlider;
- (IBAction)handleGuessSlider;

@end
