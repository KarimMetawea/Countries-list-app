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
    
    var countries = [Country]()
    
//    life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        hud.show(in: view, animated: true)
        
        
        
        let logOutButton = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOutButton))
        navigationItem.rightBarButtonItem = logOutButton
        CountriesService.getCountries { (success, error) in
            if success {
                self.tableView.reloadData()
//                self.hud.dismiss(afterDelay: 1)
            }
            
//            self.hud.dismiss(afterDelay: 1)
            
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
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        let country = countries[indexPath.row]
        cell.configureCell(country: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = transform
        cell.alpha = 0.5
        UIView.animate(withDuration: 1) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
//    setting up the delegate
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
