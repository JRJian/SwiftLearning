//
//  Cat.m
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/18.
//

#import "Cat.h"
#import <objc/runtime.h>

@interface Cat() {
    int _footCount;
}

@end

@implementation Cat {
    UIColor *_hairColor;
}

+ (void)load
{
    // 注意类方法的交换是需要获取到元类才是类方法交互
    swizzleClassMethod(object_getClass((id)self), @selector(classBarke), @selector(swizzled_classBarke));
//    swizzleMethod([Cat class], @selector(barke), @selector(barke));
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void swizzleClassMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)classBarke {
    NSLog(@"classBarke");
}
+ (void)swizzled_classBarke {
    NSLog(@"swizzled_classBarke");
    [self swizzled_classBarke];
}

- (id)init {
    if (self = [super init]) {
        _footCount = 4;
        _eyesCount = 2;
        _name = @"kitty";
        _hairColor = [UIColor orangeColor];
        _age = 15;
        _male = false;
        _info = @{@"sick":@"hair removal"};
    }
    return self;
}

- (void)barke {
    NSLog(@"%@", [NSString stringWithFormat:@"%@:%s", _name, __FUNCTION__]);
}

- (void)run {
    NSLog(@"%@", [NSString stringWithFormat:@"%@:%s", _name, __FUNCTION__]);
}

+ (void)runtimeCall {
    Class catClass = [Cat class];
    const char *className = class_getName(catClass);
    NSLog(@"%s", className);
    
    Class catClassObjc = objc_getClass(className);
    
    Class superClass = class_getSuperclass(catClass);
    NSLog(@"%s", class_getName(superClass));
    Class superClass1 = [catClass superclass];
    NSLog(@"%@", superClass1);
    Class superClass2 = class_getSuperclass(superClass1);
    NSLog(@"%@", superClass2);
    
    NSLog(@"isMetaClass: %@", class_isMetaClass(superClass) ? @"true": @"false");
    
    int instanceSize = class_getInstanceSize(catClass);
    NSLog(@"cat instance size: %ld", instanceSize);
    
    Ivar nameIvar = class_getInstanceVariable(catClass, "_name");
    Ivar ageIvar = class_getInstanceVariable(catClass, "_age");
    
    const char *nameIvarType = ivar_getTypeEncoding(nameIvar);
    NSLog(@"%s", nameIvarType);
    const char *ageIvarType = ivar_getTypeEncoding(ageIvar);
    NSLog(@"%s", ageIvarType);
    
}

@end
