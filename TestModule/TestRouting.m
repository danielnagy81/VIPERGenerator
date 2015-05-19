
#import "TestRouting.h"
#import "TestPresenter.h"
#import "TestView.h"
#import "TestInteractor.h"

@implementation TestRouting {

    TestPresenter *_presenter;
    TestView *_userInterface;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        [self setupPresenter];
    }
    return self;
}

- (void)setupPresenter {
    _presenter = [[TestPresenter alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TestView *view = [storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
    _userInterface = view;
    view.presenter = _presenter;
    TestInteractor *interactor = [[TestInteractor alloc] init];
    _presenter.userInterface = view;
    _presenter.interactor = interactor;
    _presenter.router = self;
}

- (UIViewController *)viewController {
    return (UIViewController *)_userInterface;
}

@end
