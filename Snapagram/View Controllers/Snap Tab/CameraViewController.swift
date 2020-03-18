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
    var globalPic: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .camera
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var Picture: UIImageView!
    
    @IBOutlet weak var ButtonText: UIButton!
    
    @IBAction func Post(_ sender: UIButton) {
        self.Picture.image = nil
        self.ButtonText.setTitle("", for: UIControl.State.normal)
        performSegue(withIdentifier: "toPost", sender: globalPic)
    }
    @IBAction func UseCamera(_ sender: UIButton) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let picture = info[.originalImage] as? UIImage {
            //Use image
            self.globalPic = picture
            self.Picture.image = picture
            self.ButtonText.setTitle("Post🥳", for: UIControl.State.normal)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PostViewController, let image = sender as? UIImage {
            dest.imageToPost = image
        }
    }
}
