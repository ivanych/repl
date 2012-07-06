//
//  AppDelegate.m
//  Repl
//
//  Created by ivan ivanych on 02.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

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
        
        // Показать выбранные файлы
        //NSAlert *alert = [[NSAlert alloc] init];
        //[alert setMessageText:[files componentsJoinedByString:@",\n"]];
        //[alert runModal];
        
        // Обход дерева файлов
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        BOOL isDir;
        
        for(NSURL *url in urls) {
            NSLog(@"%@", url);
            
            // Берем из URL только путь к файлу
            NSString *path = [url path];
            NSLog(@"%@", path);
            
            // Если файл является каталогом
            if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
                NSLog(@"dir");
            }
            // Если файл является файлом
            else {
                NSLog(@"not dir");
            }
        }
    }
}

@end
