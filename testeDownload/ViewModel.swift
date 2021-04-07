//
//  ViewModel.swift
//  testeDownload
//
//  Created by Bruno Silva on 06/04/21.
//

import Foundation

class ViewModel {
    
    //MARK: - Functions
    func sendInformationToAPI(url: String) {
        let api = APIViewController()
        api.downloadPDF(url: url)
    }
}

