//
//  main.swift
//  VIPERGenerator
//
//  Created by Daniel_Nagy on 14/05/15.
//  Copyright (c) 2015 NDani. All rights reserved.
//

import Foundation

class OBJCVIPERGenerator {
    
    let fileManager = NSFileManager()
    let moduleName: String
    let moduleDirectory: String
    
    init() {
        if Process.arguments.count != 2 {
            fatalError("Too many/not enough arguments given!")
        }
        moduleName = Process.arguments[1]
        moduleDirectory = fileManager.currentDirectoryPath + "/\(moduleName)"
    }
    
    func generateVIPERModules() {
        generateDirectory()
        generateProtocols()
        generateRouting()
        generateView()
        generatePresenter()
        generateInteractor()
    }
    
    private func generateDirectory() {
        let error = NSErrorPointer()
        
        if fileManager.createDirectoryAtPath(moduleDirectory, withIntermediateDirectories: true, attributes: nil, error: error) {
            println("\nDirectory successfully created!")
        } else {
            fatalError(error.debugDescription)
        }
    }
    
    private func generateProtocols() {
        let protocolFileContent = "\n@protocol \(moduleName)ViewProtocol <NSObject>\n\n@end\n\n@protocol \(moduleName)PresenterProtocol <NSObject>\n\n@end\n\n@protocol NewModuleRouterProtocol <NSObject>\n\n@end\n"
        saveString(protocolFileContent, withName: "Protocols.h")
    }
    
    private func generateRouting() {
        generateRoutingHeaderFile()
        generateRoutingImplementationFile()
    }
    
    private func generateRoutingHeaderFile() {
        let routingHeaderContentFile  = "\n#import <UIKit/UIKit.h>\n#import \"\(moduleName)Protocols.h\"\n\n@interface \(moduleName)Routing : NSObject <NewModuleRouterProtocol>\n\n- (UIViewController *)viewController;\n\n@end"
        saveString(routingHeaderContentFile, withName: "Routing.h")
    }
    
    private func generateRoutingImplementationFile() {
        let routingImplementationFileContent = "\n#import \"\(moduleName)Routing.h\"\n#import \"\(moduleName)Presenter.h\"\n#import \"\(moduleName)View.h\"\n#import \"\(moduleName)Interactor.h\"\n\n@implementation \(moduleName)Routing {\n\n    \(moduleName)Presenter *_presenter;\n    \(moduleName)View *_userInterface;\n}\n\n- (instancetype)init {\n    self = [super init];\n\n    if (self) {\n        [self setupPresenter];\n    }\n    return self;\n}\n\n- (void)setupPresenter {\n    _presenter = [[\(moduleName)Presenter alloc] init];\n    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@\"Main\" bundle:nil];\n    \(moduleName)View *view = [storyboard instantiateViewControllerWithIdentifier:@\"\(moduleName)ViewController\"];\n    _userInterface = view;\n    view.presenter = _presenter;\n    \(moduleName)Interactor *interactor = [[\(moduleName)Interactor alloc] init];\n    _presenter.userInterface = view;\n    _presenter.interactor = interactor;\n    _presenter.router = self;\n}\n\n- (UIViewController *)viewController {\n    return (UIViewController *)_userInterface;\n}\n\n@end\n"
        saveString(routingImplementationFileContent, withName: "Routing.m")
    }
    
    private func generateView() {
        generateViewHeader()
        generateViewImplementation()
    }
    
    private func generateViewHeader() {
        let viewHeaderFileContent = "\n#import <UIKit/UIKit.h>\n#import \"\(moduleName)Protocols.h\"\n\n@interface \(moduleName)View : UIViewController <\(moduleName)Protocol>\n\n@property (weak, nonatomic) id <\(moduleName)PresenterProtocol> presenter;\n\n@end\n"
        saveString(viewHeaderFileContent, withName: "View.h")
    }
    
    private func generateViewImplementation() {
        let viewImplementationFileContent = "\n#import \"\(moduleName)View.h\"\n\n@implementation \(moduleName)View\n\n@end"
        saveString(viewImplementationFileContent, withName: "View.m")
        
    }
    
    private func generatePresenter() {
        generatePresenterHeader()
        generatePresenterImplementation()
    }
    
    private func generatePresenterHeader() {
        let presenterHeaderFileContent = "\n#import <Foundation/Foundation.h>\n\n#import \"\(moduleName)Interactor.h\"\n#import \"\(moduleName)View.h\"\n#import \"\(moduleName)Protocols.h\"\n\n@interface \(moduleName)Presenter : NSObject <\(moduleName)PresenterProtocol>\n\n@property (nonatomic) \(moduleName)Interactor *interactor;\n@property (weak, nonatomic) id <\(moduleName)Protocol> userInterface;\n@property (weak, nonatomic) id <NewModuleRouterProtocol> router;\n\n@end\n"
        saveString(presenterHeaderFileContent, withName: "Presenter.h")
    }
    
    private func generatePresenterImplementation() {
        let presenterImplementationFileContent = "\n#import \"\(moduleName)Presenter.h\"\n\n@implementation \(moduleName)Presenter\n\n@end\n"
        saveString(presenterImplementationFileContent, withName: "Presenter.m")
    }
    
    private func generateInteractor() {
        generateInteractorHeader()
        generateInteractorImplementation()
    }
    
    private func generateInteractorHeader() {
        let interactorHeaderFileContent = "\n#import <Foundation/Foundation.h>\n\n@interface \(moduleName)Interactor : NSObject\n\n@end\n"
        saveString(interactorHeaderFileContent, withName: "Interactor.h")
    }
    
    private func generateInteractorImplementation() {
        let interactorImplementationFileContent = "\n#import \"\(moduleName)Interactor.h\"\n\n@implementation \(moduleName)Interactor\n\n@end\n"
        saveString(interactorImplementationFileContent, withName: "Interactor.m")
    }
    
    private func saveString(string: String, withName name: String) {
        let error = NSErrorPointer()
        
        if string.writeToFile(moduleDirectory + "/\(moduleName)\(name)", atomically: true, encoding: NSUTF8StringEncoding, error: error) {
            println("\(name) file successfully generated!")
        } else {
            fatalError(error.debugDescription)
        }
    }
}

let generator = OBJCVIPERGenerator()
generator.generateVIPERModules()

