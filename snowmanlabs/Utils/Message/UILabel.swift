//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

public extension UILabel {
    
    func lineHeight(height: CGFloat, alignment: NSTextAlignment = .left) {
        let text = self.text ?? ""
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = height
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count))
        attributedText = attrString
        textAlignment = alignment
    }
    
    func lineHeightWithAttributedText(height: CGFloat, alignment: NSTextAlignment = .left) {
        guard let text = self.attributedText else { return }
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = height
        
        let attrString = NSMutableAttributedString(attributedString: text)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: text.length))
        attributedText = attrString
        textAlignment = alignment
    }
}
