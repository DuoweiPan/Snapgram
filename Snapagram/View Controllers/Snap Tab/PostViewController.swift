//
//  PostViewController.swift
//  Snapagram
//
//  Created by Jeffery Chen on 3/16/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    var imageToPost: UIImage?
    var selectedThread: Thread?
    var selectedCell: UICollectionViewCell?
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var ThreadCollectionView: UICollectionView!
    @IBOutlet weak var imageToDisplay: UIImageView!
    
    @IBAction func createThread(_ sender: UIButton) {
        if let thread = selectedThread {
            thread.addEntry(threadEntry: ThreadEntry(username: feed.username, image: imageToPost!))
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func createPost(_ sender: UIButton) {
        let p =  Post(location: location.text!, image: imageToPost, user: "jeff", caption: caption.text!, date: Date())
        feed.addPost(post: p)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageToDisplay.image = imageToPost
        ThreadCollectionView.dataSource = self
        ThreadCollectionView.delegate = self
        caption.placeholder = "Caption:"
        location.placeholder = "Location:"
        self.caption.delegate = self
        self.location.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.threads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let thread = feed.threads[index]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThreadPostCell", for: indexPath) as? ThreadPostCell {
            cell.Emoji.text = thread.emoji
            cell.ThreadName.text = thread.name
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // segue to preview controller with selected thread
        // if (selectFlag) {
            let chosenThread = feed.threads[indexPath.item]
            selectedThread = chosenThread
            let cell = collectionView.cellForItem(at: indexPath)
            if let cur = selectedCell {
                cur.backgroundColor = UIColor.white
            }
            selectedCell = cell
            selectedCell?.backgroundColor = UIColor.blue
           // selectFlag = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
