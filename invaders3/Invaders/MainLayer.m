//
//  MainLayer.m
//  Invaders3
//

#import "MainLayer.h"
#import "AppDelegate.h"

@implementation MainLayer {
    CCSprite *alien;
    CCAnimate *action;
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
        
        //load the texture
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"tex.plist"];
		CCSprite *sheet = [CCSpriteBatchNode batchNodeWithFile:@"tex.png"];
        [self addChild:sheet];
        
        //draw the alien
        alien = [CCSprite spriteWithSpriteFrameName:@"alien1.png"];
        CGSize size = [[CCDirector sharedDirector] winSize];
        alien.position = ccp(size.width/2, size.height/2);
        [self addChild:alien];
        
        //build the animation
        NSArray *animFrames = [NSArray arrayWithObjects:
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien1.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien2.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien3.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien4.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien5.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien6.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien7.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien8.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien9.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien10.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien9.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien8.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien7.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien6.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien5.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien4.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien3.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien2.png"],
            [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"alien1.png"],
            nil];
		
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
        
        //build the animation "action"
        action = [CCAnimate actionWithAnimation:anim];
        
        //action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
	}
	return self;
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([alien numberOfRunningActions] == 0) {
        [alien runAction:action];
    }
}

@end
