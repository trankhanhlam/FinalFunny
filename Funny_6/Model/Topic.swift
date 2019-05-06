class Topic {
    var ctgId: Int
    var name: String
    var keyOrder: Int
    var follow: Bool
    var imgName: String
    
    init(ctgId: Int, name: String, keyOrder: Int, follow: Bool, imgName: String) {
        self.ctgId = ctgId
        self.name = name
        self.keyOrder = keyOrder
        self.follow = follow
        self.imgName = imgName
    }
}
