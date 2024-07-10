//
//  SemaphoreVC.swift
//  TestUIKit
//
//  Created by o9tech on 10/07/2024.
//

import UIKit

class SemaphoreVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let urls = [
        URL(string: "https://via.placeholder.com/150/92c952")!,
        URL(string: "https://via.placeholder.com/150/771796")!,
        URL(string: "https://via.placeholder.com/150/24f355")!,
        URL(string: "https://via.placeholder.com/150/d32776")!,
        URL(string: "https://via.placeholder.com/150/f66b97")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
    }

    func loadImages() {
        for url in self.urls {
            DispatchQueue.global().async { self.downloadImage(from: url) }
        }
    }

    func downloadImage(from url: URL) {
        print("Starting download from \(url)")
        guard let imageData = try? Data(contentsOf: url) else { return }
        let image = UIImage(data: imageData)
        DispatchQueue.main.async { self.imageView.image = image }
        print("Finished download from \(url)")
    }
}
