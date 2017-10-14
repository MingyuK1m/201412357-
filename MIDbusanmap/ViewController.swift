

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //NS타입의 배열을 생성
    var contents = NSArray()

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터소스 및 딜리게이트 연결
        table.dataSource = self
        table.delegate = self
        
        //p리스트 주소값을 이용하여 찾은후 데이터를 컨텐츠에 넣는다
        let path = Bundle.main.path(forResource: "p", ofType: "plist")
        contents = NSArray(contentsOfFile: path!)!
    
        self.title = "중간고사"
    }
    //셀 갯수를 컨텐츠 갯수 만큼정한다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       
        return contents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let mycell = table.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        //컨텐츠에서 address라는 키를 찾아 상수 address 에 저장
        let address = (contents[indexPath.row] as AnyObject).value(forKey: "address")
        let title = (contents[indexPath.row] as AnyObject).value(forKey: "title")
        
        
        //출력을 위해 캐스팅하여 저장
        mycell.textLabel?.text = title as? String
        mycell.detailTextLabel?.text = address as? String
   
        return mycell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //del이라는 식별자를 찾아서 알맞게 보낸다
        if segue.identifier == "del"{
            let detailVC = segue.destination as! onemap
            let selectedPath = table.indexPathForSelectedRow
            
            //테이블에서 선택된 데이터를 찾아 del에 넣어 보낸다
            let title = (contents[(selectedPath?.row)!] as AnyObject).value(forKey: "title")
            let addr = (contents[(selectedPath?.row)!] as AnyObject).value(forKey: "address")
            detailVC.onetitle = title as! String
            detailVC.oneaddr = addr as! String
        }
        
        
        
        
    }
}
