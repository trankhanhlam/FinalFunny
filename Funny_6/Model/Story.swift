class Story {
    var id: Int
    var title: String
    var content: String
    var imgUrl: String?
    var dateCreated: Double?
    var dateFavorited: Int
    var ctgID: Int
    var favorite: Int
    var read: Int
    var numSeen: Int
    var dateReaded: Int
    
    init(id: Int,
         title: String,
         content: String,
         imgUrl: String?,
         dateCreated: Double?,
         dateFavorited: Int,
         ctgID: Int,
         favorite: Int,
         read: Int,
         numSeen: Int,
         dateReaded: Int) {
        self.id = id
        self.title = title
        self.content = content
        self.imgUrl = imgUrl
        self.dateCreated = dateCreated
        self.dateFavorited = dateFavorited
        self.ctgID = ctgID
        self.favorite = favorite
        self.read = read
        self.numSeen = numSeen
        self.dateReaded = dateReaded
    }
}
