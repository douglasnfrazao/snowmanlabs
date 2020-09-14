//
//  AddSpotViewController.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 14/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

final class AddSpotViewController: UIViewController {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.setTitle("Close", for: .normal)
        button.tintColor = UIColor.appColor(.snowManBlue)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"        
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.setTitle("Save", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.appColor(.snowManBlue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(saveSpot), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
        setupView()
    }
    
    private func setupView() {
        
        view.addSubview(contentView)
        NSLayoutConstraint.activate([contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        contentView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                                     closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                                     closeButton.widthAnchor.constraint(equalToConstant: 40),
                                     closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        contentView.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([nameTextField.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20),
                                     nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                                     nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                                     nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(categoryTextField)
        
        NSLayoutConstraint.activate([categoryTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
                                     categoryTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                                     categoryTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                                     categoryTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([saveButton.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 20),
                                     saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                                     saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                                     saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        contentView.addGestureRecognizer(tap)
    }
    
    @objc private func closeModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveSpot() {
        //dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
