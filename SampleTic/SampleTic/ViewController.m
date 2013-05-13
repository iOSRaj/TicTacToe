//
//  ViewController.m
//  SampleTic
//
//  Created by Raj on 5/11/13.
//  Copyright (c) 2013 Raj. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController
@synthesize v0, v1, v2, v3, v4, v5, v6, v7, v8,tileArray,choiceArray;
@synthesize currentTile,previousTile,whoseTurn,tileChosen,turnCount,currRound,aScore,eScore,maxRounds,isWinner,model;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
       
    v0.delegate = self;
    v1.delegate = self;
    v2.delegate = self;
    v3.delegate = self;
    v4.delegate = self;
    v5.delegate = self;
    v6.delegate = self;
    v7.delegate = self;
    v8.delegate=self;
    
    
    [v0 setTag:-1];
    [v1 setTag:-1];
    [v2 setTag:-1];
    [v3 setTag:-1];
    [v4 setTag:-1];
    [v5 setTag:-1];
    [v6 setTag:-1];
    [v7 setTag:-1];
    [v8 setTag:-1];
    
    [v0 setId:0];
    [v1 setId:1];
    [v2 setId:2];
    [v3 setId:3];
    [v4 setId:4];
    [v5 setId:5];
    [v6 setId:6];
    [v7 setId:7];
    [v8 setId:8];
    
    
    tileArray = [[NSArray alloc] initWithObjects:v0,v1,v2,v3,v4,v5,v6,v7,v8, nil];
    
    model=[[TileModel alloc]init];
    
    model.count=9;
    
    
for(TileView *t1 in tileArray)
{
    
    t1.tileLocked = NO;
    t1.whoseTurn = 0;
   
    
    [t1 addTileImages];
    
    //CREATE MAIN BUTTON
    CGRect bFrame = CGRectMake(0.0f, 0.0f,t1.frame.size.width, t1.frame.size.height);
    UIButton *mainButton = [[UIButton alloc] initWithFrame:bFrame];
    
    
    [mainButton addTarget:t1 action:@selector(updateView) forControlEvents:UIControlEventTouchUpInside];
    
    [t1 addSubview:mainButton];

    
}
    
    
    choiceArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt: -1],[NSNumber numberWithInt: -1],[NSNumber numberWithInt: -1],[NSNumber numberWithInt: -1],[NSNumber numberWithInt: -1],[NSNumber numberWithInt: -1],[NSNumber numberWithInt: -1],[NSNumber numberWithInt: -1],[NSNumber numberWithInt: -1], nil];
    
    previousTile = -1;
    whoseTurn = 0;
    turnCount = 0;
    
    model.turnCount =0;
    currRound = 1;
    aScore = 0;
    eScore = 0;
    maxRounds = 3;
    tileChosen = NO;
    isWinner = NO;

    self.resetButton.hidden=YES;
    
    
    
    
    
    
    
}
-(void)checkScore
{
    NSLog(@"SCORE CHECK: turnCount: %i, whoseTurn: %i, currentTile: %i", turnCount, whoseTurn, currentTile);
    
     NSLog(@"SCORE Model CHECK: turnCount: %i, whoseTurn: %i, currentTile: %i",model.turnCount, whoseTurn, currentTile);
    int i;
   
    
    
    int w1 = -1;
    int w2 = -1;
    int w3 = -1;
    
    int topRowFirstInt = [[choiceArray objectAtIndex:0] integerValue];
    int topRowMiddleInt = [[choiceArray objectAtIndex:1] integerValue];
    int topRowLastInt = [[choiceArray objectAtIndex:2] integerValue];
    int middleRowFirstInt = [[choiceArray objectAtIndex:3] integerValue];
    int bottomRowFirstInt = [[choiceArray objectAtIndex:6] integerValue];
    
    //TOP ROW HORIZONTAL CHECK
    
    if ([[choiceArray objectAtIndex:0] isEqual: [choiceArray objectAtIndex:1]]
        && [[choiceArray objectAtIndex:0] isEqual: [choiceArray objectAtIndex:2]])
    {
        if (topRowFirstInt != -1)
        {
            isWinner = YES;
            w1 = 0;
            w2 = 1;
            w3 = 2;
        }
    }
    
    //MIDDLE ROW HORIZONTAL CHECK
    
    if ([[choiceArray objectAtIndex:3] isEqual: [choiceArray objectAtIndex:4]]
        && [[choiceArray objectAtIndex:3] isEqual: [choiceArray objectAtIndex:5]])
    {
        if (middleRowFirstInt != -1)
        {
            isWinner = YES;
            w1 = 3;
            w2 = 4;
            w3 = 5;
        }
    }
    
    //BOTTOM ROW HORIZONTAL CHECK
    
    if([[choiceArray objectAtIndex:6] isEqual: [choiceArray objectAtIndex:7]]
       && [[choiceArray objectAtIndex:6] isEqual: [choiceArray objectAtIndex:8]])
    {
        if (bottomRowFirstInt != -1)
        {
            isWinner = YES;
            w1 = 6;
            w2 = 7;
            w3 = 8;
        }
    }
    
    //FIRST COLUMN VERTICAL CHECK
    
    if ([[choiceArray objectAtIndex:0] isEqual: [choiceArray objectAtIndex:3]]
        && [[choiceArray objectAtIndex:0] isEqual: [choiceArray objectAtIndex:6]])
    {
        if (topRowFirstInt != -1)
        {
            isWinner = YES;
            w1 = 0;
            w2 = 3;
            w3 = 6;
        }
    }
    
    //SECOND COLUMN VERTICAL CHECK
    
    if ([[choiceArray objectAtIndex:1] isEqual: [choiceArray objectAtIndex:4]]
        && [[choiceArray objectAtIndex:1] isEqual: [choiceArray objectAtIndex:7]])
    {
        if (topRowMiddleInt != -1)
        {
            isWinner = YES;
            w1 = 1;
            w2 = 4;
            w3 = 7;
        }
    }
    
    //THIRD COLUMN VERTICAL CHECK
    
    if ([[choiceArray objectAtIndex:2] isEqual: [choiceArray objectAtIndex:5]]
        && [[choiceArray objectAtIndex:2] isEqual: [choiceArray objectAtIndex:8]])
    {
        if (topRowLastInt != -1)
        {
            isWinner = YES;
            w1 = 2;
            w2 = 5;
            w3 = 8;
        }
    }
    
    //TOP CORNER DIAGONAL CHECK
    
    if ([[choiceArray objectAtIndex:0] isEqual: [choiceArray objectAtIndex:4]]
        && [[choiceArray objectAtIndex:0] isEqual: [choiceArray objectAtIndex:8]])
    {
        if (topRowFirstInt != -1)
        {
            isWinner = YES;
            w1 = 0;
            w2 = 4;
            w3 = 8;
        }
    }
    
    //BOTTOM CORNER DIAGONAL CHECK
    
    if ([[choiceArray objectAtIndex:6] isEqual: [choiceArray objectAtIndex:4]]
        && [[choiceArray objectAtIndex:6] isEqual: [choiceArray objectAtIndex:2]])
    {
        if (bottomRowFirstInt != -1)
        {
            isWinner = YES;
            w1 = 6;
            w2 = 4;
            w3 = 2;
        }
    }
    
    if (isWinner)
    {
        self.roundLabel.alpha = 0;
        [UIView animateWithDuration:0.75
                         animations:^{ self.roundLabel.alpha = 1.0;}];
        
        self.roundLabel.text = @"WIN";
        if (whoseTurn ==0)
        {
            aScore ++;
        }
        else
        {
            eScore ++;
        }
        
        NSLog(@"WINNER! Current score: Team Me: %i Team Other: %i", aScore, eScore);
        [self updateScore];
        if(currRound == maxRounds)
        {
            [_resetButton setTitle:@"START OVER" forState:UIControlStateNormal];
        }
        
        else
        {
            [_resetButton setTitle:@"NEXT ROUND" forState:UIControlStateNormal];
        }
        _resetButton.alpha = 0;
        _resetButton.hidden = NO;
        [UIView animateWithDuration:0.35
                         animations:^{_resetButton.alpha = 1.0;}];
        
       
        //LOCK ALL TILES
        for (i = 0; i < model.count; i++)
        {
            [[tileArray objectAtIndex:i] setTileLocked:YES];
            
            if(i != w1 && i != w2 && i != w3)
            {
                //CHANGE COLOR FOR WINNERS
                [[tileArray objectAtIndex:i] setBackgroundColor:UIColorFromRGB(0xcccccc)];//gray for remainng
            }
        }
    }
    else
    {
        //ELSE NOBODY WON...
        if(model.turnCount == 8)
        {
            _roundLabel.alpha = 0;
            [UIView animateWithDuration:0.75
                             animations:^{_roundLabel.alpha = 1.0;}];
            _roundLabel.text =  @"TIED";
            _roundLabel.textColor =UIColorFromRGB(0xcccccc);
            
            ;
            
            if(currRound == maxRounds)
            {
                [_resetButton setTitle:@"START OVER" forState:UIControlStateNormal];
            }
            
            else
            {
                [_resetButton setTitle:@"NEXT ROUND" forState:UIControlStateNormal];
            }
            
            _resetButton.alpha = 0;
            _resetButton.hidden = NO;
            [UIView animateWithDuration:0.35
                             animations:^{_resetButton.alpha = 1.0;}];
            
            for (i = 0; i < model.count; i++)
            {
                [[tileArray objectAtIndex:i] setTileLocked:YES];
                [[tileArray objectAtIndex:i] setBackgroundColor:UIColorFromRGB(0xcccccc)];//all gray
            }
        }
        else
        {
            [self continueCurrentRound];
            
            
            
        }
    }
    
    
}

-(void)continueCurrentRound
{
    //ADVANCE TURN COUNT
    NSLog(@"CONFIRMED! turnCount: %i, whoseTurn: %i", currRound, whoseTurn);
    
    turnCount ++;
    model.turnCount ++;
    
    if (whoseTurn == 0)
    {
        whoseTurn = 1;
    }
    else
    {
        whoseTurn = 0;
    }
    
    TileView *tempView = [tileArray objectAtIndex:currentTile];
    
    if (tempView.tag!= -1)
    {
       
        
        [[tileArray objectAtIndex:currentTile] setTileLocked:YES]; //Once locked not update 
    }
    
    int i;
    int count;
    
    count = [tileArray count];
   
    
    
    //For images
    for (i = 0; i < count; i++)
    {
        [[tileArray objectAtIndex:i] setWhoseTurn:whoseTurn];
        [[tileArray objectAtIndex:i] resetView];
    }
    
    [UIView animateWithDuration:0.35
                     animations:^{_roundLabel.alpha = 0.0;}
                     completion:^(BOOL finished){ [self updateAfterRound]; }];
}

-(void)updateAfterRound
{
    _roundLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:40.0];
    _roundLabel.text = @"GO";
    if (whoseTurn == 0)
    {
        _roundLabel.textColor = UIColorFromRGB(0xffc604);
    }
    else
    {
        _roundLabel.textColor = UIColorFromRGB(0x00d0ff);
    }
    tileChosen = NO;
    [UIView animateWithDuration:0.35
                     animations:^{_roundLabel.alpha = 1.0;}];
}



- (void)didSelectTile:(int)tile
{
    
    tileChosen = YES;
    currentTile = tile;
 
    
    
 
    if (tileChosen)
    {
        if(whoseTurn ==0)
        {
           [[tileArray objectAtIndex:currentTile] setBackgroundColor:UIColorFromRGB(0xffc604)];
            
          
        }
        else
        {
            [[tileArray objectAtIndex:currentTile] setBackgroundColor:UIColorFromRGB(0x00d0ff)];

           
        }
        
        [choiceArray replaceObjectAtIndex:currentTile withObject:[NSNumber numberWithInt:whoseTurn]];
        [self checkScore];
    }

    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reset:(id)sender {
    
    self.resetButton.hidden=YES;
    
    if(currRound < maxRounds)
    {
        currRound ++;
    }
    
    else
    {
        currRound = 1;
        aScore = 0;
        eScore = 0;
        [self updateScore];
    }
    
    _roundLabel.alpha = 0.0;
    [UIView animateWithDuration:0.75
                     animations:^{_roundLabel.alpha = 1.0;}];
    
    if (currRound == maxRounds)
    {
        _roundLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:50.0];
        [_roundLabel setText:[NSString stringWithFormat:@"FINAL ROUND"]];
    }
    else
    {
        _roundLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:40.0];
        [_roundLabel setText:[NSString stringWithFormat:@"ROUND %i", currRound]];
    }
    
    _roundLabel.textColor = UIColorFromRGB(0xD20C2A);
    turnCount = 0;
    model.turnCount =0;
    whoseTurn = 0;
    tileChosen = NO;
    isWinner = NO;
    
    int i;
    int count;
    count = 9;
    
    for (i = 0; i < count; i++)
    {
        [[tileArray objectAtIndex:i] setTileLocked:NO];
        [[tileArray objectAtIndex:i] setWhoseTurn:whoseTurn];
        //[[tileArray objectAtIndex:i] setBackgroundColor:UIColorFromRGB(0xD20C2A)];
        //[[tileArray objectAtIndex:i] resetView];
        
        [choiceArray replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:-1]];
        
//        [UIView animateWithDuration:0.5f
//                              delay:0.0
//                            options: UIViewAnimationOptionCurveEaseIn
//                         animations:^{
//                             [[tileArray objectAtIndex:i] setAlpha:0.0f];
//                             [[tileArray objectAtIndex:i] setCenter:CGPointMake(160, 240)];
//                         }
//                         completion:^(BOOL finished)
//         {
              [[tileArray objectAtIndex:i] setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
             [[tileArray objectAtIndex:i] setAlpha:1.0f];
             if (i == 8)
             {
                 [self setupGame];
             }
       //  }
      //   ];
    }

    
}
-(void)setupGame
{
    int i;
    int count;
    count = 9;
    
    for (i = 0; i < count; i++)
    {
        [[tileArray objectAtIndex:i] resetView];
        [UIView animateWithDuration:0.75f
         
                         animations:^{
                             [[tileArray objectAtIndex:i] setAlpha:1.0f];
                         }];
    }
    
}

-(void)updateScore
{
    [self.meLabel setText:[NSString stringWithFormat:@"%i", aScore]];
    [self.otherLabel setText:[NSString stringWithFormat:@"%i", eScore]];
}
@end
