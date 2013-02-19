//
//  HelloWorldLayer.m
//  Invaders
//

#import "MainLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation MainLayer {
    CCSprite *alien;
    CCSprite *player;
    CCSprite *missile;
    CCSprite *moveLeft;
    CCSprite *moveRight;
    CCSprite *fireLeft;
    CCSprite *fireRight;
    CGSize size;
    CCAnimate *alienAnim;
    int alienDelta;
    int alienMin;
    int alienMax;
    int playerDelta;
    int playerMin;
    int playerMax;
    int missileDelta;
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
        
        //get size
        size = [[CCDirector sharedDirector] winSize];
        
        //load the texture
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"tex.plist"];
		CCSprite *sheet = [CCSpriteBatchNode batchNodeWithFile:@"tex.png"];
        [self addChild:sheet];
        
        //draw the missile (hidden)
        missile = [CCSprite spriteWithSpriteFrameName:@"missile.png"];
        missile.visible = NO;
        [self addChild:missile];
        
        //draw the alien
        alien = [CCSprite spriteWithSpriteFrameName:@"alien1.png"];
        alien.position = ccp(size.width/2, size.height - alien.boundingBox.size.height/2 - 10);
        [self addChild:alien];
        
        //draw the player
        player = [CCSprite spriteWithSpriteFrameName:@"player.png"];
        player.position = ccp(size.width/2, player.boundingBox.size.height/2 + 10);
        [self addChild:player];
        
        //draw the btns
        moveLeft = [CCSprite spriteWithSpriteFrameName:@"left.png"];
        moveLeft.position = ccp(20, 20);
        [self addChild:moveLeft];

        moveRight = [CCSprite spriteWithSpriteFrameName:@"right.png"];
        moveRight.position = ccp(size.width-20, 20);
        [self addChild:moveRight];
        
        fireLeft = [CCSprite spriteWithSpriteFrameName:@"fire.png"];
        fireLeft.position = ccp(20, 60);
        [self addChild:fireLeft];
        
        fireRight = [CCSprite spriteWithSpriteFrameName:@"fire.png"];
        fireRight.position = ccp(size.width-20, 60);
        [self addChild:fireRight];

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
        
        //build the animation "action"
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.05f];

        CCSequence *seq = [CCSequence actions:
                           [CCDelayTime actionWithDuration:1.0f],
                           [CCAnimate actionWithAnimation:anim],
                           nil];
        
        alienAnim = [CCRepeatForever actionWithAction:seq];
        
        [alien runAction:alienAnim];
        
        //preload all sounds
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"fire.caf"];
        
        //initialize vars
        missileDelta = 8;
        
        alienDelta = 1.2;
        alienMin = alien.boundingBox.size.width/2 + moveLeft.boundingBox.size.width;
        alienMax = size.width - alien.boundingBox.size.width/2 - moveLeft.boundingBox.size.width;
        
        playerDelta = 5;
        playerMin = player.boundingBox.size.width/2 + moveLeft.boundingBox.size.width;
        playerMax = size.width - player.boundingBox.size.width/2 - moveLeft.boundingBox.size.width;
        
        //kill counter
        //CCLabelTTF *kills = [CCLabelTTF labelWithString:@"kills" fontName:@"Marker Felt" fontSize:36];
		//[self addChild:kills];
    
        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta {
    //move alien
    if (alien.visible) {
        int alienX = alien.position.x + alienDelta;
        
        if (alienX < alienMin) {
            alienX = alienMin;
            alienDelta *= -1;
        } else if (alienX > alienMax) {
            alienX = alienMax;
            alienDelta *= -1;
        }
        
        alien.position = ccp(alienX, alien.position.y);
    }
    
    //move missile
    if (missile.visible) {
        missile.position = ccp(missile.position.x, missile.position.y + missileDelta);
        if (missile.position.y > size.height) {
            missile.visible = NO;
        } else if (CGRectContainsPoint(alien.boundingBox, missile.position)) {
            alien.visible = NO;
            missile.visible = NO;
            [alien runAction:[CCSequence actions:
                              [CCDelayTime actionWithDuration:1.0f],
                              [CCCallBlock actionWithBlock:^{
                alien.position = ccp( (size.width - alien.boundingBox.size.width) * CCRANDOM_0_1() + alien.boundingBox.size.width/2, alien.position.y);
                alien.visible = YES;
            }],
                              nil]];
        }
    }
    
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [self convertTouchToNodeSpace:touches.anyObject];
    
    if (CGRectContainsPoint(moveLeft.boundingBox, touch)) {
        //move left
        player.position = ccp(player.position.x - playerDelta, player.position.y);
        if (player.position.x < playerMin) {
            player.position = ccp(playerMin, player.position.y);
        }
    } else if (CGRectContainsPoint(moveRight.boundingBox, touch)) {
        //move right
        player.position = ccp(player.position.x + playerDelta, player.position.y);
        if (player.position.x > playerMax) {
            player.position = ccp(playerMax, player.position.y);
        }
    } else if (CGRectContainsPoint(fireLeft.boundingBox, touch) ||
               CGRectContainsPoint(fireRight.boundingBox, touch)) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"fire.caf"];
        missile.position = ccp(player.position.x, player.position.y + player.boundingBox.size.height/2 - missile.boundingBox.size.height/2 + 4);
        missile.visible = YES;
    }
}

@end
