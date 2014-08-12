//
//  SuCanDoSolver.m
//  SuCanDo
//
//  Created by Ankit Wal on 24/6/14.
//  Copyright (c) 2014 Ankit Wal. All rights reserved.
//

#import "SuCanDoSolver.h"

@implementation SuCanDoSolver
{
    int level;// dificulty level, basically keeps track of the number of guesses made, each new SucCanDoPuzArray object(new Guess)  is assigned a new number, which represents its level in the linked list/tree with 0 being on top.
    
}
-(BOOL) checkRow:(int)r for:(int) value inArray:(NSMutableArray *) arr// Following three Fucktions check for a numebrs presense in row, col and 3x3 box
{
    BOOL isPresent=YES;
    for(int i=0;i<9;i++)
    {
        if([arr[r][i][0] intValue]==value)
        {
            return isPresent;
        }
    }
    return NO;
}
-(BOOL) checkCol:(int) c for:(int) value inArray:(NSMutableArray *) arr
{
    BOOL isPresent=YES;
    for(int i=0;i<9;i++)
    {
        if([arr[i][c][0] intValue]==value)
        {
            return isPresent;
        }
    }
    return NO;
}
-(BOOL) checkBoxRow:(int) r Col:(int) c for:(int) value inArray:(NSMutableArray *) arr
{
    int startx=r-(r%3);
    int starty=c-(c%3);
    BOOL isPresent=YES;
    int countx=0;int county=0;
    while(countx<3)
    {
        countx++;county=0;starty=c-(c%3);
        while(county<3)
        {
            county++;
            
            if([arr[startx][starty][0] intValue]==value)
            {return isPresent;}
            
            starty++;
        }
        startx++;
    }
	
    
    return NO;
}
-(BOOL) assignPos:(NSMutableArray *) arr// assigns possible value for cells, and sets cell value if only one possibility
{
    BOOL madeChange=false;
    for(int r=0;r<9;r++)
    {
        for(int c=0;c<9;c++)
        {
            if([arr[r][c][0] intValue]==0)
            {
                int  count=0; int PosValue=0;
                for(int k=1;k<10;k++)
                {
                    arr[r][c][k]=[NSNumber numberWithInt:0];
                    if(![self checkBoxRow:r Col:c for:k inArray:arr] && ![self checkRow:r for:k inArray:arr] && ![self checkCol:c for:k inArray:arr])
                    {
                        arr[r][c][k]=[NSNumber numberWithInt:k];
                        count++; PosValue=k;
                        
                    }
                    
                }
                if(count==1)
                {
                    arr[r][c][0]=[NSNumber numberWithInt:PosValue];
                    madeChange=YES;
                }
            }
        }
    
    }
    return madeChange;
}
-(void) resolve:(NSMutableArray *) arr// Resolves the puzzle with only possiblitites, no guessing
{
    while([self assignPos:arr]);
    
}
-(BOOL) checkForSolved:(NSMutableArray *) arr//Checks if Puzzle is solved, and stores result
{
    for( int r=0;r<9;r++)
    {
        for(int c=0;c<9;c++)
        {
            if([arr[r][c][0] intValue]==0)
            {
                return NO;
            }
        }
    }
    self.result=arr;
    
    return YES;
    
}
-(BOOL) arrayIsGood:(NSMutableArray *) arr // checks if array is still resolvable
{
    for(int r=0;r<9;r++)
    {
        for(int c=0;c<9;c++)
        {
            if([arr[r][c][0] intValue]==0)
                {
                    int count=0;
                    for(int k=1;k<10;k++)
                    {
                        if([arr[r][c][k] intValue]==k){
                            count++;
                        }
                    }
                    if(count==0){return NO;}
                }
        }
    }
    
    return YES;
}
-(BOOL) guess:(SuCanDoPuzArray *) obj
{
    int count;//count is used to find cells with lowest number of possibilities
    
    
    [self resolve:[obj getArray]];
    
    if([self arrayIsGood:[obj getArray]])// checks if the puzzel is still resolvable or needs to be backtracked
    {
        
        if(![self checkForSolved:[obj getArray]])
        {
			
            
			for(int i=2;i<=9;i++)
			{//cycles from cell with 2 to all 9 possibilities to ensure, lower possibility cells are guessed first
				for(int j=0;j<9;j++)
				{
					for(int k=0;k<9;k++)
					{
						if([obj getArray][j][k][0]==0)
						{	count=0;
							for(int z=1;z<=9;z++)
							{
								if([[obj getArray][j][k][z] intValue]!=0)
								{
									count++;if(count>i){break;}
									
								}
							}
							if(count<=i)// check if cell has current limit of possibilities
                            {
								
								for(int a=1;a<=9;a++)
								{
                                    
                                    if([[obj getArray][j][k][a] intValue]==a)
                                    {
                                        
                                        [obj changeAtRow:j Col:k Depth:0 With:a];// take a guess.
                                        
                                        [obj setNext:[obj getArray]];//make new list obj, with array +guessed value
                                        
                                        
                                        
                                        if([self guess:[obj getNext]]) // check recursively
                                        {
                                            level=[obj getNext].level;//number of guesses up to this point
                                            return true;
                                        }
                                        
                                        [obj changeAtRow:j Col:k Depth:0 With:0];
                                        //guess was wrong, reverting changes
                                        //loop will guess again
                                        
                                    }
                                    
                                }return false;// if it guessed all and none worked(for one cell), previous guess was wrong, hence return.
                            }
						}
					}	
				}
			}
			
		}return true;//True if solved.
    }
    else{
        //if puzzel is unresolvable no point guessing, last guess must have been incorrect.
        
        return false;
    }
}




 
 -(BOOL) checkForDuplicates:(NSMutableArray *) arr //Checks input arr for duplicate in row, col and box, to optimize detection of unresolvable puzzle
{
    for(int i=0;i<9;i++)
    {
        for(int j=0;j<9;j++)
        {
            if([arr[i][j] intValue]!=0)
            {
                int temp=[arr[i][j] intValue];
                for(int row=(i+1);row<9;row++)
                {
                    if([arr[row][j] intValue]==temp)
                    {
                        return NO;
                    }
                
                }
                for(int col=(j+1);j<9;j++)
                {
                    if([arr[i][col] intValue]==temp)
                    {
                        return NO;
                    }
                }
                int startx=i-(i%3);
                int starty=j-(j%3);
                
                int countx=0;int county=0;
                while(countx<3)
                {
                    countx++;county=0;starty=j-(j%3);
                    while(county<3)
                    {
                        county++;
                        if([arr[startx][starty] intValue]==temp && startx!=i && starty!=j)
                        { return NO;}
                        starty++;
                    }
                    startx++;
                }

            }
        }
    }
 
    return YES;
}


-(SuCanDoResultObject *) solve:(NSMutableArray *)array
{
    if([self checkForDuplicates:array])
    {
    SuCanDoPuzArray *ob=[[SuCanDoPuzArray alloc]initWithNewArray:array];
    
    if([self guess:ob])
    {
        SuCanDoResultObject * result=[[SuCanDoResultObject alloc] initWithResult:self.result andLevel:level];
        
        result.Title=[[NSDate date] description];// sets the title to the current date and time.
        
        return result;
        
    }
    else {return nil;}
    }
    else {
        return nil;
    }
}
@end
