#import "Validator.h"
#import "StringFormatter.h"

@implementation Validator {
    NSDictionary* _predefinedFormats;
    StringFormatter* _formatter;
}


# pragma mark - Init

- (id) init
{
    if (nil != (self = [super init])) {
        _formatter = [[StringFormatter alloc] init];
    }
    return self;
}


# pragma mark - Key Value

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


# pragma mark - Phone Number Validation

- (void) _validatePhoneNumberField:(UITextField*)sender
{
    if ([sender.text length] <= 14) {
        [sender setText:[_formatter formatInputString:sender.text withType:StringFormatterTypePhoneUS]];
    } else {
        [sender setText:[sender.text substringToIndex:14]];
    }
}


# pragma mark - Date Validation

- (void) _validateDateField:(UITextField*)sender
{
    if ([sender.text length] <= 10) {
        [sender setText:[_formatter formatInputString:sender.text withType:StringFormatterTypeDateUS]];

        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"mm/dd/yyyy"];
        NSLog(@"%@", [dateFormat dateFromString:sender.text]);

    } else {
        [sender setText:[sender.text substringToIndex:10]];
    }
}

@end
