//
//  ViewController.swift
//  Counter
//
//  Created by Anastasya Bochkovskaya on 06/12/2024.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var ButtonCounter: UIButton!
    @IBOutlet weak var LabelCounter: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchedbutton(_ sender: Any) {
        print("Нажатие")
        howmuch += 1
        LabelCounter.text = String(howmuch)
    }
    

}
private var howmuch: Int = 0

