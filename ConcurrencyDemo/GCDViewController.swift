//
//  ViewController.swift
//  ConcurrencyDemo
//
//  Created by iMac on 18/11/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

// MARK:- Variable
let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
                 "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
                 "https://wonderfulengineering.com/wp-content/uploads/2016/01/Switzerland-wallpaper-8.jpg",
                 "https://wonderfulengineering.com/wp-content/uploads/2016/01/Switzerland-wallpaper-5.jpg"]

// MARK:-  Downloader Class to download Images
class Downloader {
    class func downloadImageWithURL(url:String) -> UIImage! {
        let data = NSData(contentsOf: NSURL(string: url)! as URL)
        return UIImage(data: data! as Data)
    }
}

// MARK:- ViewController Class
class GCDViewController: UIViewController {

    // MARK:- IBOutlets
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView! 
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    // MARK: Other Method
    func setupUI() {
        imageView1.image = UIImage(named: "imageloading")
        imageView2.image = UIImage(named: "imageloading")
        imageView3.image = UIImage(named: "imageloading")
        imageView4.image = UIImage(named: "imageloading")
    }
 
    // MARK:- IBAction 
    @IBAction func didClickOnStart(sender: AnyObject) {
        setupUI()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
            DispatchQueue.main.async {
                self.imageView1.image = img1
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
            DispatchQueue.main.async {
                self.imageView2.image = img2
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
            DispatchQueue.main.async {
                self.imageView3.image = img3
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
            DispatchQueue.main.async {
                self.imageView4.image = img4
            }
        }
    } 
}

