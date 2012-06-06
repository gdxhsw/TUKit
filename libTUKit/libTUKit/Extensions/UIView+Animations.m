//
//  UIView+Animations.m
//
//  Created by  on 12/4/21.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "UIView+Animations.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration          0.3f
#define DEGREES_TO_RADIANS(angle)   (angle / 180.0f * M_PI)

@implementation UIView (Animations)

- (void)popInAnimation
{
    [self popInAnimationWithDelegate:nil key:nil];
}

- (void)popInAnimationWithDelegate:(id)animationDelegate
{
    [self popInAnimationWithDelegate:animationDelegate key:nil];
}

- (void)popInAnimationWithDelegate:(id)animationDelegate key:(NSString *)key
{
    CALayer *viewLayer = self.layer;
    CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (key != nil) {
        [popInAnimation setValue:key forKey:@"tag"];
    }
    popInAnimation.duration = kAnimationDuration;
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.7f],
                             [NSNumber numberWithFloat:1.2f],
                             [NSNumber numberWithFloat:0.9f],
                             [NSNumber numberWithFloat:1.0f],
                             nil];
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0f],
                               [NSNumber numberWithFloat:0.6f],
                               [NSNumber numberWithFloat:0.8f],
                               [NSNumber numberWithFloat:1.0f], 
                               nil];    
    popInAnimation.delegate = animationDelegate;
    
    [viewLayer addAnimation:popInAnimation forKey:@"transform.scale"];  
}

- (void)fadeInAnimation
{
    [self fadeInAnimationWithDelegate:nil key:nil];
}

- (void)fadeInAnimationWithDelegate:(id)animationDelegate
{
    [self fadeInAnimationWithDelegate:animationDelegate key:nil];
}

- (void)fadeInAnimationWithDelegate:(id)animationDelegate key:(NSString *)key
{
    CALayer *viewLayer = self.layer;
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    if (key != nil) {
        [fadeInAnimation setValue:key forKey:@"tag"];
    }
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    fadeInAnimation.duration = kAnimationDuration;
    fadeInAnimation.delegate = animationDelegate;
    [viewLayer addAnimation:fadeInAnimation forKey:@"opacity"];
}

- (void)fadeOutAnimation
{
    [self fadeOutAnimationWithDelegate:nil key:nil];
}

- (void)fadeOutAnimationWithDelegate:(id)animationDelegate
{
    [self fadeOutAnimationWithDelegate:animationDelegate key:nil];
}

- (void)fadeOutAnimationWithDelegate:(id)animationDelegate key:(NSString *)key {
    CALayer *viewLayer = self.layer;
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    if (key != nil) {
        [fadeOutAnimation setValue:key forKey:@"tag"];
    }
    fadeOutAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    fadeOutAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    fadeOutAnimation.duration = kAnimationDuration;
    fadeOutAnimation.delegate = animationDelegate;
    [viewLayer addAnimation:fadeOutAnimation forKey:@"opacity"];
}

- (void)moveAnimationTo:(CGPoint)to {
    [self moveAnimationTo:to delegate:nil key:nil];
}

- (void)moveAnimationTo:(CGPoint)to delegate:(id)animationDelegate {
    [self moveAnimationTo:to delegate:animationDelegate key:nil];
}

- (void)moveAnimationTo:(CGPoint)to delegate:(id)animationDelegate key:(NSString *)key {
    CALayer *viewLayer = self.layer;
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    if (key != nil) {
        [moveAnimation setValue:key forKey:@"tag"];
    }
    moveAnimation.fromValue = [viewLayer valueForKey:@"position"];
    moveAnimation.toValue = [NSValue valueWithCGPoint:to];
    moveAnimation.duration = kAnimationDuration;
    moveAnimation.delegate = animationDelegate;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    viewLayer.position = to;
    [viewLayer addAnimation:moveAnimation forKey:@"position"];
}

- (void)rotateAnimationToAngle:(CGFloat)angle {
    [self rotateAnimationToAngle:angle delegate:nil key:nil];
}

- (void)rotateAnimationToAngle:(CGFloat)angle delegate:(id)animationDelegate {
    [self rotateAnimationToAngle:angle delegate:animationDelegate key:nil];
}

- (void)rotateAnimationToAngle:(CGFloat)angle delegate:(id)animationDelegate key:(NSString *)key {
    CALayer *viewLayer = self.layer;
    [viewLayer removeAllAnimations];
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    if (key != nil) {
        [rotateAnimation setValue:key forKey:@"tag"];
    }
    rotateAnimation.fromValue = [viewLayer valueForKey:@"rotation"];
    CGFloat radians = DEGREES_TO_RADIANS(angle);
    rotateAnimation.toValue = [NSNumber numberWithFloat:radians];
    rotateAnimation.duration = kAnimationDuration;
    rotateAnimation.delegate = animationDelegate;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    [viewLayer setValue:[NSNumber numberWithFloat:radians] forKey:@"rotation"];
    [viewLayer addAnimation:rotateAnimation forKey:@"transform.rotation"];
}

@end
