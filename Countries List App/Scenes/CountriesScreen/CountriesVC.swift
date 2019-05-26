//
//  CountriesVC.swift
//  Countries List App
//
//  Created by karim metawea on 5/26/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import UIKit
import JGProgressHUD
import Firebase
import GoogleSignIn



class CountriesVC: UIViewController {
    
// outlets
    @IBOutlet weak var tableView: UITableView!
    
    
//  properties
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
//    life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        hud.show(in: view, animated: true)
        
        navigationItem.hidesBackButton = true
        
        let logOutButton = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOutButton))
        navigationItem.rightBarButtonItem = logOutButton
        CountriesService.getCountries { (success, error) in
            if success {
                self.tableView.reloadData()
                self.hud.dismiss(afterDelay: 1)
            }
            
            self.hud.dismiss(afterDelay: 1)
            
            }
        
        
    }
    
//    log out using navigation item
    @objc func handleLogOutButton(){
        do {
           try Auth.auth().signOut()
           try GIDSignIn.sharedInstance()?.signOut()
            navigateToRootVc()
        } catch(let error) {
            print(error.localizedDescription)
        }
        
    }
    
    
//    go bact to root vc
    func navigateToRootVc(){
        navigationController?.popToRootViewController(animated: true)
    }

}

extension CountriesVC : UITableViewDelegate , UITableViewDataSource {
    
//    data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        let country = DataModel.countries[indexPath.row]
        cell.configureCell(country: country)
        return cell
    }
//    setting up the delegate
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
