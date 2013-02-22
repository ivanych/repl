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
        rndFlag = 0;
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

// Переключить флаг случайного режима воспроизведения
- (void)turnRndFlag:(id)sender {
    if (rndFlag) {
        rndFlag = 0;
        [sender setState:NSOffState];
    }
    else {
        rndFlag = 1;
        [sender setState:NSOnState];
    }
}

// Прочитать флаг случайного режима воспроизведения
- (NSUInteger)rndFlag {
    return rndFlag;
}

@end
