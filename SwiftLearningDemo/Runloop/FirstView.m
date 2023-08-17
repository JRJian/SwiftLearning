//
//  FirstView.m
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/8/17.
//

#import "FirstView.h"
#import "SecView.h"

@implementation FirstView {
    SecView *_secView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _secView = [SecView new];
        [self addSubview: _secView];
        _secView.frame = CGRectMake(0, 100, 100, 100);
        _secView.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor blueColor];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(tapGes:)];
        // 设置为yes。那就是view的本身touchesBegan不识别，包括其他subviews
        // tapGes识别，其他view
        tapGes.delaysTouchesBegan = YES;
        [self addGestureRecognizer:tapGes];
        
    }
    return self;
}

- (void)tapGes:(UITapGestureRecognizer *)ges {
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"UIGestureRecognizerStateBegan");
            break;
        case UIGestureRecognizerStatePossible:
            NSLog(@"UIGestureRecognizerStatePossible");
            break;
        case UIGestureRecognizerStateRecognized:
            NSLog(@"UIGestureRecognizerStateRecognized");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"UIGestureRecognizerStateFailed");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"UIGestureRecognizerStateCancelled");
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"FirstView touchesBegan");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"FirstView touchesEnded");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"FirstView touchesMoved");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"FirstView hitTest");
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"FirstView pointInside");
    return [super pointInside:point withEvent:event];
}

@end
