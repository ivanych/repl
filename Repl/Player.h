//
//  Player.h
//  Repl
//
//  Created by Dmitry Rassoshenko on 18.11.12.
//
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

@interface Player : NSObject

// флаг воспроизведения файла в текущий момент
@property bool is_playing;

// Инициализация плеера
- (id)init;

// воспроизводит файл по пути filePath
- (void)play:(NSString*)filePath;

// останавливает текущее воспроизведение
- (void)stop;

@end
