//
//  MainLayer.m
//  Invaders5
//

#import "MainLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

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
	if ((self=[super init])) {
        self.isTouchEnabled = YES;
        
        alien = [CCSprite spriteWithFile:@"alien.png"];
        CGSize size = [[CCDirector sharedDirector] winSize];
		alien.position = ccp(size.width/2, size.height/2);
        [self addChild:alien];
        
        //preload all sounds
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"fire.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"miss.caf"];
	}
	return self;
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [self convertTouchToNodeSpace:touches.anyObject];

    if (CGRectContainsPoint(alien.boundingBox, touch)) {
        //hit
        NSLog(@"HIT: (%.1f,%.1f)", touch.x, touch.y);
        [[SimpleAudioEngine sharedEngine] playEffect:@"fire.caf"];
    } else {
        //miss
        NSLog(@"MISS: (%.1f,%.1f)", touch.x, touch.y);
        [[SimpleAudioEngine sharedEngine] playEffect:@"miss.caf"];
    }
    
    //BONUS: move it to a new random pos
    //CCRANDOM_0_1() - random 0.0 to 1.0
    //CCRANDOM_MINUS1_1() - random -1.0 to 1.0
}

@end
