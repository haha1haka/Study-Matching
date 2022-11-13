import Foundation

extension String {
    var toPureNumber: String {
        let startIndex: String.Index = self.index(self.startIndex, offsetBy: 1)
        var pureNumber = String(self[startIndex...])
        pureNumber =  pureNumber.replacingOccurrences(of: "-", with: "")
        print(pureNumber)
        return "+82\(pureNumber)"
    }
}
