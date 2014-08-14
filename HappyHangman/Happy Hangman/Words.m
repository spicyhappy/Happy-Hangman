//
//  Words.m
//  Happy Hangman
//
//  Created by XIN XIN on 7/21/13.
//  Copyright (c) 2013 XIN XIN. All rights reserved.
//

#import "Words.h"

@implementation Words

- (id)init
{
    if (self = [super init]) {
        
        // Set defaults if there are none
        [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserDefaults" ofType:@"plist"]]];
        
        [self loadSettings];
        [self loadWordList];
    }
    return self;
}

- (void)loadSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.wordLength = [defaults integerForKey:@"wordLength"];
    self.allowedGuesses = [defaults integerForKey:@"allowedGuesses"];
    self.easyMode = [defaults integerForKey:@"easyMode"];
}

- (void)loadWordList {

    NSMutableArray *words = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    NSMutableArray *wordsRightLength = [NSMutableArray array];
    NSString *longestWord;
    NSString *shortestWord;
    
    // Save words of the right length and remember the longest and shortest words
    for (NSString *word in words) {
        if (word.length == self.wordLength)
            [wordsRightLength addObject:word];
        if (longestWord == nil || (word.length > longestWord.length))
            longestWord = word;
        if (shortestWord == nil || (word.length < shortestWord.length))
            shortestWord = word;
    }
    
    // Save values
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:shortestWord.length forKey:@"wordLengthMin"];
    [defaults setInteger:longestWord.length forKey:@"wordLengthMax"];
    self.wordList = wordsRightLength;
}

- (NSMutableArray *)equivalenceGuess:(NSString *)letter currentGuess:(NSMutableArray *)guess {
    NSMutableDictionary *equivalenceDictionary = [NSMutableDictionary dictionary];
    
    // Sort all words into equivalence classes
    for (NSString *word in self.wordList) {
        
        NSNumber *magicNumber = [self checkSumWord:word andCharacter:letter];
        
        // Check if this is the first instance of equivalence class
        if ([equivalenceDictionary objectForKey:magicNumber] == nil) {
            [equivalenceDictionary setObject:[NSMutableArray arrayWithObjects:word,nil] forKey:magicNumber];
        }

        else
            [[equivalenceDictionary objectForKey:magicNumber] addObject:word];
    }
    
    // Find largest equivalence class
    int checkSize = 0;
    NSMutableArray *sizeKey = [NSMutableArray array];
    [sizeKey addObject:[NSNumber numberWithInt:0]];
    
    for (id key in equivalenceDictionary) {
        int size = [[equivalenceDictionary objectForKey:key] count];
        
        // For easy mode, don't consider nonmatching words.
        if (self.easyMode) {
            if ([key intValue] != 0) {
                if (size > checkSize) {
                    [sizeKey removeAllObjects];
                }
                if (size >= checkSize) {
                    checkSize = size;
                    [sizeKey addObject: key];
                }
            }
        }
        
        // Hard mode
        else {
            if (size > checkSize) {
                [sizeKey removeAllObjects];
            }
            if (size >= checkSize) {
                checkSize = size;
                [sizeKey addObject: key];
            }
        }
    }
    
    // Update variables. Use random numbers to get a different equivalence classeses every time
    NSNumber *randomNumber = sizeKey[arc4random() % [sizeKey count]];
    
    // Account for edge case where you're down to 2 guesses
    if (!self.easyMode && checkSize == 1 && [equivalenceDictionary objectForKey:[NSNumber numberWithInt:0]] != nil) {
        randomNumber = [NSNumber numberWithInt: 0];
    }
    
    self.wordList = [equivalenceDictionary objectForKey: randomNumber];
    self.solution = [[equivalenceDictionary objectForKey:randomNumber] objectAtIndex:0];
    BOOL changed = NO;
    
    // Get the answer in the right format. Solution is a possible word so humans don't think I'm cheating
    for (int i=0 ; i<self.solution.length; i++) {
        NSString *character = [NSString stringWithFormat: @"%c", [self.solution characterAtIndex:i]];
        if ([character isEqualToString:letter]) {
            [guess replaceObjectAtIndex:i withObject:character];
            changed = YES;
        }
    }
    
    // See if word has changed
    if (changed)
        return guess;
    else
        return nil;
}

- (NSNumber *)checkSumWord:(NSString *)aWord andCharacter:(NSString *)aLetter {
    int sum = 0;
    for (int i=0; i<aWord.length; i++) {
        // Bitshift sum
        sum <<= 1;
        
        // Detect if letter is a match
        if ([aLetter isEqualToString:[NSString stringWithFormat: @"%c", [aWord characterAtIndex:i]]]) {
            sum += 1;
        }
    }
    
    return [NSNumber numberWithInt:sum];
}

@end
