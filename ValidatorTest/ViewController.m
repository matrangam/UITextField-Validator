#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_textInputOne addTarget:self action:@selector(_checkInput:) forControlEvents:UIControlEventAllEditingEvents];
}

- (void) _checkInput:(id)sender
{
    NSLog(@"%@", sender);
}

@end
