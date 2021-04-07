//
//  PDFViewController.swift
//  testeDownload
//
//  Created by Bruno Silva on 05/04/21.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    //MARK: - Variables
    var pdfView = PDFView()
    var pdfURL: URL!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
    }
    
    //MARK: - Setup
    private func setup() {
        view.addSubview(pdfView)
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
    }
}
