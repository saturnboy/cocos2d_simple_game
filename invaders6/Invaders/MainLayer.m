//
//  MainLayer.m
//  Invaders6
//

#import "MainLayer.h"
#import "AppDelegate.h"

@implementation MainLayer {
    CCSprite *alien;
    int W;
    int H;
}

+(CCScene *) scene {
    CCScene *scene = [CCScene node];
    MainLayer *layer = [MainLayer node];
    [scene addChild: layer];
    return scene;
}

-(id) init {
    if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        W = size.width;
        H = size.height;
        
        alien = [CCSprite spriteWithFile:@"alien.png"];
        alien.position = ccp(100,100);
        [self addChild:alien];
    }
    return self;
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([alien numberOfRunningActions] == 0) {
        CCSequence *seq = [CCSequence actions:
                           [CCMoveTo actionWithDuration:1 position:ccp(100,H-100)],
                           [CCSpawn actions:
                            [CCMoveTo actionWithDuration:1 position:ccp(W-100,H-100)],
                            [CCRotateBy actionWithDuration:1 angle:360],
                            nil],
                           [CCDelayTime actionWithDuration:1],
                           [CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:1 position:ccp(W-100,100)] rate:3],
                           [CCMoveTo actionWithDuration:1 position:ccp(100,100)],
                           nil];
        [alien runAction:seq];
    }
    
    //[[CCActionManager sharedManager] pauseAllActionsForTarget:alien];
    //[[CCActionManager sharedManager] resumeAllActionsForTarget:alien];
}

@end
