#import "Validator.h"

@implementation Validator

- (void) setValue:(id)object forKey:(NSString*)key
{
    if ([key isEqualToString:@"phoneNumberFields"]) {
        for (UITextField* textField in object) {
            [textField addTarget:self action:@selector(_validatePhoneNumberField:) forControlEvents:UIControlEventAllEditingEvents];
        }
    }
}


- (void) _validatePhoneNumberField:(id)sender
{
    NSLog(@"%@", sender);
}

@end
