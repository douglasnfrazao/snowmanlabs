//  Created by douglas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

class Router {
    static func login(completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }) { (_) in
            completion?()
        }
    }
    
    static func home(completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = UINavigationController(rootViewController: TabBarViewController())
        }) { (_) in
            completion?()
        }
    }
    
    static func addSpotModal(view: UIViewController) {
        let modalViewController = AddSpotViewController()
        modalViewController.modalPresentationStyle = .overCurrentContext
        view.present(modalViewController, animated: true, completion: nil)
    }
    
}
