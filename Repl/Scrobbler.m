//
//  Scrobbler.m
//  Repl
//
//  Created by ivanych on 28.06.13.
//
//

#import "Scrobbler.h"

@implementation Scrobbler

@synthesize sessionKey;
@synthesize tokenKey;

- (id)init {
    self = [super init];
    if (self) {
        apiKey = @"67592d620c3e6ddff30dc4dcf514f66a";
        apiSecret = @"5812fa5821ea9a1b704a5b69fbcd4d66";
        
        // Конфиг
        config = [NSUserDefaults standardUserDefaults];
        
        // Общие методы
        common = [[Common alloc] init];
    }
    
    return self;
}

// Получить токен
- (id)getToken {
    NSLog(@"Scrobbler.getToken -> ()");
    
    // Стереть старую сессию
    sessionKey = nil;
    [config setObject:sessionKey forKey:@"sessionKey"];
    [config synchronize];
    
    // Сигнатура api_sig
    NSString * apiSigStr =                         @"api_key";
    apiSigStr = [apiSigStr stringByAppendingString:apiKey];
    apiSigStr = [apiSigStr stringByAppendingString:@"methodauth.getToken"];
    apiSigStr = [apiSigStr stringByAppendingString:apiSecret];
    NSString * apiSig = [common md5:apiSigStr];
    
    // URL запроса
    NSString * urlStr =                      @"http://ws.audioscrobbler.com/2.0/";
    urlStr = [urlStr stringByAppendingString:@"?method=auth.gettoken"];
    urlStr = [urlStr stringByAppendingString:@"&api_key="];
    urlStr = [urlStr stringByAppendingString:apiKey];
    urlStr = [urlStr stringByAppendingString:@"&api_sig="];
    urlStr = [urlStr stringByAppendingString:apiSig];
    NSURL * url = [NSURL URLWithString:urlStr];
    
    NSString * token;
    
    // Создаем XML-документ из URL
    NSXMLDocument * xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:url options:NSXMLDocumentTidyXML error:nil];

    NSString * xpathNode = @"/lfm/token";
    
    // Получить узел
    NSArray *nodes = [xmlDoc nodesForXPath:xpathNode error:nil];

    if ([nodes count] > 0 ) {
        // Токен
        token = [[nodes objectAtIndex:0] stringValue];
    }
    else {
        NSLog(@"Scrobbler.getToken - unknown xpathNode: %@", xpathNode);
    }
    
    NSLog(@"Scrobbler.getToken <- %@", token);
    
    return token;
}

// Авторизация
- (BOOL)auth:(id)token {
    NSLog(@"Scrobbler.auth -> token: %@", token);
    
    // URL запроса
    NSString * urlStr =                      @"http://www.last.fm/api/auth/";
    urlStr = [urlStr stringByAppendingString:@"?api_key="];
    urlStr = [urlStr stringByAppendingString:apiKey];
    urlStr = [urlStr stringByAppendingString:@"&token="];
    urlStr = [urlStr stringByAppendingString:token];
    NSURL * url = [NSURL URLWithString:urlStr];
    
    if ( ![[NSWorkspace sharedWorkspace] openURL:url] ) {
        return FALSE;
    }
    else {
        return TRUE;
    }
}

// Получить сессию
- (id)getSession:(id)token {
    NSLog(@"Scrobbler.getSession -> token: %@", token);
        
    // Сигнатура api_sig
    NSString * apiSigStr =                         @"api_key";
    apiSigStr = [apiSigStr stringByAppendingString:apiKey];
    apiSigStr = [apiSigStr stringByAppendingString:@"methodauth.getSession"];
    apiSigStr = [apiSigStr stringByAppendingString:@"token"];
    apiSigStr = [apiSigStr stringByAppendingString:token];
    apiSigStr = [apiSigStr stringByAppendingString:apiSecret];
    NSString * apiSig = [common md5:apiSigStr];
    
    // URL запроса
    NSString * urlStr =                      @"http://ws.audioscrobbler.com/2.0/";
    urlStr = [urlStr stringByAppendingString:@"?method=auth.getSession"];
    urlStr = [urlStr stringByAppendingString:@"&api_key="];
    urlStr = [urlStr stringByAppendingString:apiKey];
    urlStr = [urlStr stringByAppendingString:@"&token="];
    urlStr = [urlStr stringByAppendingString:token];
    urlStr = [urlStr stringByAppendingString:@"&api_sig="];
    urlStr = [urlStr stringByAppendingString:apiSig];
    NSURL * url = [NSURL URLWithString:urlStr];
    
    NSLog(@"Scrobbler.getSession - urlStr: %@", urlStr);
    
    NSString * session;
    
    // Создаем XML-документ из URL
    NSXMLDocument * xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:url options:NSXMLDocumentTidyXML error:nil];
    
    NSString * xpathNode = @"/lfm/session/key"; // тут еще <name> можно получить (логин авторизованного пользователя)
    
    // Получить узел
    NSArray *nodes = [xmlDoc nodesForXPath:xpathNode error:nil];
    
    if ([nodes count] > 0 ) {
        // Сессия
        session = [[nodes objectAtIndex:0] stringValue];
    }
    else {
        NSLog(@"Scrobbler.getSession - unknown xpathNode: %@", xpathNode);
    }

    NSLog(@"Scrobbler.getSession <- %@", session);
    
    return session;
}

// Создать сессию
- (void)session {
    NSLog(@"Scrobbler.session -> ()");
    
    // Если есть неуcтаревший токен, то считаем, что авторизация была запрошена
    if (tokenKey) {
        NSLog(@"Scrobbler.session -> token found, get session");
        
        // Получить сессию
        NSString * session = [self getSession:tokenKey];
        
        // Если токен был авторизован, то вернется сессия,
        if (session) {
            self.sessionKey = session;
            [config setObject:self.sessionKey forKey:@"sessionKey"];
            [config synchronize];
        }
        // Если сессия не вернулась, то запросим авторизацию для токена, а сессия будет запрошена в следующий раз
        else {
            NSLog(@"Scrobbler.session - session not return, get auth!");
            
            // Запросить авторизацию
            [self auth:tokenKey];
        }
    }
    else {
        NSLog(@"Scrobbler.session - token not found, get auth");
        
        // Получить токен
        NSString * token = [self getToken];
        
        if (token) {
            tokenKey = token;
            
            // Запросить авторизацию
            [self auth:tokenKey];
        }
    }
}

// Скробблить трек
- (void)scrobble:(NSInteger)timestamp artist:(id)artist title:(id)track {
    NSLog(@"Scrobbler.scrobble -> timestamp:%ld artist:%@ title:%@", timestamp, artist, track);
    
    // Если есть сессия
    if (sessionKey) {
        // Сигнатура api_sig
        NSString * apiSigStr =                         @"api_key";
        apiSigStr = [apiSigStr stringByAppendingString:apiKey];
        apiSigStr = [apiSigStr stringByAppendingString:@"artist"];
        apiSigStr = [apiSigStr stringByAppendingString:artist];
        apiSigStr = [apiSigStr stringByAppendingString:@"methodtrack.scrobble"];
        apiSigStr = [apiSigStr stringByAppendingString:@"sk"];
        apiSigStr = [apiSigStr stringByAppendingString:sessionKey];
        apiSigStr = [apiSigStr stringByAppendingString:@"timestamp"];
        apiSigStr = [apiSigStr stringByAppendingString:[NSString stringWithFormat:@"%ld", timestamp]];
        apiSigStr = [apiSigStr stringByAppendingString:@"track"];
        apiSigStr = [apiSigStr stringByAppendingString:track];
        apiSigStr = [apiSigStr stringByAppendingString:apiSecret];
        NSString * apiSig = [common md5:apiSigStr];
        
        // URL запроса
        NSString * urlStr =                      @"http://ws.audioscrobbler.com/2.0/";
        NSURL * url = [NSURL URLWithString:urlStr];
        
        // Параметры запроса
        NSString * params =                      @"method=track.scrobble";//
        params = [params stringByAppendingString:@"&artist="];
        params = [params stringByAppendingString:artist];
        params = [params stringByAppendingString:@"&track="];
        params = [params stringByAppendingString:track];
        params = [params stringByAppendingString:@"&timestamp="];
        params = [params stringByAppendingString:[NSString stringWithFormat:@"%ld", timestamp]];
        params = [params stringByAppendingString:@"&api_key="];
        params = [params stringByAppendingString:apiKey];
        params = [params stringByAppendingString:@"&sk="];
        params = [params stringByAppendingString:sessionKey];
        params = [params stringByAppendingString:@"&api_sig="];
        params = [params stringByAppendingString:apiSig];
        
        // Запрос
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
        
        // Выполнение запроса
        NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        // Создаем XML-документ из данных
        NSXMLDocument * xmlDoc = [[NSXMLDocument alloc] initWithData:data options:NSXMLDocumentTidyXML error:nil];

        // Получить узел
        NSString * xpathNode = @"/lfm/@status";
        NSArray * nodes = [xmlDoc nodesForXPath:xpathNode error:nil];
            
        if ([nodes count] > 0 ) {
            if ([[[nodes objectAtIndex:0] stringValue] isEqual:@"failed"]) {
                NSLog(@"Scrobbler.scrobble - status failed!");
                
                // Получить узел
                NSString * xpathNode = @"/lfm/error/@code";
                NSArray *nodes = [xmlDoc nodesForXPath:xpathNode error:nil];
                
                if ([nodes count] > 0 ) {
                    // Если проблема с сессией
                    if ([[[nodes objectAtIndex:0] stringValue] isEqual:@"9"]) {
                        NSLog(@"Scrobbler.scrobble - error code 9 (error session)!");
                        
                        // Создать сессию
                        [self session];
                    }
                    else {
                        NSLog(@"Scrobbler.scrobble - error code: %@", [[nodes objectAtIndex:0] stringValue]);
                    }
                }
                else {
                    NSLog(@"Scrobbler.scrobble - unknown xpathNode: %@", xpathNode);
                }
            }
            else {
                NSLog(@"Scrobbler.scrobble - status ok");
                
                // Получить узел
                NSString * xpathNode = @"/lfm/scrobbles/scrobble/ignoredMessage/@code";
                NSArray *nodes = [xmlDoc nodesForXPath:xpathNode error:nil];
                
                if ([nodes count] > 0 ) {
                    //NSLog(@"Scrobbler.scrobble - filter: %@", [nodes objectAtIndex:0]);
                    
                    // Если проблема с фильтрами (не нулевой код)
                    if (![[[nodes objectAtIndex:0] stringValue] isEqual:@"0"]) {
                        NSLog(@"Scrobbler.scrobble - ignoredmessage code: %@", [[nodes objectAtIndex:0] stringValue]);
                    }
                    else {
                        NSLog(@"Scrobbler.scrobble - scrobble success");
                    }
                }
                else {
                    NSLog(@"Scrobbler.scrobble - unknown xpathNode: %@", xpathNode);
                }
            }
        }
        else {
            NSLog(@"Scrobbler.scrobble - unknown xpathNode: %@", xpathNode);
        }
    }
    // Нет сессии
    else {
        NSLog(@"Scrobbler.scrobble - session not found, get session");
        
        // Создать сессию
        [self session];
    }
}

// Переключить флаг скробблинга
- (void)setScrFlag:(NSInteger)flag {
    NSLog(@"Scrobbler.setScrFlag -> flag: %ld", flag);
    
    scrFlag = flag;
    NSLog(@"Scrobbler.setScrFlag - set scrFlag: %ld", flag);
    
    [menu markScrMenuItem:flag];
}

// Переключить флаг скробблинга
- (void)turnScrFlag {
    NSLog(@"Scrobbler.turnScrFlag -> ()");
    
    if (scrFlag) {
        NSLog(@"Scrobbler.turnScrFlag - scrFlag: 1");
        
        [self setScrFlag:NSOffState];
    }
    else {
        NSLog(@"Scrobbler.turnScrFlag - scrFlag: 0");
        
        // Ставим флаг скробблинга
        [self setScrFlag:NSOnState];
        
        // Если нет сессии
        if (!sessionKey) {
            NSLog(@"Scrobbler.turnScrFlag - session not found, get session");
            
            // Создать сессию
            [self session];
        }
    }
}

// Прочитать флаг скробблинга
- (NSUInteger)scrFlag {
    NSLog(@"Scrobbler.scrFlag -> ()");
    
    NSLog(@"Scrobbler.scrFlag <- %ld", scrFlag);
    
    return scrFlag;
}

// Связать скробблер с меню
- (void)setMenu:(id)m {
    menu = m;
}

@end
