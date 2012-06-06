//
//  UIView+Animations.h
//
//  Created by  on 12/4/21.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)

- (void)popInAnimation;
- (void)popInAnimationWithDelegate:(id)animationDelegate;
- (void)popInAnimationWithDelegate:(id)animationDelegate key:(NSString *)key;
- (void)fadeInAnimation;
- (void)fadeInAnimationWithDelegate:(id)animationDelegate;
- (void)fadeInAnimationWithDelegate:(id)animationDelegate key:(NSString *)key;
- (void)fadeOutAnimation;
- (void)fadeOutAnimationWithDelegate:(id)animationDelegate;
- (void)fadeOutAnimationWithDelegate:(id)animationDelegate key:(NSString *)key;
- (void)moveAnimationTo:(CGPoint)to;
- (void)moveAnimationTo:(CGPoint)to delegate:(id)animationDelegate;
- (void)moveAnimationTo:(CGPoint)to delegate:(id)animationDelegate key:(NSString *)key;
- (void)rotateAnimationToAngle:(CGFloat)angle;
- (void)rotateAnimationToAngle:(CGFloat)angle delegate:(id)animationDelegate;
- (void)rotateAnimationToAngle:(CGFloat)angle delegate:(id)animationDelegate key:(NSString *)key;

@end
