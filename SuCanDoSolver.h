//
//  SuCanDoSolver.h
//  SuCanDo
//
//  Created by Ankit Wal on 24/6/14.
//  Copyright (c) 2014 Ankit Wal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuCanDoPuzArray.h"
#import "SuCanDoResultObject.h"

@interface SuCanDoSolver : NSObject

-(SuCanDoResultObject *) solve:(NSMutableArray *) array;

@property (strong, nonatomic) NSMutableArray *result;

@end
