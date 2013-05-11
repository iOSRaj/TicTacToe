//
//  ViewController.h
//  SampleTic
//
//  Created by Raj on 5/11/13.
//  Copyright (c) 2013 Raj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileView.h"
#import "TileModel.h"

@interface ViewController : UIViewController <TileViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;

@property (weak, nonatomic) IBOutlet UILabel *meLabel;

@property NSArray *tileArray;

@property NSMutableArray *choiceArray;

@property (weak, nonatomic) IBOutlet TileView *v0;
@property (weak, nonatomic) IBOutlet TileView *v2;

@property (weak, nonatomic) IBOutlet TileView *v1;

@property (weak, nonatomic) IBOutlet TileView *v3;
@property (weak, nonatomic) IBOutlet TileView *v4;
@property (weak, nonatomic) IBOutlet TileView *v5;

@property (weak, nonatomic) IBOutlet TileView *v6;

@property (weak, nonatomic) IBOutlet TileView *v7;

@property (weak, nonatomic) IBOutlet TileView *v8;
@property(nonatomic,retain)TileModel *model;




- (IBAction)reset:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;


@property int currentTile;
@property int previousTile;
@property int whoseTurn;
@property int turnCount;
@property int currRound;
@property int maxRounds;
@property int aScore;
@property int eScore;
@property BOOL tileChosen;
@property BOOL isWinner;
@end
