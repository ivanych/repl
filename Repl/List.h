//
//  List.h
//  Repl
//
//  Created by Mikhail Ivanov on 31.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface List : NSObject {
    
    // Плейлист
    NSMutableArray *hlist;
    
    // Флаг случайного режима
    NSUInteger rndFlag;
    
    // Проигрываемый трек
    NSUInteger playTrack;
}

- (id)init;

- (void)reset;

- (NSUInteger)addTrack:(id)path;
- (void)linkTrack:(NSUInteger)number withItem:(id)item;

- (id)path:(NSUInteger)number;
- (id)item:(NSUInteger)number;

- (void)setPlayTrack:(NSUInteger)number;
- (NSUInteger)playTrack;

- (NSUInteger)nextTrack;
- (NSUInteger)prevTrack;
 
- (void)turnRndFlag:(id)sender;
- (NSUInteger)rndFlag;

@end
