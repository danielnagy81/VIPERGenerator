
#import <UIKit/UIKit.h>
#import "TestProtocols.h"

@interface TestView : UIViewController <TestViewProtocol>

@property (weak, nonatomic) id <TestPresenterProtocol> presenter;

@end
