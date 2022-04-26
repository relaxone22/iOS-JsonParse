//
//  DetailViewController.swift
//  JsonParse
//
//  Created by TDCC_IFD on 2022/4/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    var broker: Broker?
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = broker?.billNum
        content.text = broker?.total
    }
    

    

}
