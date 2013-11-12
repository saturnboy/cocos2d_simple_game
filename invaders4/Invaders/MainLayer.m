//
//  MainLayer.m
//  Invaders4
//

#import "MainLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation MainLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	MainLayer *layer = [MainLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init {
	if ((self=[super init])) {
        self.isTouchEnabled = YES;
        
        //preload all sound effects
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"fire.caf"];
		//[[SimpleAudioEngine sharedEngine] preloadEffect:@"miss.caf"];
        //[[SimpleAudioEngine sharedEngine] preloadEffect:@"hit.caf"];
	}
	return self;
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //play it
    [[SimpleAudioEngine sharedEngine] playEffect:@"fire.caf"];
}

@end
