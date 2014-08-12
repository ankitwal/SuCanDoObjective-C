//
//  SuCanDoPuzArray.m
//  SuCanDo
//
//  Created by Ankit Wal on 24/6/14.
//  Copyright (c) 2014 Ankit Wal. All rights reserved.
//

#import "SuCanDoPuzArray.h"

@implementation SuCanDoPuzArray
{
    SuCanDoPuzArray *next;
    NSMutableArray *array;
}
-(instancetype) initWithArray:(NSMutableArray *)arr//Deep copying array
{
    self=[super init];
    if(self)
    {
        array=[NSMutableArray array];
        for(int i=0;i<9;i++)
        {
            [array addObject:[NSMutableArray array]];//2D added array at each element of first array
            
            for(int j=0;j<9;j++)
            {
                [array[i] addObject:[NSMutableArray array]];//3D added another array, to
                 for(int k=0;k<10;k++)
                 {
                     [array[i][j] addObject:[NSNumber numberWithInt:[arr[i][j][k] intValue]]];//arra[i][j] gives the array, and we add objs to that.
                 }
            }
        }
    }
    self.level=0;
    return self;
}
-(instancetype) initWithNewArray:(NSMutableArray *)arr//Setting up a new array
{
    NSMutableArray *temp=[NSMutableArray array];
    for(int r=0;r<9;r++)
    {
        [temp addObject:[NSMutableArray array]];
        for(int c=0;c<9;c++)
        {
            [temp[r] addObject:[NSMutableArray array]];
            [temp[r][c] addObject:[NSNumber numberWithInt:[arr[r][c] intValue]]];
            for(int k=1;k<10;k++)
            {
                [temp[r][c] addObject:[NSNumber numberWithInt:0]];
            }
        }
    }
    return [self initWithArray:temp];
}
-(instancetype) init
{
    return [self initWithArray:nil];
}
-(void) setNext:(NSMutableArray *)arr
{
    next=[[SuCanDoPuzArray alloc] initWithArray:arr];
    next.level=(self.level+1);
}

-(void) changeAtRow:(int)i Col:(int)c Depth:(int)k With:(int)value
{
    array[i][c][k]=[NSNumber numberWithInt:value];
}
-(NSMutableArray *) getArray
{
    return array;
}
-(SuCanDoPuzArray *) getNext
{
    return next;
}
@end
