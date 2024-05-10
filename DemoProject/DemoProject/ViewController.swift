//
//  ViewController.swift
//  DemoProject
//
//  Created by Nagarjuna on 5/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    var serviceHandler: ServiceDelegate?
    @IBOutlet weak var tableview : UITableView!

    var users = [User]()
    var posts = [Post]()
    var resultArray = [User]()
    
    let dispatchGroup:DispatchGroup = DispatchGroup()

    
//    init(newServiceHandler: ServiceDelegate? = UserViewService()) {
//        super.init(nibName:nil, bundle: nil)
//        serviceHandler = newServiceHandler!
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        serviceHandler = UserViewService()
        
        
        guard let url1 = URL(string:"https://jsonplaceholder.typicode.com/users") else { return  }
        
        guard let url2 = URL(string:"https://jsonplaceholder.typicode.com/posts") else { return  }
        
        //let urlstr2 = ""
        
        callApi()
        
        // Do any additional setup after loading the view.
    }
    
    
    func callApi(){
        
        getPosts()
        getUsers()
        
        dispatchGroup.notify(queue:.global()){
            
            print("task done")
            
            for user in self.users {
                
                let result = self.posts.first(where: { value -> Bool in
                    value.id == user.id
                })
                
                if result != nil {
                    self.resultArray.append(user)
                }
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            print("RSIULT ARRAY COUNT: \(self.resultArray.count)")
            
        }
        
    }
    
    
    
    func getUsers(){
        
        dispatchGroup.enter()

        serviceHandler!.gerUsers(){ result in
            
           
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    print("Fetched new comments: \(users)")
                    self.users = users
                    self.dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                    self.dispatchGroup.leave()
                }
            }
            
            
            
        }
        
        
    }
    
    func getPosts(){
        
        dispatchGroup.enter()
        
        serviceHandler?.getPosts(){ result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    print("Fetched POST comments\(posts)")
                    self.posts = posts
                    self.dispatchGroup.leave()
                    print(posts[0].title)
                    
                case .failure(let error):
                    print(error)
                    self.dispatchGroup.leave()
                }
            }
            
            
        }
        
        
        
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
       
        let user = resultArray[indexPath.row]
        
        cell.name.text = user.name
        cell.email.text = user.email
        
        if let result = self.posts.first(where: { $0.id == user.id }) {
            cell.title.text = result.title
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDeailsViewController") as! UserDeailsViewController
        let user = resultArray[indexPath.row]
        if let result = self.posts.first(where: { $0.id == user.id }) {
            viewController.post = result
        }
        viewController.user = user
        navigationController!.pushViewController(viewController, animated: true)
    }
    
    
    
    
}
