//
//  FeedData.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

// Create global instance of the feed
var feed = FeedData()
let db = Firestore.firestore()
let storage = Storage.storage()

class Thread {
    var name: String
    var emoji: String
    var entries: [ThreadEntry]
    
    init(name: String, emoji: String) {
        self.name = name
        self.emoji = emoji
        self.entries = []
    }
    
    func addEntry(threadEntry: ThreadEntry) {
        entries.append(threadEntry)
        let entryID = UUID.init().uuidString
        
        let storageRef = storage.reference(withPath: "threads/\(entryID).jpg")
        guard let imageData = threadEntry.image.jpegData(compressionQuality: 0.75) else {return}
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        storageRef.putData(imageData)
        
        var ref: DocumentReference? = nil
        ref = db.collection("threads").addDocument(data: [
            "thread": self.name,
            "entry": entryID]) {err in
                if let err = err{
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
        }
    }
    
    func removeFirstEntry() -> ThreadEntry? {
        if entries.count > 0 {
            return entries.removeFirst()
        }
        return nil
    }
    
    func unreadCount() -> Int {
        return entries.count
    }
}

struct ThreadEntry {
    var username: String
    var image: UIImage
}

struct Post {
    var location: String
    var image: UIImage?
    var user: String
    var caption: String
    var date: Date
}

class FeedData {
    var username = "YOUR USERNAME"
    
    var threads: [Thread] = [
        Thread(name: "memes", emoji: "😂"),
        Thread(name: "dogs", emoji: "🐶"),
        Thread(name: "fashion", emoji: "🕶"),
        Thread(name: "fam", emoji: "👨‍👩‍👧‍👦"),
        Thread(name: "tech", emoji: "💻"),
        Thread(name: "eats", emoji: "🍱"),
    ]

    // Adds dummy posts to the Feed
    var posts: [Post] = [
        Post(location: "New York City", image: UIImage(named: "skyline"), user: "nyerasi", caption: "Concrete jungle, wet dreams tomato 🍅 —Alicia Keys", date: Date()),
        Post(location: "Memorial Stadium", image: UIImage(named: "garbers"), user: "rjpimentel", caption: "Last Cal Football game of senior year!", date: Date()),
        Post(location: "Soda Hall", image: UIImage(named: "soda"), user: "chromadrive", caption: "Find your happy place 💻", date: Date())
    ]
    
    // Adds dummy data to each thread
    init() {
        for thread in threads {
            let entry = ThreadEntry(username: self.username, image: UIImage(named: "garbers")!)
            thread.addEntry(threadEntry: entry)
        }
    }
    
    func fetch() {
        db.collection("posts").getDocuments() {(querySnapshot, err) in
        if let err = err {
            print("Error gtting documents: \(err)")
        } else {
            
            for document in querySnapshot!.documents {
                let dates = document.data()["date"] as! Timestamp
                let id = document.data()["post"] as! String
                let locations = document.data()["location"] as! String
                let users = document.data()["user"] as! String
                let captions = document.data()["caption"] as! String
                print("id: " + id)
                //print("locations" + locations)
                
                let newdate = Date(timeIntervalSince1970: TimeInterval(dates.seconds))
                let storageRef = storage.reference(withPath:"posts/\(id).jpg")
                storageRef.getData(maxSize: 4*1024*1024) {(data, error) in
                    if error != nil {
                        print("this error")
                    }
                    if let data = data {
                        let newimage = UIImage(data: data)

                        self.posts.append(Post(location: locations, image: newimage, user: users, caption: captions, date: newdate))
                        }
                    }
                }
            }
        }
        
        //db.collection("threads")
    }
    
    
    
    func addPost(post: Post) {
        posts.append(post)
        print("call ssssss")
        let postID = UUID.init().uuidString
        
        let storageRef = storage.reference(withPath: "posts/\(postID).jpg")
        guard let imageData = post.image!.jpegData(compressionQuality: 0.75) else {return}
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        storageRef.putData(imageData)
        
        var ref: DocumentReference? = nil
        ref = db.collection("posts").addDocument(data: [
            "post": postID,
            "location": post.location,
            "user": post.user,
            "caption": post.caption,
            "date": post.date]) {err in
                if let err = err{
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
        }
        print("call ended")
    }
    
    // Optional: Implement adding new threads!
    func addThread(thread: Thread) {
        threads.append(thread)
    }
}




// write firebase functions here (pushing, pulling, etc.) 
