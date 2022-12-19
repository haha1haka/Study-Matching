import Foundation

extension String {
    
    var toPureNumber: String {
        let startIndex: String.Index = self.index(self.startIndex, offsetBy: 1)
        var pureNumber = String(self[startIndex...])
        pureNumber =  pureNumber.replacingOccurrences(of: "-", with: "")
        print(pureNumber)
        return "+82\(pureNumber)"
    }
    
    var stringToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)!
        return date
    }
}
