//
//  MemoryTest.m
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/8/31.
//

#import "MemoryTest.h"

@implementation Memory_Test
- (void)crashTest {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0 ; i<1000000; i++) {
            self.str = @"abcd";
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0 ; i<1000000; i++) {
            self.str = [NSString stringWithFormat:@"adfalkdjfldkasjflakjsdkflasf-- %d",i];
        }
    });
}
@end
