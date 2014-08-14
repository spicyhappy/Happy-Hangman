//
//  Words.h
//  Happy Hangman
//
//  Created by XIN XIN on 7/21/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Words : NSObject
    
@property (nonatomic) unsigned wordLength;
@property (nonatomic) unsigned allowedGuesses;
@property (nonatomic) BOOL easyMode;
@property (nonatomic) NSArray *wordList;
@property (nonatomic) NSString *solution;

- (void)loadSettings;
- (void)loadWordList;
- (NSMutableArray *)equivalenceGuess:(NSString *)letter currentGuess:(NSMutableArray *)guess;
- (NSNumber *)checkSumWord:(NSString *)aWord andCharacter:(NSString *)aLetter;

@end
