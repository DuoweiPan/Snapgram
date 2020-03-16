//
//  CameraViewController.swift
//  Snapagram
//
//  Created by RJ Pimentel on 3/11/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePickerController = UIImagePickerController()

    var data = FeedData()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .camera
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func UseCamera(_ sender: UIButton) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let picture = info[.originalImage] as? UIImage {
            //Use image
            var newPost = Post(location: "Berkeley", image: picture, user: "jeffery", caption: "hello", date: Date())
            data.addPost(post: newPost)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
