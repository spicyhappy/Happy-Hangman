//
//  MainViewController.m
//  Happy Hangman
//
//  Created by XIN XIN on 7/20/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self reset];
}

- (IBAction)reset {
    self.words = [[Words alloc] init];
    
    // Reset variables
    _guessesLeft = self.words.allowedGuesses;
    self.gameOver = NO;
    
    // Create an array to keep track of user guesses
    self.userGuesses = [NSMutableArray arrayWithObjects: nil];
    for (int i=1; i<=self.words.wordLength; i++) {
        [self.userGuesses addObject: @"_"];
    }
    
    [self resetUI];
}

- (IBAction) buttonPress:(UIButton *)sender {
    
    // Detect if button is abled to be pressed
    if (sender.enabled && !self.gameOver) {
        
        // Pass information to the equivalence class
        NSString *keyPressed = sender.titleLabel.text;        
        NSMutableArray *newGuesses = [self.words equivalenceGuess:keyPressed currentGuess:self.userGuesses];
        
        // Computer has foiled the user
        if (newGuesses == nil || [newGuesses count] == 0) {
            
            _guessesLeft--;
            [self message: [NSString stringWithFormat:@"Sorry, no %@'s. Chances left: %i.", keyPressed, _guessesLeft]];
            
            // Lose if no more guesses
            if (self.guessesLeft == 0) {
                self.gameOver = YES;
                [self message: [NSString stringWithFormat:@"You've lost! The answer is %@", self.words.solution]];
            }
        }
        
        // Computer could not foil the user
        else {
            self.userGuesses = newGuesses;
            [self updateGuessesLabel:self.userGuesses];
            
            // Win if all spaces are filled
            if (![newGuesses containsObject: @"_"]) {
                self.gameOver = YES;
                [self message: [NSString stringWithFormat:@"You're good at this! You won with %i chances left.",self.guessesLeft]];
            }
            
            else
                [self message: [NSString stringWithFormat:@"Great job! %i changes left.", _guessesLeft]];
            
        }
        
        // Disable button
        sender.enabled = NO;    
    }
}

#pragma mark - View Methods

- (void)message:(NSString *)aMessage {
    self.messageLabel.text = aMessage;
}

- (void)updateGuessesLabel:(NSString *)aGuess {
    self.guessesLabel.text = [[aGuess valueForKey:@"description"] componentsJoinedByString:@" "];
}

- (void)resetUI {
    [self updateGuessesLabel:self.userGuesses];
    [self message:[NSString stringWithFormat:@"Pick a letter. Chances left: %i.", _guessesLeft]];
    for (UIButton *button in self.buttonArray) {
        button.enabled = YES;
    }
}

#pragma mark - Options View 

- (void)optionsViewControllerDidFinish:(OptionsViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showOptions:(id)sender {    
    OptionsViewController *controller = [[OptionsViewController alloc] initWithNibName:@"OptionsViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
