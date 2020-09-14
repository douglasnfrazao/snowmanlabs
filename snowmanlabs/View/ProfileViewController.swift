//  Created by douglas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor.appColor(.snowManRed)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        return button
    }()
    
    private let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let user = profileViewModel.getProfile()
        photoImageView.downloaded(from: user.photo)
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func setupView() {
        view.backgroundColor = UIColor.appColor(.backgroundColor)
        
        view.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     photoImageView.widthAnchor.constraint(equalToConstant: 80),
                                     photoImageView.heightAnchor.constraint(equalToConstant: 80)])
        
        
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
                                     nameLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                                     emailLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
                                     emailLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([logoutButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
                                     logoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     logoutButton.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    @objc private func logoutPressed() {
        profileViewModel.logout()
    }
    
}
