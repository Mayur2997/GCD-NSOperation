//
//  NSOperationViewController.swift
//  ConcurrencyDemo
//
//  Created by iMac on 19/11/19.
//  Copyright © 2019 Hossam Ghareeb. All rights reserved.
//

import UIKit

class NSOperationViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    var queue = OperationQueue()
    
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
    @IBAction func didClickOnStart(_ sender: Any) {
        setupUI()
        //queue = OperationQueue()
        
        let operation1 = BlockOperation(block: {
            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
            OperationQueue.main.addOperation {
                self.imageView1.image = img1
            }
        })
        
        operation1.completionBlock = {
            print("Operation 1 completed, cancelled:\(operation1.isCancelled)")
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
            OperationQueue.main.addOperation {
                self.imageView2.image = img2
            }
        })
        operation2.addDependency(operation1)
        operation2.completionBlock = {
            print("Operation 2 completed, cancelled:\(operation2.isCancelled)")
        }
        queue.addOperation(operation2)
        
        
        let operation3 = BlockOperation(block: {
            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
            OperationQueue.main.addOperation({
                self.imageView3.image = img3
            })
        })
        operation3.addDependency(operation2)
        
        operation3.completionBlock = {
            print("Operation 3 completed, cancelled:\(operation3.isCancelled)")
        }
        queue.addOperation(operation3)
        
        let operation4 = BlockOperation(block: {
            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
            OperationQueue.main.addOperation{
                self.imageView4.image = img4
            }
        })
        
        operation4.completionBlock = {
            print("Operation 4 completed, cancelled:\(operation4.isCancelled)")
        }
        queue.addOperation(operation4)
        
    }
    
    @IBAction func didClickOnCancel(_ sender: Any) {
        self.queue.cancelAllOperations()
    }
    
}
