//
//  TileView.m
//
//  Created by Raj on 5/11/13.
//  Copyright (c) 2013 Rajkumar. All rights reserved.
//

#import "TileView.h"


@implementation TileView

@synthesize tag;
@synthesize id;
@synthesize tileLocked;
@synthesize whoseTurn;
@synthesize delegate;
@synthesize eImageView;
@synthesize aImageView;

-(void)updateView
{
    NSLog(@"enna sir");
    
    //Only update if this tile is not picked
    if(tileLocked == NO)
    {
        tag = 1;

        [self setGraphics];
        int idToPassBack = id;
        
        NSLog(@"enna sir id %d",(int)id);
        [self.delegate didSelectTile:idToPassBack];
    }
}


-(void)resetView
{
    if(tileLocked == NO)
    {
        tag = -1;
        aImageView.hidden = YES;
        eImageView.hidden = YES;
    }
}

-(void)addTileImages
{
    //ADD X IMAGE
    UIImage * eImage;
    eImage = [UIImage imageNamed: @"x.png"];
    eImageView = [[UIImageView alloc] initWithImage: eImage];
    [self addSubview:eImageView];
    
    //ADD A IMAGE
    UIImage * aImage;
    aImage = [UIImage imageNamed: @"o.png"];
    aImageView = [[UIImageView alloc] initWithImage: aImage];
    [self addSubview:aImageView];
    
    aImageView.hidden = YES;
    eImageView.hidden = YES;
    
}




- (void)setGraphics
{
      
    if (tag == 1)
    {
        aImageView.hidden = YES;
        eImageView.hidden = YES;
        
        if([self whoseTurn] == 0)
        {
            //DRAW "A"
            NSLog(@"Draw O");
            aImageView.hidden = NO;
        }
        
        else if([self whoseTurn] == 1)
        {
            NSLog(@"Draw X");
            eImageView.hidden = NO;
        }
    }
}

@end
