//
//  KingDetailsViewController.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import UIKit

class KingDetailsViewController: UIViewController {

    var presenter: KingDetailsPresentation?
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var kingViewModel: KingDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "KingsBattledetailsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "KingsBattledetailsTableViewCell")
        
        let nib1 = UINib(nibName: "KingDetailsWarTableViewCell", bundle: nil)
        self.tableView.register(nib1, forCellReuseIdentifier: "KingDetailsWarTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView(kingModel: KingDetailsViewModel) {
        self.titleLable.text = kingModel.title
        self.imageView.image = UIImage(named: kingModel.image)
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.kingViewModel = kingModel
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension KingDetailsViewController: KingDetailsView {
    func showKingDetails(kingModel: KingDetailsViewModel) {
        self.configureView(kingModel: kingModel)
    }
   
}

extension KingDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Wars"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let count = self.kingViewModel?.battleDetails.count
            return count!
        }
        else {
            return (self.kingViewModel?.wars.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            // Load Battle Details cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "KingsBattledetailsTableViewCell") as! KingsBattledetailsTableViewCell
            let battleDetails = self.kingViewModel?.battleDetails[indexPath.row]
            cell.battleDetails = battleDetails
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "KingDetailsWarTableViewCell") as! KingDetailsWarTableViewCell
            let battleDetails = self.kingViewModel?.wars[indexPath.row]
            cell.battle = battleDetails
            return cell
        }
    }
}
