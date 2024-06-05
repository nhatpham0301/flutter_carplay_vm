import Foundation

class FCPMapListHeaderModel {
    private var title: String?
    private var titleTime: String?
    private var distance: String?
    private var time: String?

    init(obj: [String: Any]) {
        title = obj["title"] as? String
        titleTime = obj["titleTime"] as? String
        distance = obj["distance"] as? String
        time = obj["time"] as? String
    }
    
    func getTitle() -> String? {
        return title
    }
    
    func getTitleTime() -> String? {
        return titleTime
    }
    
    func getDistance() -> String? {
        return distance
    }
    
    func getTime() -> String? {
        return time
    }
}
