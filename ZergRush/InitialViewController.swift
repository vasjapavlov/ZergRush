//
//  InitialViewController.swift
//  iBroke
//
//  Created by Vasja Pavlov on 2020-02-17.
//  Copyright © 2020 Vasja Pavlov. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func onDemolish(_ sender: Any) {
        performSegue(withIdentifier: "toDemolishSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let breakViewController = segue.destination as? ViewController else { return }
        breakViewController.breakPercentage = Int(slider.value)
    }
}
