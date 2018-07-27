//
//  ProfileViewController.swift
//  Proyecto Integrador
//
//  Created by Digital House on 26/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Kingfisher

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func logoutButtomBar(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {}
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.archievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archCell", for: indexPath)
        
        if let cellA = cell as? ArchievementTableViewCell {
            cellA.setup(arch: self.archievements[indexPath.row])
    }
        
        return cell
    }
    

    @IBOutlet weak var archTableView: UITableView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var archievements:[Archievement] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.archTableView.delegate = self
        self.archTableView.dataSource = self
        self.archTableView.rowHeight = 200
        
        
        getProfileData()
        getArchivementes()
       
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getArchivementes()
    }
    
    func getProfileData(){
        if let user = Auth.auth().currentUser {
            let service = ProfileService()
            service.getProfileInfoFromDataBase(user: user, completion: { (profileInfo) in
                
                var theName = profileInfo["name"] as? String ?? "Anonimous"
                self.profileName.text = theName.uppercased()
                
                if let urlS = profileInfo["url"] as? String{
                    if let urlV = URL(string: urlS){
                        self.profileImageView.kf.setImage(with: urlV)
                    }
                }
                
                
            })
           
            
        }
    }
    
    func getArchivementes(){
        let service = ArchievementService()
        
        service.getLocalArchievement(completion:
            { (archievements) in
            self.archievements = archievements
            self.archTableView.reloadData()
            
        })
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



