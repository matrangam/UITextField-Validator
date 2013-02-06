#import "Validator.h"
#import "PhoneNumberFormatter.h"

@implementation Validator

- (void) setValue:(id)object forKey:(NSString*)key
{
    if ([key isEqualToString:@"phoneNumberFields"]) {
        for (UITextField* textField in object) {
            [textField addTarget:self action:@selector(_validatePhoneNumberField:) forControlEvents:UIControlEventAllEditingEvents];
        }
    } else if ([key isEqualToString:@"dateFields"]) {
        for (UITextField* textField in object) {
            [textField addTarget:self action:@selector(_validateDateField:) forControlEvents:UIControlEventAllEditingEvents];
        }
    }
}

- (void) _validatePhoneNumberField:(UITextField*)sender
{
    if ([sender.text length] <= 14) {
        PhoneNumberFormatter* formatter = [[PhoneNumberFormatter alloc] init];
        [sender setText:[formatter format:sender.text withLocale:@"us"]];
    } else {
        [sender setText:[sender.text substringToIndex:14]];
    }
}

- (void) _validateDateField:(UITextField*)sender
{
    if ([sender.text length] <= 10) {
        PhoneNumberFormatter* formatter = [[PhoneNumberFormatter alloc] init];
        [sender setText:[formatter format:sender.text withLocale:@"us-date"]];
    } else {
        [sender setText:[sender.text substringToIndex:10]];
    }
}

@end
