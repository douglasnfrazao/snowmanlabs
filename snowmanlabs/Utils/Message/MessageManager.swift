//
//  MessageManager.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 14/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

public class MessageManager {
    
    public static let shared: MessageManager = MessageManager()
    
    var config: MessageConfig = MessageConfig()
    var messages: [MessageView] = []
    var current: MessageView? { return messages.last }
    
    init() {}
    
    public func dismissCurrent() {
        current?.dismiss()
    }
    public func dismissAll() {
        messages.forEach({ $0.dismiss() })
    }
}
