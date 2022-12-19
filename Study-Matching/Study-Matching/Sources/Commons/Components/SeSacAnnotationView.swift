import UIKit
import MapKit

class SeSacAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
}


class SeSacAnnotation: NSObject, MKAnnotation {
    let sesac: Int
    let coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D, sesac: Int) {
        self.coordinate = coordinate
        self.sesac = sesac
    }
}
