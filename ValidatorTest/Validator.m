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


- (void) _validatePhoneNumberField:(UITextField*)sender
{
    NSString* text = [sender text];
    if ([text length] == 4 && ![text hasSuffix:@"-"] ) {
        NSString* first = [text substringToIndex:3];
        NSString* last = [text substringFromIndex:3];
        [sender setText:[NSString stringWithFormat:@"%@-%@", first, last]];
    } else if ([text length] == 8 && ![text hasSuffix:@"-"] ) {
        NSString* first = [text substringToIndex:7];
        NSString* last = [text substringFromIndex:7];
        [sender setText:[NSString stringWithFormat:@"%@-%@", first, last]];        
    } else if ([text length] >= 12) {
        [sender setText:[text substringToIndex:12]];
    }
}

@end
