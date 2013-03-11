//
//  Player.m
//  Repl
//
//  Created by Mikhail Ivanov on 09.08.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)init {
    if (self = [super init]) {
        sound = [NSSound alloc];
        [sound setDelegate: self];
    }

    return self;
}

// Остановить проигрывание
- (void)stop {
    NSLog(@"Player.stop -> ()");
    
    [sound stop];
    isPlay = NO;
    NSLog(@"Player.stop - sound stop");
}

// Продолжить проигрывание
- (void)resume {
    NSLog(@"Player.resume -> ()");
    
    [sound resume];
    isPlay = YES;
    NSLog(@"Player.resume - sound set resume");
}

// Приостановить проигрывание
- (void)pause {
    NSLog(@"Player.pause -> ()");
    
    [sound pause];
    isPlay = NO;
    NSLog(@"Player.pause - sound set pause");
}

// Запустить проигрывание файла
- (void)playFile:(id)path {
    NSLog(@"Player.playFile -> path: %@", path);
    
    // Если что-то уже играет - остановить
    if ([sound isPlaying]) {
        NSLog(@"Player.playFile - sound isPlaying");
        
        [self stop];
    }
    
    // Открыть файл и запустить
    sound = [sound initWithContentsOfFile:path byReference:false];
    [sound play];
    isPlay = YES;
    NSLog(@"Player.playFile - sound play");
}

// Запустить проигрывание трека
- (void)playTrack:(NSUInteger)number {
    NSLog(@"Player.playTrack -> number: %ld", number);
    
    // Путь к файлу трека
    NSString *path = [list path:number];

    // Запустить проигрывание файла
    [self playFile:path];
    
    // Отметить проигрываемый трек в меню
    [menu markMenu:number];
    
    // Запомнить проигрываемый трек
    [list setPlayTrack:number];
}

// Приостановить или продолжить проигрывание трека
- (void)pauseTrack {
    NSLog(@"Player.pauseTrack -> ()");
    
    // Если что-то уже играет - приостановить или продолжить
    if ([sound isPlaying]) {
        NSLog(@"Player.pauseTrack - sound isPlaying");
        
        // Если трек проигрывается - приостановить
        if (isPlay) {
            NSLog(@"Player.pauseTrack - sound isPlay");
            
            [self pause];
        }
        else {
            NSLog(@"Player.pauseTrack - sound notPlay");
            
            [self resume];
        }
    }
    // Если ничего не играет - запустить проигрывание
    else {
        NSLog(@"Player.pauseTrack - sound notPlaying");
        
        [self playNextTrack];
    }
}

// Запустить проигрывание следующего трека
- (void)playNextTrack {
    NSLog(@"Player.playNextTrack - - - - - - - - - - - - - - -");
    NSLog(@"Player.playNextTrack -> ()");
    
    // Следующий трек
    NSUInteger number = [list nextTrack];
    NSLog(@"Player.playNextTrack -> number: %ld", number);
    
    // Запустить проигрывание трека
    [self playTrack:number];
}

// Запустить проигрывание предыдущего трека
- (void)playPrevTrack {
    NSLog(@"Player.playPrevTrack - - - - - - - - - - - - - - -");
    NSLog(@"Player.playPrevTrack -> ()");
    
    // Предыдущий трек
    NSUInteger number = [list prevTrack];
    NSLog(@"Player.playPrevTrack -> number: %ld", number);
    
    // Запустить проигрывание трека
    [self playTrack:number];
}

// Вызывается после завершения проигрывания трека
- (void)sound:(NSSound *)snd didFinishPlaying:(BOOL)playbackSuccessful {
    NSLog(@"Player.sound -> snd: %@, playbackSuccessful: %hhd", snd, playbackSuccessful);
    
    if (playbackSuccessful) {
        NSLog(@"Player.sound - current sound end");
        
        [self playNextTrack];
    }
    else {
        NSLog(@"Player.sound - current sound interrupt!");
    }
}

// Связать плеер с плейлистом
- (void)setList:(id)l {
    list = l;
}

// Связать плеер с меню
- (void)setMenu:(id)m {
    menu = m;
}

@end
