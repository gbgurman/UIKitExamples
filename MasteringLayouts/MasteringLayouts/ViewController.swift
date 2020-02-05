//
//  ViewController.swift
//  MasteringLayouts
//
//  Created by trin on 5.02.2020.
//  Copyright © 2020 Pink Hat Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }


}

