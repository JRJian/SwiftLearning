//
//  KeepAliveThread.m
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/14.
//  线程保活

#import "KeepAliveThread.h"

static KeepAliveThread *thread = nil;
static BOOL isKeepAlive = true;
static NSRunLoop *loop = nil;

@implementation KeepAliveThread

- (void)dealloc {
    NSLog(@"%@ - %s", NSStringFromClass([self class]), __func__);
}

+ (void)testAlive {
    thread = [[KeepAliveThread alloc] initWithBlock:^{
        NSLog(@"%@, start", [NSThread currentThread]);
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        // 关键需要给runloop添加port source timer
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
//        [runloop run];
        loop = runloop;
        
        // 控制退出
        while (isKeepAlive) {
            [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];   // 此方法调用一次，只执行一次
        }
        
        
        NSLog(@"%@, end", [NSThread currentThread]);
    }];
    [thread start];
}

// 退出线程
// runloop官网做法
// 因此通过run方法开启的RunLoop无法终止；如果想终止，就需要使用 runMode:beforeDate:.方式，并使用一个BOOL变量控制while循环以此控制RunLoop；
+ (void)quick {
    CFRunLoopStop([loop getCFRunLoop]);
    isKeepAlive = false;
    thread = nil;
}

@end
