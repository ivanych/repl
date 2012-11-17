//
//  Player.h
//  Repl
//
//  Created by Dmitry Rassoshenko on 18.11.12.
//
//

#import <Cocoa/Cocoa.h>

@interface Player : NSObject {
    // объект для воспроизведения музыки
    NSSound *_sound;

    // текущий файл для воспроизведения
    NSString *_currentFilePath;
}

- (id)init;

// воспроизводит файл по пути filePath
- (void)play:(NSString*)filePath;

// останавливает текущее воспроизведение
- (void)stop;

@end
