//
//  ViewController.swift
//  testeDownload
//
//  Created by Bruno Silva on 05/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variables
    let viewModel = ViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func openPDF(_ sender: UIButton) {
        let url = "https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
        viewModel.sendInformationToAPI(url: url)
    }
}


