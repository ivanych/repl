//
//  Three.h
//  Repl
//
//  Created by ivan ivanych on 10.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Three : NSObject{
    NSMenuItem *playItem;
    NSUInteger *rndFlag;
}

- (id)init;

- (void)getPath:(id)path forMenu:(id)menu toList:(id)list;

- (void)markTrack:(id)item state:(NSUInteger)val;

- (void)setPlayItem:(id)item;
- (id)playItem;

- (void)turnRndFlag:(id)sender;
- (NSUInteger)rndFlag;

@end
