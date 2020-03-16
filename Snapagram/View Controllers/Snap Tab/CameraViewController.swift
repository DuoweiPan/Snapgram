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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .camera
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var Picture: UIImageView!
    
    @IBOutlet weak var ButtonText: UIButton!
    
    @IBAction func Post(_ sender: UIButton) {
    }
    @IBAction func UseCamera(_ sender: UIButton) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let picture = info[.originalImage] as? UIImage {
            //Use image
            Picture.image = picture
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
