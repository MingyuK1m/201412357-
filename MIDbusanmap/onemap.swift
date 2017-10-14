
import UIKit
import MapKit
class onemap: UIViewController, MKMapViewDelegate{
    
    //segue 에서 받아오기 위한 변수들을 선언한다
    var onetitle = ""
    var oneaddr = ""
    
    @IBOutlet weak var maps: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maps.delegate = self
        var annotations = [MKPointAnnotation]()
        
        //주소값을 좌표값으로 바꾸기 위한 지오코드
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(oneaddr as! String, completionHandler: { placemarks, error in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let myPlacemarks = placemarks {
                let myPlacemark = myPlacemarks[0]
                
                print("placemark[0] = \(String(describing: myPlacemark.name))")
                
                //핀 객체을 선언
                let annotation = MKPointAnnotation()

                //핀에 타이틀과 서브타이틀을 저장
                annotation.title = self.onetitle as? String
                annotation.subtitle = self.oneaddr as? String
          
                //핀 데이터를 배열로 저장
                if let myLocation = myPlacemark.location {
                    annotation.coordinate = myLocation.coordinate
                    annotations.append(annotation)
                    
                }
                
            }
            //맵에 핀을 표시한다
            self.maps.showAnnotations(annotations, animated: true)
            
            self.maps.addAnnotations(annotations)
            
        })
        
    }
    
    
}
