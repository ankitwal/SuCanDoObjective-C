//
//  SuCanDoPuzArray.h
//  SuCanDo
//
//  Created by Ankit Wal on 24/6/14.
//  Copyright (c) 2014 Ankit Wal. All rights reserved.
//

//A liknked list data structure for recursive guessing

#import <Foundation/Foundation.h>

@interface SuCanDoPuzArray : NSObject
@property int level;// keeps track of level/layer of item in list. or number of guesses.

-(instancetype) initWithArray:(NSMutableArray *) arr;// used for deep copying arrays, when making guesses

-(instancetype) initWithNewArray:(NSMutableArray *) arr;// setting up the initial arrary from input

-(void) setNext:(NSMutableArray *) arr;//setting the next objext

-(NSMutableArray *) getArray;

-(void) changeAtRow:(int) i Col:(int) c Depth:(int)k With:(int) value;// altering cell value while making a guess

-(SuCanDoPuzArray *) getNext;

@end
