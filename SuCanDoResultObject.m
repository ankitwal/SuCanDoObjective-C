//
//  SuCanDoResultObject.m
//  SuDoKu
//
//  Created by Ankit Wal on 17/7/14.
//  Copyright (c) 2014 Ankit Wal. All rights reserved.
//

#import "SuCanDoResultObject.h"

@interface SuCanDoResultObject()

@end

@implementation SuCanDoResultObject
-(instancetype) initWithResult:(NSMutableArray *)result andLevel:(int)theLevel
{
    self=[super init];
    if(self)
    {
        self.Puzzle=[NSMutableArray array];
        for(int i=0;i<9;i++)
        {
            [self.Puzzle addObject:[NSMutableArray array]];
            
            for(int j=0;j<9;j++)
            {
                int val=[result[i][j][0] intValue];
                [self.Puzzle[i] addObject:[NSNumber numberWithInt:val]];
            }
    }
        if(theLevel<=2)
        {
            self.Level=(difficulty) theLevel;
            
            
        }
        else{
            self.Level=hard;
        }
    }
        return self;
}

-(instancetype)initWithNothing
{
    return nil;
}
// NScoding protocol conformance
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self.Title=[aDecoder decodeObjectForKey:@"Title"];
    self.Puzzle=[aDecoder decodeObjectForKey:@"Puzzle"];
    self.State=[aDecoder decodeObjectForKey:@"State"];
    int temp;
    temp=[aDecoder decodeIntForKey:@"Level"];// doing in two steps for clarity
    self.Level=(difficulty) temp;
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Puzzle forKey:@"Puzzle"];
    [aCoder encodeObject:self.Title forKey:@"Title"];
    [aCoder encodeObject:self.State forKey:@"State"];
    int temp=(int) self.Level; //doing in two steps to make sure it works.
    [aCoder encodeInt:temp forKey:@"Level"];
    
    
    
}
@end
