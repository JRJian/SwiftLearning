//
//  SecView.m
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/8/17.
//

#import "SecView.h"

@implementation SecView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"SecView touchesBegan");
//    NSLog(@"SecView Next Responder %@", self.nextResponder);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"SecView touchesEnded");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"SecView touchesMoved");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"SecView hitTest");
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"SecView pointInside");
    return [super pointInside:point withEvent:event];
}

@end
