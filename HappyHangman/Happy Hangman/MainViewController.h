//
//  MainViewController.h
//  Happy Hangman
//
//  Created by XIN XIN on 7/20/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import "OptionsViewController.h"
#import "Words.h"

@interface MainViewController : UIViewController <OptionsViewControllerDelegate>

// Controller properties
@property (nonatomic) Words *words;
@property (readonly, nonatomic) unsigned guessesLeft;
@property (nonatomic) NSMutableArray *userGuesses;
@property (nonatomic) unsigned wordLengthMax;
@property (nonatomic) unsigned wordLengthMin;
@property (nonatomic) BOOL gameOver;

// UI properties
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *guessesLabel;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttonArray;

// Controller actions
- (void)message:(NSString *)aMessage;
- (void)updateGuessesLabel:(NSArray *)aGuess;

// UI actions
- (IBAction)reset;
- (IBAction) buttonPress:(UIButton *)sender;
- (IBAction)showOptions:(id)sender;
- (void)resetUI;



@end
