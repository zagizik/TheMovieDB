import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assamblyBuilder: AssemblyBuilderProtocol? { get set }
}
protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(movie: Movie?, poster: UIImage)
    func popToRoot()
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
    
    func showDetail(movie: Movie?, poster: UIImage) {
        if let navigationController = navigationController {
            guard let detailViewController = assamblyBuilder?.createDetailModule(movie: movie, poster: poster, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
