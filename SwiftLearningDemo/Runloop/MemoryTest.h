//
//  MemoryTest.h
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/8/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Memory_Test : NSObject
@property (nonatomic, copy) NSString *str;
- (void)crashTest;
@end

NS_ASSUME_NONNULL_END
