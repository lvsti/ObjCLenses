//
//  Lens.m
//  ObjCLenses
//
//  Created by Tamas Lustyik on 2014.11.16..
//  Copyright (c) 2014 Tamas Lustyik. All rights reserved.
//

#import "Lens.h"

#import "ArrayLens.h"
#import "CompositeLens.h"
#import "DictionaryLens.h"
#import "KVCLens.h"
#import "SetLens.h"
#import "StructLens.h"

@implementation Lens

#pragma mark - Factory methods

+ (Lens*)lensToKeyPath:(NSString*)keyPath {
    return [KVCLens lensToKeyPath:keyPath];
}

+ (Lens*)lensToItemAtIndex:(NSInteger)index {
    return [ArrayLens lensToItemAtIndex:index];
}

+ (Lens*)lensToFirstItem {
    return [ArrayLens lensToFirstItem];
}

+ (Lens*)lensToLastItem {
    return [ArrayLens lensToLastItem];
}

+ (Lens*)lensToKey:(id<NSCopying>)key {
    return [DictionaryLens lensToKey:key];
}

+ (Lens*)lensToObject:(id)object {
    return [SetLens lensToObject:object];
}

+ (Lens*)lensToStructKeyPath:(StructKeyPath)structKeyPath {
    return [StructLens lensToStructKeyPath:structKeyPath];
}

- (Lens*)lensByAppendingLens:(Lens*)lens {
    return [CompositeLens lensWithForegroundLens:self
                                  backgroundLens:lens];
}

- (id)view:(id)subject {
    return subject;
}

- (id)map:(id(^)(id))func over:(id)subject {
    return [self set:func([self view:subject]) over:subject];
}

- (id)set:(id)value over:(id)subject {
    return value;
}

@end
