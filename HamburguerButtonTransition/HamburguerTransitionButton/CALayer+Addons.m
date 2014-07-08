//
//  CALayer+Addons.m
//  HamburguerButtonTransition
//
//  Created by Ruben on 08/07/14.
//  Copyright (c) 2014 Caldofran. All rights reserved.
//

#import "CALayer+Addons.h"

@implementation CALayer (Addons)

- (void)rm_applyAnimation:(CABasicAnimation *)animation
{
    CABasicAnimation *animationCopy = [animation copy];
    if (!animationCopy.fromValue) {
        animationCopy.fromValue = [self.presentationLayer valueForKeyPath:animationCopy.keyPath];
    }
    [self addAnimation:animationCopy forKey:animationCopy.keyPath];
    [self setValue:animationCopy.toValue forKeyPath:animationCopy.keyPath];
}

@end
