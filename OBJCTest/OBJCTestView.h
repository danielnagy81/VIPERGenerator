
#import <UIKit/UIKit.h>
#import "OBJCTestProtocols.h"

@interface OBJCTestView : UIViewController <OBJCTestViewProtocol>

@property (weak, nonatomic) id <OBJCTestPresenterProtocol> presenter;

@end
