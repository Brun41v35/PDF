//
//  APIViewController.swift
//  testeDownload
//
//  Created by Bruno Silva on 06/04/21.
//

import UIKit

class APIViewController: UIViewController {
    
    //MARK: - Variables
    var file: URL?
    var pdfURL: URL? {
        didSet {
            file = pdfURL
            print("valor alterado pessu: \(file)")
            DispatchQueue.main.async {
                self.callView()
            }
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.callView()
        }
    }
    
    //MARK: - Functions
    func downloadPDF(url: String) {
        guard let url = URL(string: url) else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    private func callView() {
        let pdfViewController = PDFViewController()
        pdfViewController.pdfURL = file
        UIApplication.topViewController()?.present(pdfViewController, animated: true, completion: nil)
    }
}

//MARK: - Extension
extension APIViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdfURL = destinationURL
            print("Caminho PDF: \(pdfURL)")
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}

//MARK: - UIApplication Extension
extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}

