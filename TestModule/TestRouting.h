
#import <UIKit/UIKit.h>
#import "TestProtocols.h"

@interface TestRouting : NSObject <NewModuleRouterProtocol>

- (UIViewController *)viewController;

@end