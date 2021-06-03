import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assamblyBuilder: AssemblyBuilderProtocol? { get set }
}
protocol RouterProtocol {
    func initialViewController()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assamblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assamblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assamblyBuilder = assamblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assamblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    
}
