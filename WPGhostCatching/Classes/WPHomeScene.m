//
//  HelloWorldScene.m
//  WPGhostCatching
//
//  Created by psy on 14-3-18.
//  Copyright psy 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

#import "WPHomeScene.h"
#import "IntroScene.h"

#import "WPQuickComponents.h"
#import "WPHostScene.h"
#import "WPPlayerScene.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation WPHomeScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------


// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    
    WPButton *hostBtn = makeButton(@"Host", WPFontNormal, ccp(0.5f, 0.3f), ^{
        sceneForward([[WPHostScene alloc] init]);
    });
    [self addChild:hostBtn];
    
    WPButton *playerBtn = makeButton(@"Player", WPFontNormal, ccp(0.5f, 0.6f), ^{
        sceneForward([[WPPlayerScene alloc] init]);
    });
    [self addChild:playerBtn];

	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
//    // Log touch location
//    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
//    
//    // Move our sprite to touch location
//    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
//    [_sprite runAction:actionMove];
}

// -----------------------------------------------------------------------

@end
