
#import <Foundation/Foundation.h>

#import "OBJCTestInteractor.h"
#import "OBJCTestView.h"
#import "OBJCTestProtocols.h"

@interface OBJCTestPresenter : NSObject <OBJCTestPresenterProtocol>

@property (nonatomic) OBJCTestInteractor *interactor;
@property (weak, nonatomic) id <OBJCTestViewProtocol> userInterface;
@property (weak, nonatomic) id <NewModuleRouterProtocol> router;

@end
