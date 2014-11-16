//
//  CameraButton.m
//  Hungry Students
//
//  Created by Rutger Farry on 11/16/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import "CameraButton.h"

@implementation CameraButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    /// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.192 green: 0.592 blue: 0.98 alpha: 1];
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor.blackColor colorWithAlphaComponent: 0.5];
    CGSize shadowOffset = CGSizeMake(3.1, 3.1);
    CGFloat shadowBlurRadius = 8;
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 88, 88)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
    [color setFill];
    [ovalPath fill];
    CGContextRestoreGState(context);
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(19, 29, 50, 33) cornerRadius: 8];
    [color setFill];
    [rectanglePath fill];
    [UIColor.whiteColor setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(33, 34, 22, 22)];
    [UIColor.whiteColor setFill];
    [oval2Path fill];
    [UIColor.whiteColor setStroke];
    oval2Path.lineWidth = 1;
    [oval2Path stroke];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(33, 29.5)];
    [bezierPath addLineToPoint: CGPointMake(35, 25.5)];
    [bezierPath addLineToPoint: CGPointMake(53, 25.5)];
    [bezierPath addLineToPoint: CGPointMake(55, 29.5)];
    [color setFill];
    [bezierPath fill];
    [UIColor.whiteColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(44, 38.5)];
    [bezier2Path addCurveToPoint: CGPointMake(44, 52.48) controlPoint1: CGPointMake(44, 53.69) controlPoint2: CGPointMake(44, 52.48)];
    [UIColor.whiteColor setFill];
    [bezier2Path fill];
    [color setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
    [bezier3Path moveToPoint: CGPointMake(37, 45.5)];
    [bezier3Path addCurveToPoint: CGPointMake(51, 45.5) controlPoint1: CGPointMake(51, 45.5) controlPoint2: CGPointMake(51, 45.5)];
    [UIColor.whiteColor setFill];
    [bezier3Path fill];
    [color setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
    
}


@end
