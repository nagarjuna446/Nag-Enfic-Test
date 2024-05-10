//
//  UserDeailsViewController.swift
//  DemoProject
//
//  Created by Nagarjuna on 5/10/24.
//

import UIKit

class UserDeailsViewController: UIViewController {
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var username : UILabel!
    @IBOutlet weak var email : UILabel!
    @IBOutlet weak var address : UILabel!
    @IBOutlet weak var phone : UILabel!
    @IBOutlet weak var website : UILabel!
    @IBOutlet weak var company : UILabel!
    @IBOutlet weak var body : UILabel!

    var user: User!
    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User Details"
        setupdata()

        // Do any additional setup after loading the view.
    }
    func setupdata(){
        
        self.name.text = "NAME:  \(user.name ?? "")"
        self.username.text = "USER NAME:  \(user.username ?? "")"
        self.email.text = "EMAIL:  \(user.email ?? "")"
        self.address.text = "ADDRESS:  \(user.address?.street ?? "")"
        self.phone.text = "PHONE:  \(user.phone ?? "")"
        self.website.text = "website:  \(user.website ?? "")"
        self.company.text = "COMPANY:  \(user.company?.name ?? "")"
        self.body.text = "BODY:  \(self.post.body)"
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
