//
//  LettersVc.swift
//  Countries List App
//
//  Created by karim metawea on 6/17/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import UIKit

class LettersVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
        CountriesService.getCountries { (success, error) in
            if success {
                self.countries = DataModel.countries
            }
            
            
            
        }
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

extension LettersVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LettersCell", for: indexPath) as! LettersCell
        cell.letterLabel.text = letters[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CountriesVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"CountriesVC") as! CountriesVC
        vc.countries = countries.filter({ (country) -> Bool in
            country.name.first == letters[indexPath.row].first
        })

        navigationController?.pushViewController(vc, animated: true)
      
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = transform
        cell.alpha = 0.5
        UIView.animate(withDuration: 1) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    
}

extension LettersVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width ) / 3
        let height = width + (width/2)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}
