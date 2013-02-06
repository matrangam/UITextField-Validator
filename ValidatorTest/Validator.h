#import <Foundation/Foundation.h>

@interface Validator : NSObject

@property (nonatomic, weak) IBOutletCollection(UITextField) NSArray* phoneNumberFields;
@property (nonatomic, weak) IBOutletCollection(UITextField) NSArray* dateFields;

@end
