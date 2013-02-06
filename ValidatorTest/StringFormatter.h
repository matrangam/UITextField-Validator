#import <Foundation/Foundation.h>

@interface StringFormatter : NSObject {
    NSDictionary *predefinedFormats;
}

- (id)init;
- (NSString*) format:(NSString*) inputString withLocale:(NSString*) locale;

@end