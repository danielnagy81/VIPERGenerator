
#import <Foundation/Foundation.h>

#import "TestInteractor.h"
#import "TestView.h"
#import "TestProtocols.h"

@interface TestPresenter : NSObject <TestPresenterProtocol>

@property (nonatomic) TestInteractor *interactor;
@property (weak, nonatomic) id <TestViewProtocol> userInterface;
@property (weak, nonatomic) id <NewModuleRouterProtocol> router;

@end
