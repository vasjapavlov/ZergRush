//
//  DetachableAttachment.swift
//  iBroke
//
//  Created by Vasja Pavlov
//  Copyright © 2020 Vasja Pavlov. All rights reserved.
//

import Foundation
import UIKit

class DetachableAttachment {
    private var leftAttachment: UIAttachmentBehavior!
    private var rightAttachment: UIAttachmentBehavior!
    private let view: UIView
    private let referenceView: UIView
    private let animator: UIDynamicAnimator
    
    init(view: UIView, referenceView: UIView, animator: UIDynamicAnimator) {
        self.view = view
        self.referenceView = referenceView
        self.animator = animator
        attachLeftAnchor()
        attachRightAnchor()
        let detachLeftDelay = Int.random(in: 1..<20)
        let detachRightDelay = Int.random(in: 1..<20)

        DispatchQueue.main.asyncAfter(deadline: .now() + Double(detachLeftDelay)) {
            self.animator.removeBehavior(self.leftAttachment!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(detachRightDelay)) {
            self.animator.removeBehavior(self.rightAttachment!)
                }
    }
    
    private func attachLeftAnchor() {
        let width = view.frame.width
        let height = view.frame.height
        var corner: CGPoint
        var offset: UIOffset
        if Bool.random() {
            corner = view.topLeft
            offset = UIOffset(horizontal: -width / 2, vertical: -height / 2)
        } else {
            corner = view.bottomLeft
            offset = UIOffset(horizontal: -width / 2, vertical: height / 2)
        }
        
        let actualPoint = referenceView.convert(corner, from: view)
        leftAttachment = UIAttachmentBehavior(item: view, offsetFromCenter: offset, attachedToAnchor: actualPoint)
        leftAttachment.damping = 0.1
//        leftAttachment.frequency = 50
        animator.addBehavior(leftAttachment)
    }
    
    private func attachRightAnchor() {
        let width = view.frame.width
        let height = view.frame.height
        var corner: CGPoint
        var offset: UIOffset
        if Bool.random() {
            corner = view.topRight
            offset = UIOffset(horizontal: width / 2, vertical: -height / 2)
        } else {
            corner = view.bottomRight
            offset = UIOffset(horizontal: width / 2, vertical: height / 2)
        }
        
        let actualPoint = referenceView.convert(corner, from: view)
        rightAttachment = UIAttachmentBehavior(item: view, offsetFromCenter: offset, attachedToAnchor: actualPoint)
        animator.addBehavior(rightAttachment)
    }
}
