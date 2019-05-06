import UIKit
import Foundation
import SQLite
import SQLite3

let DBNAME = "funny.db"
let category = "category"
let story = "story"

class FunnyDB: NSObject {
    static let shared : FunnyDB = {
        let instance = FunnyDB()
        return instance
    }()

    var db: Connection!

    override init() {
        super.init()
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("funny").appendingPathExtension("db")
            db = try Connection(fileUrl.path)
        }catch{
            print("DB Error \(error)")
        }
    }
    func retrieveTopics(completion: @escaping (([Topic]) -> Void)) {
        do {
            var topics = [Topic]()
            for row in try db.prepare("SELECT * FROM category order by key_order asc") {
                topics.append(Topic.init(ctgId: Int(row[0] as! Int64),
                                         name: row[1] as! String,
                                         keyOrder: Int(row[2] as! Int64),
                                         follow: Int(row[3] as! Int64) == 0 ? false : true,
                                         imgName: row[4] as! String))
            }
            
            completion(topics)
        } catch {
            completion([Topic]())
        }
    }
    
    func retrieveTopicsForKey(completion: @escaping (([Int: Topic]) -> Void)) {
        do {
            var topics = [Int: Topic]()
            for row in try db.prepare("SELECT * FROM category order by key_order asc") {
                topics[Int(row[0] as! Int64)] = Topic.init(ctgId: Int(row[0] as! Int64),
                                         name: row[1] as! String,
                                         keyOrder: Int(row[2] as! Int64),
                                         follow: Int(row[3] as! Int64) == 0 ? false : true,
                                         imgName: row[4] as! String)
            }
            
            completion(topics)
        } catch {
            completion([Int: Topic]())
        }
    }
    
    func updateTopic(topic: Topic) {
        do {
            var follow = 0
            if topic.follow {
                follow = 1
            }
            let stt = try db.prepare("UPDATE category SET follow = \(follow) WHERE ctgID = \(topic.ctgId)")
            print(stt)
        } catch {
            print("update topic error")
        }
    }
    
    func getStorys(topic: Topic, completion: @escaping (([Story]) -> Void)) {
        do {
            var storys = [Story]()
            for row in try db.prepare("SELECT * FROM story WHERE CATEGORY_ID = \(topic.ctgId) AND IS_FAVORITE = \(0) AND IS_READ = \(0) ORDER BY DATE_CREATED") {
                let story = Story.init(id: Int(row[0] as! Int64),
                                       title: row[1] as! String,
                                       content: row[2] as! String,
                                       imgUrl: row[3] as? String,
                                       dateCreated: row[4] as? Double,
                                       dateFavorited: Int(row[5] as! Int64),
                                       ctgID: Int(row[6] as! Int64),
                                       favorite: Int(row[7] as! Int64),
                                       read: Int(row[8] as! Int64),
                                       numSeen: Int(row[9] as! Int64),
                                       dateReaded: Int(row[10] as! Int64))
                
                storys.append(story)
            }
            completion(storys)
        } catch {
            completion([Story]())
        }
    }
    
    func getStorysFavoriteByTopic(topic: Topic, completion: @escaping (([Story]) -> Void)) {
        do {
            var storysFavorite = [Story]()
            for row in try db.prepare("SELECT * FROM story WHERE CATEGORY_ID = \(topic.ctgId) AND IS_FAVORITE = \(1) ORDER BY DATE_FAVORITED DESC") {
                let story = Story.init(id: Int(row[0] as! Int64),
                                       title: row[1] as! String,
                                       content: row[2] as! String,
                                       imgUrl: row[3] as? String,
                                       dateCreated: row[4] as? Double,
                                       dateFavorited: Int(row[5] as! Int64),
                                       ctgID: Int(row[6] as! Int64),
                                       favorite: Int(row[7] as! Int64),
                                       read: Int(row[8] as! Int64),
                                       numSeen: Int(row[9] as! Int64),
                                       dateReaded: Int(row[10] as! Int64))
                
                storysFavorite.append(story)
            }
            completion(storysFavorite)
        } catch {
            completion([Story]())
        }
    }
    
    func getStorysFavorite(completion: @escaping (([Story]) -> Void)) {
        do {
            var storysFavorite = [Story]()
            for row in try db.prepare("SELECT * FROM story WHERE IS_FAVORITE = \(1) ORDER BY DATE_FAVORITED DESC") {
                let story = Story.init(id: Int(row[0] as! Int64),
                                       title: row[1] as! String,
                                       content: row[2] as! String,
                                       imgUrl: row[3] as? String,
                                       dateCreated: row[4] as? Double,
                                       dateFavorited: Int(row[5] as! Int64),
                                       ctgID: Int(row[6] as! Int64),
                                       favorite: Int(row[7] as! Int64),
                                       read: Int(row[8] as! Int64),
                                       numSeen: Int(row[9] as! Int64),
                                       dateReaded: Int(row[10] as! Int64))
                
                storysFavorite.append(story)
            }
            completion(storysFavorite)
        } catch {
            completion([Story]())
        }
    }
    
    func getStorysReaded(completion: @escaping (([Story]) -> Void)) {
        do {
            var storysReaded = [Story]()
            for row in try db.prepare("SELECT * FROM story WHERE IS_READ = \(1) ORDER BY DATE_READED DESC") {
                let story = Story.init(id: Int(row[0] as! Int64),
                                       title: row[1] as! String,
                                       content: row[2] as! String,
                                       imgUrl: row[3] as? String,
                                       dateCreated: row[4] as? Double,
                                       dateFavorited: Int(row[5] as! Int64),
                                       ctgID: Int(row[6] as! Int64),
                                       favorite: Int(row[7] as! Int64),
                                       read: Int(row[8] as! Int64),
                                       numSeen: Int(row[9] as! Int64),
                                       dateReaded: Int(row[10] as! Int64))
                
                storysReaded.append(story)
            }
            completion(storysReaded)
        } catch {
            completion([Story]())
        }
    }
    
    func updateStoryByFavorite(story: Story) {
        do {
            let currentTimeMilisicons = Int(Date().timeIntervalSince1970)
            let stt = try db.prepare("UPDATE story SET IS_FAVORITE = \(story.favorite), DATE_FAVORITED = \(currentTimeMilisicons) WHERE _id = \(story.id)")
//            let stt = try db.prepare("UPDATE story SET IS_FAVORITE = \(1), DATE_FAVORITED = \(currentTimeMilisicons) WHERE _id = \(story.id)")
            try stt.run()
            print("update favorite successfully at \(story.id)")
        } catch {
            print(error)
            print("update favorite error")
        }
    }
    
    func updateStoryByRead(story: Story) {
        do {
            let currentTimeMilisicons = Int(Date().timeIntervalSince1970)
            let stt = try db.prepare("UPDATE story SET IS_READ = \(story.read), DATE_READED = \(currentTimeMilisicons) WHERE _id = \(story.id)")
            try stt.run()
            print("update read successfully")
        } catch {
            print("update story error")
        }
    }
    
    func getStorysForFirstLaunch(completion: @escaping (([Story]) -> Void)) {
        do {
            var storysReaded = [Story]()
            for row in try db.prepare("SELECT * FROM story WHERE CATEGORY_ID = \(5)") {
                let story = Story.init(id: Int(row[0] as! Int64),
                                       title: row[1] as! String,
                                       content: row[2] as! String,
                                       imgUrl: row[3] as? String,
                                       dateCreated: row[4] as? Double,
                                       dateFavorited: Int(row[5] as! Int64),
                                       ctgID: Int(row[6] as! Int64),
                                       favorite: Int(row[7] as! Int64),
                                       read: Int(row[8] as! Int64),
                                       numSeen: Int(row[9] as! Int64),
                                       dateReaded: Int(row[10] as! Int64))
                
                storysReaded.append(story)
            }
            completion(storysReaded)
        } catch {
            completion([Story]())
        }
    }
}
