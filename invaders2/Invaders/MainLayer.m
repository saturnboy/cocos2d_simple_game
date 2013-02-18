//
//  MainLayer.m
//  Invaders2
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
	if ((self=[super init])) {
        self.isTouchEnabled = YES;
        
        alien = [CCSprite spriteWithFile:@"alien.png"];
        [self addChild:alien];
	}
	return self;
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [self convertTouchToNodeSpace:touches.anyObject];
    alien.position = touch;
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // start touching
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // drag
}

@end
