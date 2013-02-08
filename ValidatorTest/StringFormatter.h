#import <Foundation/Foundation.h>

@interface StringFormatter : NSObject {
    NSDictionary *predefinedFormats;
}

extern NSString* const StringFormatterTypePhoneUS;
extern NSString* const StringFormatterTypeDateUS;

- (NSString*) formatInputString:(NSString*)inputString withType:(NSString*)locale;

@end