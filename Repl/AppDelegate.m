//
//  AppDelegate.m
//  Repl
//
//  Created by ivan ivanych on 02.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Three.h"


@implementation AppDelegate

// Инициализация приложения
- (void)awakeFromNib {
    // Объект статусной панели
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    // Объект для работы с файлами
    NSBundle *bundle = [NSBundle mainBundle];
    
    // Загрузка изображений для иконки
    statusImage1 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon1" ofType:@"png"]];
    statusImage2 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon2" ofType:@"png"]];
    
    // Параметры объекта статусной панели
    [statusItem setMenu:statusMenu];
    [statusItem setImage:statusImage1];
    [statusItem setAlternateImage:statusImage2];
    [statusItem setHighlightMode:YES];
    [statusItem setToolTip:@"Repl"];
    
    // Объект для работы со звуком
    _sound = [NSSound alloc];
}

// Открыть файлы
- (IBAction)openFile:(id)sender {
    
    // Создать диалог открытия файлов
    NSOpenPanel *fileDialog = [NSOpenPanel openPanel];
    
    // Свойства диалога
    [fileDialog setCanChooseFiles:YES];
    [fileDialog setCanChooseDirectories:YES];
    [fileDialog setAllowsMultipleSelection:YES];
    
    // Вывести диалог
    // Если запуск вернул нажатие кнопки OK - обработать выбранные файлы
    if ( [fileDialog runModal] == NSFileHandlingPanelOKButton ) {
        
        // Список выбранных файлов (url)
        NSArray *urls = [fileDialog URLs];
        
        // Находим меню треков (тег "1" для пункта меню треков задан в редакторе, в файле интерфейса)
        NSMenuItem * trackMenuItem = [statusMenu itemWithTag:1];
        NSMenu * trackMenu = [trackMenuItem submenu];
        
        // Разблокируем пункт меню треков
        [trackMenuItem setEnabled:YES];
        
        // Очищаем меню треков от предыдущего содержимого
        [trackMenu removeAllItems];
        
        // Дерево файлов
        Three *three = [[Three alloc] init];
        
        // Список треков
        trackList = [[List alloc] init];
        
        // Читаем все выбранные файлы
        for(NSURL *url in urls) {
            NSLog(@"URL:=  %@", url);
            
            // Берем из URL только путь к файлу
            NSString *path = [url path];
            
            // Обход дерева файлов
            [three getPath:path forMenu:trackMenu toList:trackList];
        }
    }
}

// Запустить трек
- (IBAction)playTrack:(id)sender {
    NSLog(@"%ld - %@",[sender tag], [trackList track:[sender tag]]);
    
    if ([_sound isPlaying])
        [_sound stop];
    
    NSString *trackPath = [trackList track:[sender tag]];
    _sound = [_sound initWithContentsOfFile:trackPath byReference:false];
    [_sound play];
}

@end
