//
//  MessageView.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 14/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

public struct MessageContents {
    var title: String?
    var body: String?
    var image: UIImage?
    var backgroundColor: UIColor?
    
    public init(title: String?, body: String?, image: UIImage?, backgroundColor: UIColor?) {
        self.title = title
        self.body = body
        self.image = image
        self.backgroundColor = backgroundColor
    }
}

public struct MessageConfig {
    var autoDismiss: Bool
    var animationDuration: TimeInterval
    var duration: TimeInterval
    var dismissWhenTapped: Bool
    var dismissPrevius: Bool
    
    public init(autoDismiss: Bool = true, animationDuration: TimeInterval = 0.25, duration: TimeInterval = 2, dismissWhenTapped: Bool = true, dismissPrevius: Bool = true) {
        self.autoDismiss = autoDismiss
        self.animationDuration = animationDuration
        self.duration = duration
        self.dismissWhenTapped = dismissWhenTapped
        self.dismissPrevius = dismissPrevius
    }
}

public class MessageView: UIView {
    
    private var id: Double = Date().timeIntervalSince1970
    private var keyWindow: UIWindow? { return UIApplication.shared.keyWindow }
    private var statusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    private var isTapping: Bool = false
    private var isDismissing: Bool = false
    public var config: MessageConfig = MessageConfig()
    var tapped: () -> Void = {}
    
    // MARK: - Layout
    public lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy)
        label.lineHeight(height: 24)
        label.textColor = .white
        return label
    }()
    
    public lazy var body: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = .white
        label.lineHeight(height: 20)
        return label
    }()
    
    public lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var statusBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override var backgroundColor: UIColor? {
        didSet { statusBarView.backgroundColor = backgroundColor}
    }
    
    // MARK: Layout Configs
    public var padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    
    // MARK: - Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(content: MessageContents, config: MessageConfig? = nil, tapped: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.config = config ?? MessageManager.shared.config
        setupView()
        setupValues(content: content)
    }
    
    // MARK: - Actions
    @objc private func tappedAction(gesture: UIGestureRecognizer) {
        if gesture.state == .began { isTapping = true }
        guard gesture.state == .ended else { return }
        isTapping = false
        tapped()
        if config.dismissWhenTapped {
            dismiss()
        }
    }
    
    @objc private func panAction(gesture: UIPanGestureRecognizer) {
        guard gesture.velocity(in: self).y < -250 else { return }
        dismiss()
    }
}

// MARK: - Setups
extension MessageView {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedAction(gesture:))))
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(tappedAction(gesture:))))
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panAction(gesture:))))
        
        addSubview(statusBarView)
        addSubview(title)
        addSubview(body)
        addSubview(image)
        
        _ = image.center(centerYAnchor)
                 .leading(anchor: leadingAnchor, constant: padding.left)
                 .width(constant: 20)
                 .height(constant: 20)
        
        _ = title.top(anchor: topAnchor, constant: padding.top)
                 .leading(anchor: image.trailingAnchor, constant: 20)
                 .trailing(anchor: trailingAnchor, constant: -padding.right)
                 .height(constant: 24)
        
        _ = body.top(anchor: title.bottomAnchor)
                .leading(anchor: image.trailingAnchor, constant: 20)
                .trailing(anchor: trailingAnchor, constant: -padding.right)
                .bottom(anchor: bottomAnchor, constant: -padding.bottom)
                .height(constant: 20)
        
        _ = statusBarView.top(anchor: topAnchor, constant: -statusBarHeight)
                         .leading(anchor: leadingAnchor)
                         .trailing(anchor: trailingAnchor)
                         .bottom(anchor: bottomAnchor)
    }
    
    private func setupValues(content: MessageContents) {
        backgroundColor = content.backgroundColor
        statusBarView.backgroundColor = content.backgroundColor
        image.image = content.image
        title.text = content.title
        body.text = content.body
    }
}

public extension MessageView {
    func show() {
        if let current = MessageManager.shared.current, config.dismissPrevius {
            current.dismiss {
                self.showView()
            }
        } else {
            showView()
        }
    }
    
    func dismiss(completion: (() -> Void)? = nil) {
        if isDismissing { return }
        isDismissing = true
        dismissView(completion: completion)
    }
    
    private func showView() {
        guard let ruindows = keyWindow else { return }
        ruindows.addSubview(self)
        MessageManager.shared.messages.append(self)
        
        _ = leading(anchor: ruindows.leadingAnchor)
        _ = trailing(anchor: ruindows.trailingAnchor)
        _ = bottom(anchor: ruindows.topAnchor)
        
        ruindows.layoutIfNeeded()
        let height = frame.height + statusBarHeight
        
        guard let bottom = constraint(first: bottomAnchor, second: ruindows.topAnchor) else { return }
        UIView.transition(with: self, duration: config.animationDuration, options: .curveEaseOut, animations: {
            bottom.constant = height
            ruindows.layoutIfNeeded()
        }) { (_) in
            guard self.config.autoDismiss else { return }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.config.duration, execute: {
                self.dismiss()
            })
        }
    }
    
    private func dismissView(completion: (() -> Void)? = nil) {
        if isTapping { return }
        guard let ruindows = keyWindow else { return }
        let height = frame.height + UIApplication.shared.statusBarFrame.height
        guard let bottom = constraint(first: bottomAnchor, second: ruindows.topAnchor) else { return }
        UIView.transition(with: self, duration: config.animationDuration, options: .curveEaseIn, animations: {
            bottom.constant = -height
            ruindows.layoutIfNeeded()
        }) { (_) in
            self.removeFromSuperview()
            completion?()
            MessageManager.shared.messages.removeAll(where: { $0.id == self.id })
        }
    }
}
