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

    }

    return self;
}

// Открыт ли какой-либо трек
- (BOOL)isOpen {
    NSLog(@"Player.isOpen -> ()");
    
    if ([avsound url]) {
        NSLog(@"Player.isOpen <- 1");
        return TRUE;
    }
    else {
        NSLog(@"Player.isOpen <- 0");
        return FALSE;
    }
}

// Открыт ли какой-либо трек
- (BOOL)isPlay {
    NSLog(@"Player.isPlay -> ()");
    
    if ([avsound isPlaying]) {
        NSLog(@"Player.isPlay <- 1");
        return TRUE;
    }
    else {
        NSLog(@"Player.isPlay <- 0");
        return FALSE;
    }
}

// Остановить проигрывание
- (void)stop {
    NSLog(@"Player.stop -> ()");
    
    [avsound stop];
    avsound = nil;
    [menu markPause:0];
    
    NSLog(@"Player.stop - sound stop");
}

// Продолжить проигрывание
- (void)resume {
    NSLog(@"Player.resume -> ()");
    
    [avsound play];
    [menu markPause:1];
    
    NSLog(@"Player.resume - sound resume");
}

// Приостановить проигрывание
- (void)pause {
    NSLog(@"Player.pause -> ()");
    
    [avsound pause];
    [menu markPause:0];
    
    NSLog(@"Player.pause - sound pause");
}

// Запустить проигрывание
- (void)play {
    NSLog(@"Player.play -> ()");
    
    [avsound play];
    [menu markPause:1];
    
    NSLog(@"Player.play - sound play");
}

// Запустить проигрывание файла
- (void)open:(id)path {
    NSLog(@"Player.playFile -> path: %@", path);
    
    // Если что-то уже играет - обнулить
    if ([avsound url]) {
        NSLog(@"Player.playFile - sound initialized, nil");
        
        [self stop];
    }
    
    // Открыть файл
    avsound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [avsound setDelegate: self];
    
    NSLog(@"Player.playFile - sound initialized");
}

// Запустить проигрывание трека
- (void)playTrack:(NSUInteger)number {
    NSLog(@"Player.playTrack -> number: %ld", number);
    
    // Путь к файлу трека
    NSString *path = [list path:number];

    // Открыть трек из файла
    [self open:path];
    
    // Запустить проигрывание трека
    [self play];
    
    // Отметить проигрываемый трек в меню
    [menu markMenu:number];
    
    // Сменить подсказку с названием трека
    NSString *suggest = [[[list artist:number] stringByAppendingString:@"\n"] stringByAppendingString:[list title:number]];
    [menu changeSuggest:suggest];
    
    // Запомнить проигрываемый трек
    [list setPlayTrack:number];
}

// Приостановить или продолжить проигрывание трека
- (void)pauseTrack {
    NSLog(@"Player.pauseTrack -> ()");
    
    // Если что-то уже играет - приостановить или продолжить
    if ([self isOpen]) {        
        // Если трек запущен - приостановить
        if ([self isPlay]) {
            [self pause];
        }
        // Если на паузе - продолжить
        else {
            [self resume];
        }
    }
    // Если ничего не играет - запустить проигрывание
    else {
        [self playNextTrack];
    }
}

// Запустить проигрывание следующего трека
- (void)playNextTrack {
    NSLog(@"Player.playNextTrack -> ()");
    
    // Следующий трек
    NSUInteger number = [list nextTrack];
    NSLog(@"Player.playNextTrack -> number: %ld", number);
    
    // Запустить проигрывание трека
    [self playTrack:number];
}

// Запустить проигрывание предыдущего трека
- (void)playPrevTrack {
    NSLog(@"Player.playPrevTrack -> ()");
    
    // Предыдущий трек
    NSUInteger number = [list prevTrack];
    NSLog(@"Player.playPrevTrack -> number: %ld", number);
    
    // Запустить проигрывание трека
    [self playTrack:number];
}

// Вызывается после завершения проигрывания трека
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Player.audioPlayerDidFinishPlaying -> player: %@, successfully: %hhd", player, flag);
    
    if (flag) {
        NSLog(@"Player.audioPlayerDidFinishPlaying - current track end");
        
        [self playNextTrack];
    }
    else {
        NSLog(@"Player.audioPlayerDidFinishPlaying - current track error!");
    }
}

// Связать плеер с меню
- (void)setMenu:(id)m {
    menu = m;
}

// Связать плеер с плейлистом
- (void)setList:(id)l {
    list = l;
}


@end
