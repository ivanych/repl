//
//  Common.m
//  Repl
//
//  Created by ivanych on 15.07.13.
//
//

#import "Common.h"

@implementation Common

// Вычисление хеша MD5
- (NSString*)md5:(NSString*)input {
    NSLog(@"Common.md5 -> input: %@", input);
    
    const char * str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",result[i]];
    }
    
    NSLog(@"Common.md5 <- %@", output);
    
    return output;
}

@end
