//
//  List.m
//  Repl
//
//  Created by ivanych on 31.07.12.
//
//

#import "List.h"

@implementation List

- (id)init {
    if (self = [super init]) {
        list = [NSMutableArray arrayWithCapacity:1];
    }
    
    return self;
}

- (id)track:(NSUInteger)index {
    return [list objectAtIndex:index];
}

- (NSUInteger)addTrack:(id)path {
    [list addObject:path];
    
    return [list count]-1;
}

@end
