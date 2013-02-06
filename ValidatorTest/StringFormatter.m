//  Created by Ahmed Abdelkader on 1/22/10.
//  This work is licensed under a Creative Commons Attribution 3.0 License.

#import "StringFormatter.h"

@implementation StringFormatter

- (id) init
{
    
    NSArray *usPhoneFormats = @[
                               @"011 $",
                               @"###-####",
                               @"(###) ###-####"
                               ];
    
    NSArray* usDateFormats = @[@"##/##/####"];
    
    predefinedFormats = @{
                          @"us": usPhoneFormats,
                          @"us-date": usDateFormats
                          };
    return self;
}

- (NSString*) format:(NSString*)inputString withLocale:(NSString*)locale
{
    NSArray *localeFormats = [predefinedFormats objectForKey:locale];
    if (localeFormats == nil) {
        return inputString;
    }
    
    NSString *input = [self _strip:inputString];    
    for (NSString *phoneFormat in localeFormats) {
        int i = 0;
        
        NSMutableString *temp = [[NSMutableString alloc] init];
        
        for (int p = 0; temp != nil && i < [input length] && p < [phoneFormat length]; p++) {
            char c = [phoneFormat characterAtIndex:p];
            BOOL required = [self _canBeInputByNumberPad:c];
            char next = [input characterAtIndex:i];
            switch(c) {
                case '$':
                    p--;
                    [temp appendFormat:@"%c", next]; i++;
                    break;
                case '#':
                    if (next < '0' || next > '9') {
                        temp = nil;
                        break;
                    }
                    
                    [temp appendFormat:@"%c", next]; i++;
                    break;
                default:
                    if (required) {
                        if (next != c) {
                            temp = nil;
                            break;
                        }
                        
                        [temp appendFormat:@"%c", next]; i++;
                    } else {
                        [temp appendFormat:@"%c", c];
                        if (next == c) {
                            i++;
                        }
                    }
                    break;
            }
        }
        
        if (i == [input length]) {
            return temp;
        }
    }
    return input;
}

- (NSString*) _strip:(NSString*)inputString
{
    NSMutableString *res = [[NSMutableString alloc] init];
    for (int i = 0; i < [inputString length]; i++) {
        char next = [inputString characterAtIndex:i];
        if ([self _canBeInputByNumberPad:next]) {
            [res appendFormat:@"%c", next];
        }
    }
    return res;
}

- (BOOL) _canBeInputByNumberPad:(char)c
{
    if (c == '+' || c == '*' || c == '#') {
        return YES;
    }
    
    if (c >= '0' && c <= '9') {
        return YES;
    }
    return NO;
}

@end