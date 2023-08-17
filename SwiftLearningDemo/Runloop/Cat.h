//
//  Cat.h
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cat : NSObject
{
    int _eyesCount;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) bool male;
@property (nonatomic, strong) id info;

- (void)barke;
- (void)run;
+ (void)runtimeCall;
+ (void)classBarke;

@end

NS_ASSUME_NONNULL_END
