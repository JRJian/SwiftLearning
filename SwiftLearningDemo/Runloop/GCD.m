//
//  GCD.m
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/8/11.
//

#import "GCD.h"
#import <UIKit/UIKit.h>

@interface view : UIView
@end
@implementation view

- (void)setNeedsLayout {
    
}

- (void)setNeedsDisplay {
    
}

- (void)layoutIfNeeded {
    
}

@end

@interface GCD()
@property (nonatomic, assign) int ticketSurplusCount;
@property (nonatomic, strong) dispatch_semaphore_t semaphoreLock;
@property (nonatomic, strong) NSLock *lock;
@end

@implementation GCD {
    dispatch_queue_t serialDispatchQueue;
    dispatch_queue_t concurrentDispatchQueue;
}

- (id)init {
    if (self = [super init]) {
        serialDispatchQueue = dispatch_queue_create("jian.serial.queue", DISPATCH_QUEUE_SERIAL);
        concurrentDispatchQueue = dispatch_queue_create("jian.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        [self initTicketStatus];
    }
    return self;
}

- (void)semaphore {
//    NSLog(@"current thread %@", [NSThread currentThread]);
//    NSLog(@"semaphore begin");
//
//    dispatch_queue_t gobalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(100);
//
//    __block int number = 0;
//    for (int i = 0; i < 100; i++) {
//        dispatch_async(gobalQueue, ^{
//            NSLog(@"1---%@", [NSThread currentThread]);
//
//            number++;
//
////            dispatch_semaphore_signal(semaphore);
//        });
//    }
//
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"semaphore end, number = %d", number);
}

- (void)initTicketStatus {
    
    // 总票数
    self.ticketSurplusCount = 50;
    self.semaphoreLock = dispatch_semaphore_create(1);
    self.lock = [[NSLock alloc] init];
    
    // 窗口1
    dispatch_queue_t queue1 = dispatch_queue_create("jian.ticket_channel_1", DISPATCH_QUEUE_SERIAL);
    // 窗口2线程
    dispatch_queue_t queue2 = dispatch_queue_create("jian.ticket_channel_2", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicketSafe];
    });
    dispatch_async(queue2, ^{
        [weakSelf saleTicketSafe];
    });
}

- (void)saleTicketSafe {
    
    while (1) {
        
        dispatch_semaphore_wait(self.semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount --;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else {
            NSLog(@"所有票据已经卖完");
            dispatch_semaphore_signal(self.semaphoreLock);
            break;
        }
        
        dispatch_semaphore_signal(self.semaphoreLock);
    }
}

@end
    
