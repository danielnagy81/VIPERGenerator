
#import "OBJCTestRouting.h"
#import "OBJCTestPresenter.h"
#import "OBJCTestView.h"
#import "OBJCTestInteractor.h"

@implementation OBJCTestRouting {

    OBJCTestPresenter *_presenter;
    OBJCTestView *_userInterface;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        [self setupRouter];
    }
    return self;
}

- (void)setupRouter {
    _presenter = [[OBJCTestPresenter alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OBJCTestView *view = [storyboard instantiateViewControllerWithIdentifier:@"OBJCTestViewController"];
    _userInterface = view;
    view.presenter = _presenter;
    OBJCTestInteractor *interactor = [[OBJCTestInteractor alloc] init];
    _presenter.userInterface = view;
    _presenter.interactor = interactor;
    _presenter.router = self;
}

- (UIViewController *)viewController {
    return (UIViewController *)_userInterface;
}

@end
