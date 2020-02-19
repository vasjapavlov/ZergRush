//
//  RedBall.swift
//  iBroke
//
//  Created by Vasja Pavlov
//  Copyright © 2020 Vasja Pavlov. All rights reserved.
//

import Foundation
import UIKit

class RedBall: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.width / 2.0
        backgroundColor = .red
    }
}
