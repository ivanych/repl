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
}

- (id)init;

- (NSUInteger)addTrack:(id)path;
- (id)track:(NSUInteger)index;

@end
