//
//  Breaker.swift
//  iBroke
//
//  Created by Vasja Pavlov
//  Copyright © 2020 Vasja Pavlov. All rights reserved.
//

import Foundation
import UIKit

protocol Breakable: class {
    func addSupportedType(type: UIView.Type)
    func demolish()
}

class Breaker
{
    private let referenceView: UIView
    private var motionManager: MotionManaging?
    private var animator: UIDynamicAnimator
    private var gravity: UIGravityBehavior?
    private let gravityMagnitude = 3.0
    private var affectedItems: [UIView] = []
    private var attachments: [DetachableAttachment] = []
    private let breakProbabilityPercentage: Int
    private var supportedTypes: [UIView.Type] = [UIButton.self,
                                                 UILabel.self,
                                                 UIImageView.self,
                                                 UITextView.self,
                                                 UITextField.self]
    init(with referenceView: UIView, breakProbabilityPercentage: Int = 100) {
        self.referenceView = referenceView
        animator = UIDynamicAnimator(referenceView: referenceView)
        self.breakProbabilityPercentage = breakProbabilityPercentage
        motionManager = MotionManager(with: self)
    }
    
    func addSupportedType(type: UIView.Type) {
        supportedTypes.append(type)
    }
    
    private func isTypeSupported(type: UIView.Type) -> Bool {
        for supportedType in supportedTypes {
            if type == supportedType {
                return true
            }
        }
        
        return false
    }
    
    private func getAffectedViews(currentView cur: UIView, depth: Int = 0) -> [UIView] {
        guard !cur.isHidden && cur.frame.width > 1 && cur.frame.height > 1 else {
            return []
        }
        
        cur.clipsToBounds = false
        
        if cur.isBreakable || isTypeSupported(type: type(of: cur)) {
            referenceView.bringSubviewToFront(cur)
            if Int.random(in: 0..<100) < breakProbabilityPercentage {
                return [cur]
            } else {
                return []
            }
        }
        
        var result: [UIView] = []
        for subview in cur.subviews {
            result += getAffectedViews(currentView: subview, depth: depth + 1)
        }
        
        return result
    }
    
    private func addAttachments() {
        for view in affectedItems {
            attachments.append(DetachableAttachment(view: view, referenceView: referenceView, animator: animator))
        }
    }
    
    private func setupBehaviors() {
        // gravity
        gravity = UIGravityBehavior(items: affectedItems)
        animator.addBehavior(gravity!)
        // collision
        let collision = UICollisionBehavior(items: affectedItems)
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionMode = .boundaries
        animator.addBehavior(collision)
    }
    
    private func reset() {
        motionManager?.stopMotionUpdates()
        animator.removeAllBehaviors()
    }
    
    deinit {
        motionManager?.stopMotionUpdates()
    }
}

extension Breaker: Breakable {
    func demolish() {
        // clear old state if any
        reset()
        motionManager?.startMotionUpdates()
        affectedItems = getAffectedViews(currentView: referenceView)
        addAttachments()
        setupBehaviors()
    }
}

extension Breaker: MotionManagerDelegate {
    func motionManager(_ motionManager: MotionManaging, didUpdate x: Double, y: Double) {
        
        gravity?.gravityDirection = CGVector(dx: gravityMagnitude * x,
                                            dy: gravityMagnitude * -y)
                
    }

}
