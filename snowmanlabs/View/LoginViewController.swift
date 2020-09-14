//  Created by douglas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LoginImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Facebook", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor.appColor(.facebookBlue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register with Facebook", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor.appColor(.facebookBlue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.completion = { state in
            switch state {
            case .failure(let error):
                MessageView(content: MessageContents(title: "Error",body: error, image: nil, backgroundColor: UIColor.appColor(.snowManRed))).show()
                break
            case .success:
                Router.home()
                break
            case .successRegister:
                Router.home()
                break
            case .failureRegister(let error):
                MessageView(content: MessageContents(title: "Error",body: error, image: nil, backgroundColor: UIColor.appColor(.snowManRed))).show()
                
                break
            }
        }
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func loginButtonPressed() {
        self.loginViewModel.login(view: self)
    }
    
    @objc private func registerButtonPressed() {
        self.loginViewModel.signup(view: self)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.appColor(.backgroundColor)
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
                                     imageView.heightAnchor.constraint(equalToConstant: 200),
                                     imageView.widthAnchor.constraint(equalToConstant: 300)
            
        ])
        
        view.addSubview(signButton)
        
        NSLayoutConstraint.activate([signButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                                     signButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     signButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     signButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([registerButton.topAnchor.constraint(equalTo: signButton.bottomAnchor, constant: 20),
                                     registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
