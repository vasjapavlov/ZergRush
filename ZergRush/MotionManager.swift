//
//  MotionManager.swift
//  iBroke
//
//  Created by Vasja Pavlov
//  Copyright © 2020 Vasja Pavlov. All rights reserved.
//

import Foundation
import CoreMotion

protocol MotionManaging: class {
    func startMotionUpdates()
    func stopMotionUpdates()
}

protocol MotionManagerDelegate: class {
    func motionManager(_ motionManager: MotionManaging, didUpdate x: Double, y: Double)
}

class MotionManager: MotionManaging
{
    private let motionManager: CMMotionManager
    private weak var delegate: MotionManagerDelegate?
    private lazy var gyroQueue: OperationQueue = {
      var queue = OperationQueue()
      queue.name = "Gyro queue"
      queue.maxConcurrentOperationCount = 1
      return queue
    }()
    
    init(with delegate: MotionManagerDelegate) {
        motionManager = CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 0.01
        self.delegate = delegate
    }
    
    // Mark: Motion Managing
    func startMotionUpdates() {
        motionManager.startDeviceMotionUpdates(to: gyroQueue) { (data, error) in
            
            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self.delegate?.motionManager(self, didUpdate: data.gravity.x, y: data.gravity.y)
            }
        }
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}
