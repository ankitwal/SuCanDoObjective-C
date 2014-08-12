//
//  SuCanDoResultObject.h
//  SuDoKu
//
//  Created by Ankit Wal on 17/7/14.
//  Copyright (c) 2014 Ankit Wal. All rights reserved.
//
// The Class of the object returned.
#import <Foundation/Foundation.h>

@interface SuCanDoResultObject : NSObject <NSCoding> // Complies to NSCoding protocol, for archiving results

@property (nonatomic, copy) NSString * Title; // Title of Puzzle, set by default as the current date

@property (strong, nonatomic) NSMutableArray *Puzzle;// The Solved Puzzle

@property (strong, nonatomic) NSMutableArray *State; // A current state array, to store user input, if needed

typedef enum {easy=0,medium,hard} difficulty;// difficulty level of the puzzle, accertained by numbre of guesses needed
@property difficulty Level;


-(instancetype) initWithResult:(NSMutableArray *) result andLevel:(int) theLevel;

-(instancetype) initWithNothing;

//protocol compliance
-(id) initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;

@end
