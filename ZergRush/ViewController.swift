//
//  ViewController.swift
//  iBroke
//
//  Created by Vasja Pavlov on 2019-04-07.
//  Copyright © 2019 Vasja Pavlov. All rights reserved.
//

import UIKit

class AppCrasher {
    func crashIt(views: [UIView]) {
        
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var breakPercentage: Int = 0
    @IBOutlet weak var smallTableView: UITableView!
    @IBOutlet weak var largeTableView: UITableView!
    var breaker: Breakable!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.breaker = Breaker(with: self.view, breakProbabilityPercentage: self.breakPercentage)
            self.breaker?.addSupportedType(type: RedBall.self)
            self.breaker.demolish()
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == smallTableView {
            let cell = smallTableView.dequeueReusableCell(withIdentifier: SmallCell.cellIdentifier) as! SmallCell
            
            cell.firstLabel.text = "Code #\(indexPath.row)"
            return cell
        } else {
            let cell = largeTableView.dequeueReusableCell(withIdentifier: LargeCell.cellIdentifier) as! LargeCell
            cell.codeLabel.text = "Code #\(indexPath.row)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == smallTableView {
            return 40
        } else {
            return 60
        }
    }
}

