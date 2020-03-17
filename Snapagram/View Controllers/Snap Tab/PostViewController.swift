//
//  PostViewController.swift
//  Snapagram
//
//  Created by Jeffery Chen on 3/16/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UICollectionViewDataSource {
    
    var imageToPost: UIImage?
    var feedData: FeedData!
    
    @IBOutlet weak var ThreadCollectionView: UICollectionView!
    @IBOutlet weak var imageToDisplay: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageToDisplay.image = imageToPost
        ThreadCollectionView.dataSource = self
        self.feedData = FeedData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedData.threads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let thread = feedData.threads[index]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThreadPostCell", for: indexPath) as? ThreadPostCell {
            cell.ChooseButton.setTitle(thread.emoji, for: UIControl.State.normal)
            cell.ThreadName.text = thread.name
            return cell
        }
        return UICollectionViewCell()
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
