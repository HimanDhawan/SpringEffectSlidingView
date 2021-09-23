//
//  ViewController.swift
//  SlidingViewExample
//
//  Created by Himan Dhawan on 23/09/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var springEffectView: SpringEffectUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
}

extension ViewController {
    @IBAction func topButtonPressed(_ sender: UIButton) {
        self.springEffectView.slideTo(distance: 20)
    }
    
    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        self.springEffectView.slideTo(distance: 400)
    }
}
