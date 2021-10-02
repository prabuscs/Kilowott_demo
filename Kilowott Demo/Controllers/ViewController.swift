//
//  ViewController.swift
//  Kilowott Demo
//
//  Created by Clorida on 26/08/21.
//

import UIKit
class person {
    var name = String()
    var age = Int()
    init(name:String, age: Int) {
        self.name = name
        self.age = age
    }
    var appart: appartment?
}
class appartment {
    var unit = Int()
    init(unit:Int) {
        self.unit = unit
    }
    weak var tenant: person?
}

class ViewController: UIViewController {
    @IBOutlet weak var txtUser: UITextField?
    var repoDataList: [RepoModelElement]?
    var listSegueIdentifier = "listSegue"
    var arr1 = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getdata(url: "rv/repos", parameter: nil, completion: { clist in
                    self.repoDataList = clist
//            print(self.repoDataList as Any)
        })
        let tenant = person(name: "Prabu", age: 12)
        let appart = appartment(unit: 1)
        tenant.appart = appart
        print(tenant.name)
        print(tenant.appart?.unit)
    }
    
    @IBAction func onSubmit(_ sender:Any) {
        updateData()
    }
    /// Method for update data from API
    func updateData(){
        guard let userName = txtUser?.text else {return}
        WebService.shared.makeRequest(urlStr: "\(userName)/repos", parameter: "") { [unowned self] (data, err) in
            if err == nil {
                do {
                    let userData = try JSONDecoder().decode(RepoModel.self, from: data!)
                    self.repoDataList = userData
                    if self.repoDataList!.count > 0 {
                        DispatchQueue.main.async {
                            let vc = self.storyboard!.instantiateViewController(withIdentifier: "ReposListVC") as! ReposListVC
                            vc.repoList = self.repoDataList
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    } else {
                        self.alert(message:"You don't have any public repositories yet.", title: "")
                    }
                } catch {
                    showAlert()
                }
            } else {
                showAlert()
            }
        }
    }
    /// Method to show alert to the user
    private func showAlert() {
        self.alert(message:"Please check user name and try again", title: "")
    }
    func getdata(url:String?, method: HTTPMethod = .GET,parameter: String?, completion: @escaping (_ clist:[RepoModelElement]?)->Void){
        let url = URL(string: AppConstant.Base_URL+url!)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        request.httpBody = parameter?.data(using: String.Encoding.utf8)
        request.setValue(nil, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                do{
                    let jsonData = try JSONDecoder().decode(RepoModel.self, from: data!)
                    completion(jsonData)
                }catch{
                    completion(nil)
                }
            }else{
                completion(nil)
            }
        }
        task.resume()
        
    }
    
}

// MARK: UIImageView extesions
extension UIViewController {
  func alert(message: String, title: String = "") {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
}
struct DataModel: Codable {
    var name: String?
    var id: String?
}
class Dataclass: Codable {
    var name: String?
    func cl() -> () {
        
    }
    func get(str: String?, in: Int?, competion: @escaping(String?, Error?)->()){
        competion("abc", nil)
    }
   
}
