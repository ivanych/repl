//
//  List.h
//  Repl
//
//  Created by ivanych on 31.07.12.
//
//

#import <Cocoa/Cocoa.h>

@interface List : NSObject {
    NSMutableArray *list;
    NSUInteger *rndFlag;
    NSUInteger playTrack;
}

- (id)init;

- (NSUInteger)addTrack:(id)path;
- (id)track:(NSUInteger)index;

- (void)turnRndFlag:(id)sender;
- (NSUInteger)rndFlag;

- (void)setPlayTrack:(NSUInteger)index;
- (NSUInteger)playTrack;

- (NSUInteger)nextTrack;

@end
