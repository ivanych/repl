//
//  List.h
//  Repl
//
//  Created by ivanych on 31.07.12.
//
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

- (NSUInteger)addTrack:(id)path;
- (void)linkTrack:(NSUInteger)number withItem:(id)item;

- (id)path:(NSUInteger)number;
- (id)item:(NSUInteger)number;

- (void)setPlayTrack:(NSUInteger)number;
- (NSUInteger)playTrack;

- (NSUInteger)nextTrack;
 
- (void)turnRndFlag:(id)sender;
- (NSUInteger)rndFlag;

@end
