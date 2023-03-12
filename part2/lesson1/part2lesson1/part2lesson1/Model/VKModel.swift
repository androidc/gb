//
//  VKModel.swift
//  part2lesson1
//
//  Created by on 15.02.2023.
//

import Foundation

struct Response: Codable {
    let response: [User]
}
struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let canAccessClosed: Bool
    let isClosed: Bool
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

struct ResponseFriendsRoot:Codable {
    let response: ResponseFriends
}

struct ResponseFriends: Codable {
    let count: Int
    let items: [Items]
}

struct Items: Codable {
    let id: Int
    let  trackCode, firstName, lastName: String
    let canAccessClosed, isClosed: Bool
    enum CodingKeys: String, CodingKey {
        case id
        case trackCode = "track_code"
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

struct ResponseGroupsRoot: Codable {
    let response: ResponseGroups
}

struct ResponseGroups: Codable {
    let count: Int
    let items: [ItemGroups]
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
}

struct ItemGroups: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let photo50, photo100, photo200: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type = "type"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

class NewsResponse: Decodable {
    let response: ResponseNews
}

class ResponseNews: Decodable {
    let items: [ResponseNewsItemsLight]
    let profiles: [ResponseNewsProfiles?]
    let groups: [ResponseNewsGroups]
}

//class Photo : Decodable {
//
//}

class Sizes: Decodable {
    var type: String = ""
    var url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let data = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try data.decode(String.self, forKey: .type)
        self.url = try data.decode(String.self, forKey: .url)
    }
    
}

class Photo: Decodable {
    var sizes: [Sizes] = []
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let data = try decoder.container(keyedBy: CodingKeys.self)
        self.sizes = try data.decode([Sizes].self, forKey: .sizes)
        
    }
}

class Attachments: Decodable {
    var  type: String = ""
    var  photo: Photo?
    
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let data = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try data.decode(String.self, forKey: .type)
        
        do {
            self.photo = try data.decode(Photo.self, forKey: .photo)
        } catch {
            self.photo = nil
        }
       
        
        
    }
}

class ResponseNewsItemsLight: Decodable {
   
    var source_id = 0
    var date = 0
    var comments_count = 0
    var likes_count = 0
    var reposts_count = 0
    var views_count = 0
    var text:String? = ""
    var attachments:[Attachments] = []
    var dateString = ""
    var photos:Photos?
    
    
     
    enum CodingKeys: String, CodingKey {
        case source_id
        case date
        case comments
        case likes
        case reposts
        case views
        case text
        case attachments
        case photos
      
    }
    
    
    
    enum CommentsKeys: String, CodingKey {
        case count
    }
    
    enum LikesKeys: String, CodingKey {
        case count
    }
    
    enum RepostsKeys: String, CodingKey {
        case count
    }
    
    enum ViewsKeys: String, CodingKey {
        case count
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.source_id = try values.decode(Int.self, forKey: .source_id)
        self.date = try values.decode(Int.self,forKey: .date)
        // получение строки из даты в Int
        let date = Date(timeIntervalSince1970:  TimeInterval(self.date))
        let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            let localDate = dateFormatter.string(from: date)
        self.dateString = localDate
        
        do {
            self.text = try values.decode(String.self,forKey: .text)
        } catch {
            self.text = ""
        }
      
        // get count of comments
        do {
            let comments = try values.nestedContainer(keyedBy: CommentsKeys.self, forKey: .comments)
            self.comments_count = try comments.decode(Int.self, forKey: .count)
        } catch {
            self.comments_count = 0
        }
       
       
        // get count of likes
        do {
            let likes = try values.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
            self.likes_count = try likes.decode(Int.self, forKey: .count)
        } catch {
            self.likes_count = 0
        }
       
        // get count of reposts
        do {
            let reposts = try values.nestedContainer(keyedBy: RepostsKeys.self, forKey: .reposts)
            self.reposts_count = try reposts.decode(Int.self, forKey: .count)
        } catch {
            self.reposts_count = 0
        }
        
        // get count of views
        do {
            let views = try values.nestedContainer(keyedBy: ViewsKeys.self, forKey: .views)
            self.views_count = try views.decode(Int.self, forKey: .count)
        } catch {
            self.views_count = 0
        }
        
        do {
            self.attachments = try values.decode([Attachments].self, forKey: .attachments)
        }
        catch {
            self.attachments = []
        }
        
        do {
            self.photos = try values.decode(Photos.self, forKey: .photos)
        } catch {
            self.photos = nil
        }
      
      
            
    }

}


class ResponseNewsProfiles : Decodable {
    var id = 0
    var screen_name = ""
    var photo_50 = ""
    var first_name = ""
    var last_name = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case screen_name
        case photo_50
        case first_name
        case last_name
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.screen_name = try values.decode(String.self, forKey: .screen_name)
        self.photo_50 = try values.decode(String.self, forKey: .photo_50)
        self.first_name = try values.decode(String.self, forKey: .first_name)
        self.last_name = try values.decode(String.self, forKey: .last_name)
    }
    
   
}
class ResponseNewsGroups: Decodable {
    var id = 0
    var name = ""
    var photo_50 = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo_50
      
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.photo_50 = try values.decode(String.self, forKey: .photo_50)
    }
    
}


class Photos: Decodable {
    var count = 0
    var items:[PhotoItems] = []
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try values.decode(Int.self, forKey: .count)
       
        do {
    
            self.items = try values.decode([PhotoItems].self, forKey: .items)
        }
        catch {
            self.items = []
        }
    }
    
    
}

class PhotoItems: Decodable {
    var likes_count = 0
    var comments_count = 0
    var reposts_count = 0
    
    var sizes:[PhotoSizes] = []
     
    enum CodingKeys: String, CodingKey {
        case sizes
        case likes
        case comments
        case reposts
    }
    
    enum LikesKeys: String, CodingKey {
        case count
    }
    
    enum CommentsKeys: String, CodingKey {
        case count
    }
    
    enum RepostsKeys: String, CodingKey {
        case count
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        do {
            self.sizes = try values.decode([PhotoSizes].self, forKey: .sizes)
        }
        catch {
            self.sizes = []
        }
        
        // get count of likes
        do {
            let likes = try values.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
            self.likes_count = try likes.decode(Int.self, forKey: .count)
        } catch {
            self.likes_count = 0
        }
        
        // get count of comments
        do {
            let comments = try values.nestedContainer(keyedBy: CommentsKeys.self, forKey: .comments)
            self.comments_count = try comments.decode(Int.self, forKey: .count)
        } catch {
            self.comments_count = 0
        }
       
       
       
        // get count of reposts
        do {
            let reposts = try values.nestedContainer(keyedBy: RepostsKeys.self, forKey: .reposts)
            self.reposts_count = try reposts.decode(Int.self, forKey: .count)
        } catch {
            self.reposts_count = 0
        }
        
        
        
    }
    
}

class PhotoSizes: Decodable {
    var  type: String = ""
    var  url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
    
   
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try values.decode(String.self, forKey: .type)
        self.url = try values.decode(String.self, forKey: .url)
    }
    
}
