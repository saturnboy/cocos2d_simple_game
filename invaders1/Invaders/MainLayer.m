//
//  MainLayer.m
//  Invaders1
//

#import "MainLayer.h"
#import "AppDelegate.h"

@implementation MainLayer {
    CCSprite *alien;
}

+(CCScene *) scene {
    CCScene *scene = [CCScene node];
    MainLayer *layer = [MainLayer node];
    [scene addChild: layer];
    return scene;
}

-(id) init {
    if( (self=[super init]) ) {
        alien = [CCSprite spriteWithFile:@"alien.png"];

        //CGSize size = [[CCDirector sharedDirector] winSize];
        //alien.position = ccp(size.width/2, size.height/2);

        [self addChild:alien];

        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta {
    alien.position = ccpAdd(ccp(1,1), alien.position);

    //alien.rotation (in degrees)
    //alien.scale (in percent)
}

@end
