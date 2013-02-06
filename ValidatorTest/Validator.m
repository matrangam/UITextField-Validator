#import "Validator.h"

@implementation Validator {
    NSDictionary* _predefinedFormats;
}


# pragma mark - Init

- (id) init
{
    if (nil != (self = [super init])) {
        NSArray *usPhoneFormats = @[
                                    @"011 $",
                                    @"###-####",
                                    @"(###) ###-####"
                                    ];
        
        NSArray* usDateFormats = @[@"##/##/####"];
        
        _predefinedFormats = @{
                              @"us": usPhoneFormats,
                              @"us-date": usDateFormats
                              };
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
        [sender setText:[self _format:sender.text withLocale:@"us"]];
    } else {
        [sender setText:[sender.text substringToIndex:14]];
    }
}


# pragma mark - Date Validation

- (void) _validateDateField:(UITextField*)sender
{
    if ([sender.text length] <= 10) {
        [sender setText:[self _format:sender.text withLocale:@"us-date"]];

        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"mm/dd/yyyy"];
        NSLog(@"%@", [dateFormat dateFromString:sender.text]);

    } else {
        [sender setText:[sender.text substringToIndex:10]];
    }
}


# pragma mark - Formatter

- (NSString*) _format:(NSString*)inputString withLocale:(NSString*)locale
{
    NSArray *localeFormats = [_predefinedFormats objectForKey:locale];
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


# pragma mark - Formatter Helper

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
