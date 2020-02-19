//
//  UIViewExtensions.swift
//  iBroke
//
//  Created by Vasja Pavlov on 2020-02-05.
//  Copyright © 2020 Vasja Pavlov. All rights reserved.
//

import UIKit

extension UIView {
    var topLeft: CGPoint {
        return CGPoint(x: 0, y: 0)
    }
    
    var topRight: CGPoint {
        return CGPoint(x: frame.width, y: 0)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: 0, y: frame.height)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: frame.width, y: frame.height)
    }
}

extension UIView {
    private static var _isBreakable = [String:Bool]()
    
    var isBreakable: Bool {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIView._isBreakable[tmpAddress] ?? false
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIView._isBreakable[tmpAddress] = newValue
        }
    }
}
