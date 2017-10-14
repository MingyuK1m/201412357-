
import UIKit
import MapKit
class allmap: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var maps: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maps.delegate = self
        var annotations = [MKPointAnnotation]()
        //p리스트에서 데이터를 받아오다
        
        let path = Bundle.main.path(forResource: "p", ofType: "plist")
       
        let contents = NSArray(contentsOfFile: path!)
        
        if let myItems = contents {
            for item in myItems {
                //식별하여 각각 저장
                let address = (item as AnyObject).value(forKey: "address")
                let title = (item as AnyObject).value(forKey: "title")
            
                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(address as! String, completionHandler: { placemarks, error in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let myPlacemarks = placemarks {
                        let myPlacemark = myPlacemarks[0]
                        
                        print("placemark[0] = \(String(describing: myPlacemark.name))")
                        
                        //one맵과 같은 방식으로 저장
                        let annotation = MKPointAnnotation()
                        annotation.title = title as? String
                        annotation.subtitle = address as? String
                        
                        //annotations 배열에 정보저장
                        if let myLocation = myPlacemark.location {
                            annotation.coordinate = myLocation.coordinate
                            annotations.append(annotation)
                        }
                        
                    }
                    print("annotations = \(annotations)")
                    //핀을 꽂기
                    self.maps.showAnnotations(annotations, animated: true)
                    self.maps.addAnnotations(annotations)
                    
                })
            }
        }
    }
    
}
