//
//  List.m
//  Repl
//
//  Created by Mikhail Ivanov on 31.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import "List.h"
#import "Menu.h"

@implementation List

- (id)init {
    if (self = [super init]) {
        hlist = [NSMutableArray arrayWithCapacity:1];
    }
    
    return self;
}

// Стереть все содержимое списка
- (void)reset {
    NSLog(@"List.reset -> ()");
    
    // Удалить все треки из списка
    [hlist removeAllObjects];
    NSLog(@"List.reset - remove all track");
}

// Добавить трек в список
- (NSUInteger)addTrack:(id)path artist:(id)a title:(id)t {
    
    NSMutableDictionary *h = [NSMutableDictionary dictionaryWithObject:path forKey:@"path"];
    
    [h setObject:a forKey:@"artist"];
    [h setObject:t forKey:@"title"];
    
    [hlist addObject:h];
    
    NSLog(@"List.addTrack - number: %ld, path: %@", [hlist count], [[hlist objectAtIndex:[hlist count]-1] objectForKey:@"path"]);
    
    return [hlist count];
}

- (void)linkTrack:(NSUInteger)number withItem:(id)item {
    
    [[hlist objectAtIndex:number-1] setObject:item forKey:@"item"];
    
    NSLog(@"List.linkTrack - number: %ld, item tag: %ld, item title: %@", number, [[[hlist objectAtIndex:number-1] objectForKey:@"item"] tag], [[[hlist objectAtIndex:number-1] objectForKey:@"item"] title]);
}

- (id)path:(NSUInteger)number {
    NSLog(@"List.path -> number: %ld", number);
    
    NSLog(@"List.path <- path: %@", [[hlist objectAtIndex:number-1] objectForKey:@"path"]);
    
    return [[hlist objectAtIndex:number-1] objectForKey:@"path"];
}

- (id)item:(NSUInteger)number {
    NSLog(@"List.item -> number: %ld", number);
    
    NSLog(@"List.item <- item: %@", [[hlist objectAtIndex:number-1] objectForKey:@"item"]);
    
    return [[hlist objectAtIndex:number-1] objectForKey:@"item"];
}

- (id)artist:(NSUInteger)number {
    NSLog(@"List.artist -> number: %ld", number);
    
    NSLog(@"List.artist <- artist: %@", [[hlist objectAtIndex:number-1] objectForKey:@"artist"]);
    
    return [[hlist objectAtIndex:number-1] objectForKey:@"artist"];
}

- (id)title:(NSUInteger)number {
    NSLog(@"List.title -> number: %ld", number);
    
    NSLog(@"List.title <- title: %@", [[hlist objectAtIndex:number-1] objectForKey:@"title"]);
    
    return [[hlist objectAtIndex:number-1] objectForKey:@"title"];
}

// Установить текущий проигрываемый трек плейлиста
- (void)setPlayTrack:(NSUInteger)number {
    NSLog(@"List.setPlayTrack -> number: %ld", number);
    
    playTrack = number;
    NSLog(@"List.setPlayTrack - set number: %ld", playTrack);
}

// Получить номер проигрываемого трека
- (NSUInteger)playTrack {
    NSLog(@"List.playTrack -> ()");
    
    NSLog(@"List.playTrack <- number: %ld", playTrack);
    
    return playTrack;
}

// Номер следующего трека
- (NSUInteger)nextTrack {
    NSLog(@"List.nextTrack -> ()");
    
    NSUInteger allTrack = [hlist count];
    
    NSUInteger nextTrack;
    
    if (rndFlag) {
        NSLog(@"List.nextTrack - rndFlag: 1, next track = random");
        
        nextTrack = (random() % allTrack) + 1;
    }
    else {
        NSLog(@"List.nextTrack - rndFlag: 0, next track = next");
        
        if (playTrack == allTrack) {
            nextTrack = 1;
        }
        else {
            nextTrack = playTrack+1;
        }
    }
    
    NSLog(@"List.nextTrack - playTrack: %ld, all track: %ld, next track: %ld", playTrack, allTrack, nextTrack);
    
    NSLog(@"List.nextTrack <- number: %ld", nextTrack);
    
    return nextTrack;
}

// Номер предыдущего трека
- (NSUInteger)prevTrack {
    NSLog(@"List.prevTrack -> ()");
    
    NSUInteger allTrack = [hlist count];
    
    NSUInteger prevTrack;
    
    if (rndFlag) {
        NSLog(@"List.prevTrack - rndFlag: 1, prev track = random");
        
        prevTrack = (random() % allTrack) + 1;
    }
    else {
        NSLog(@"List.prevTrack - rndFlag: 0, prev track = prev");
        
        if (playTrack <= 1) {
            prevTrack = allTrack;
        }
        else {
            prevTrack = playTrack-1;
        }
    }
    
    NSLog(@"List.prevTrack - playTrack: %ld, all track: %ld, prev track: %ld", playTrack, allTrack, prevTrack);
    
    NSLog(@"List.prevTrack <- number: %ld", prevTrack);
    
    return prevTrack;
}

// Переключить флаг случайного режима воспроизведения
- (void)setRndFlag:(NSInteger)flag {
    NSLog(@"List.setRndFlag -> flag: %ld", flag);

    rndFlag = flag;
    NSLog(@"List.setRndFlag - set rndFlag: %ld", flag);
    
    [menu markRndMenuItem:flag];
}

// Переключить флаг случайного режима воспроизведения
- (void)turnRndFlag {
    NSLog(@"List.turnRndFlag -> ()");
    
    if (rndFlag) {
        NSLog(@"List.turnRndFlag - rndFlag: 1");
        
        [self setRndFlag:NSOffState];
    }
    else {
        NSLog(@"List.turnRndFlag - rndFlag: 0");
        
        rndFlag = 1;
        [self setRndFlag:NSOnState];
    }
}

// Прочитать флаг случайного режима воспроизведения
- (NSUInteger)rndFlag {
    NSLog(@"List.rndFlag -> ()");
    
    NSLog(@"List.rndFlag <- %ld", rndFlag);
    
    return rndFlag;
}

// Связать плеер с меню
- (void)setMenu:(id)m {
    menu = m;
}

@end
