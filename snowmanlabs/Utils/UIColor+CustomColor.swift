//  Created by douglas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

enum AssetsColor {
    case snowManBlue
    case backgroundColor
    case facebookBlue
    case snowManRed
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .snowManBlue:
            return UIColor(named: "snowManBlue")
        case .backgroundColor:
            return UIColor.init(red: 14/255, green: 19/255, blue: 23/255, alpha: 1)
        case .facebookBlue:
            return UIColor(named: "facebookBlue")
        case .snowManRed:
            return UIColor(named: "snowManRed")
        }
    }
}
