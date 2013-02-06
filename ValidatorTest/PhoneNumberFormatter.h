//  Created by Ahmed Abdelkader on 1/22/10.
//  This work is licensed under a Creative Commons Attribution 3.0 License.

#import <Foundation/Foundation.h>

@interface PhoneNumberFormatter : NSObject {
    NSDictionary *predefinedFormats;
}

- (id)init;
- (NSString*) format:(NSString*) phoneNumber withLocale:(NSString*) locale;

@end