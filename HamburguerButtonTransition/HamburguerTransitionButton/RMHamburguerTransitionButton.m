//
//  RMHamburguerTransitionButton.m
//  HamburguerButtonTransition
//
//  Created by Ruben on 08/07/14.
//  Copyright (c) 2014 Caldofran. All rights reserved.
//

#import "RMHamburguerTransitionButton.h"
#import "CALayer+Addons.h"

@interface RMHamburguerTransitionButton ()
@property (nonatomic, strong) CAShapeLayer *top;
@property (nonatomic, strong) CAShapeLayer *bottom;
@property (nonatomic, strong) CAShapeLayer *middle;
@end

static const CGFloat kLineWidth = 4;
static const CGFloat hamburgerStrokeStart = 0.028;
static const CGFloat hamburgerStrokeEnd = 0.111;
static const CGFloat menuStrokeStart = 0.325;
static const CGFloat menuStrokeEnd = 0.9;

@implementation RMHamburguerTransitionButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self customInitialization];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInitialization];
    }
    return self;
}

- (void)customInitialization
{
    self.top.path = [self shortStroke];
    self.middle.path = [self outline];
    self.bottom.path = [self shortStroke];
    
    for (CAShapeLayer *layer in [NSArray arrayWithObjects:self.top, self.middle, self.bottom, nil]) {
        layer.fillColor = nil;
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.lineWidth = kLineWidth;
        layer.miterLimit = kLineWidth;
        layer.lineCap = kCALineCapRound;
        layer.masksToBounds = true;
        
        CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, kLineWidth, kCGLineCapRound, kCGLineJoinMiter, kLineWidth);
        layer.bounds = CGPathGetPathBoundingBox(strokingPath);
        
        layer.actions = @{@"strokeStart": [NSNull null],
                          @"strokeEnd": [NSNull null],
                          @"transform": [NSNull null]};
        
        [self.layer addSublayer:layer];
    }
    
    self.top.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
    self.top.position = CGPointMake(40, 18);
    
    self.middle.position = CGPointMake(27, 27);
    self.middle.strokeStart = hamburgerStrokeStart;
    self.middle.strokeEnd = hamburgerStrokeEnd;
    
    self.bottom.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
    self.bottom.position = CGPointMake(40, 36);
}

#pragma mark - Public
- (void)showMenu:(BOOL)show
{
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    if (show) {
        strokeStart.toValue = @(menuStrokeStart);
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25: -0.4: 0.5: 1];
        
        strokeEnd.toValue = @(menuStrokeEnd);
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25: -0.4: 0.5: 1];
    } else {
        strokeStart.toValue = @(hamburgerStrokeStart);
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25: 0: 0.5: 1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;
        
        strokeEnd.toValue = @(hamburgerStrokeEnd);
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25: 0.3: 0.5: 0.9];
    }
    
    [self.middle rm_applyAnimation:strokeStart];
    [self.middle rm_applyAnimation:strokeEnd];
    
    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    topTransform.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5: -0.8: 0.5: 1.85];
    topTransform.duration = 0.4;
    topTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *bottomTransform = [topTransform copy];
    
    if (show) {
        CATransform3D translation = CATransform3DMakeTranslation(-4, 0, 0);
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -0.7853975, 0, 0, 1)];
        topTransform.beginTime = CACurrentMediaTime() + 0.25;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, 0.7853975, 0, 0, 1)];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    } else {
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        topTransform.beginTime = CACurrentMediaTime() + 0.05;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.05;
    }
    
    [self.top rm_applyAnimation:topTransform];
    [self.bottom rm_applyAnimation:bottomTransform];
}

#pragma mark - Paths
- (CGPathRef)shortStroke
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 2, 2);
    CGPathAddLineToPoint(path, nil, 28, 2);
    return path;
}

- (CGPathRef)outline
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 10, 27);
    CGPathAddCurveToPoint(path, nil, 12.00, 27.00, 28.02, 27.00, 40, 27);
    CGPathAddCurveToPoint(path, nil, 55.92, 27.00, 50.47,  2.00, 27,  2);
    CGPathAddCurveToPoint(path, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
    CGPathAddCurveToPoint(path, nil,  2.00, 40.84, 13.16, 52.00, 27, 52);
    CGPathAddCurveToPoint(path, nil, 40.84, 52.00, 52.00, 40.84, 52, 27);
    CGPathAddCurveToPoint(path, nil, 52.00, 13.16, 42.39,  2.00, 27,  2);
    CGPathAddCurveToPoint(path, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
    return path;
}

#pragma mark - Getters
- (CAShapeLayer *)top
{
    if (!_top) {
        _top = [CAShapeLayer layer];
    }
    return _top;
}

- (CAShapeLayer *)middle
{
    if (!_middle) {
        _middle = [CAShapeLayer layer];
    }
    return _middle;
}

- (CAShapeLayer *)bottom
{
    if (!_bottom) {
        _bottom = [CAShapeLayer layer];
    }
    return _bottom;
}

@end
