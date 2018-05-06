//
//  KingsListViewController.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import UIKit

class KingsListViewController: UIViewController {
    
    var presenter: KingsListPresentation!
    
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var kingsListViewModel: KingsListViewModel? {
        didSet {
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "KingsListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "KingsListTableViewCell")
        
        self.presenter?.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureView() {
        self.titleLable.text = self.kingsListViewModel?.title
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
}

extension KingsListViewController: KingsListView {
    func updateKingsList(viewModel: KingsListViewModel) {
        // Update UI
        self.kingsListViewModel = viewModel
    }
    
    func moveToNextScreen(view: UIViewController) {
       self.navigationController?.pushViewController(view, animated: true)
    }
    
    func showErrorMessage() {
        // Show Error message if we receive error from Server
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: "Error", message: "Unble to fetch data from server, Please try again later", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (sender) in
                
            })
            alertViewController.addAction(okButton)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
}

extension KingsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.kingsListViewModel {
            return viewModel.masterList?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "KingsListTableViewCell") as! KingsListTableViewCell
       
        var kingModel: KingsModel!
        if let model = self.kingsListViewModel?.masterList![indexPath.row] {
            kingModel = model
        }
        else {
            print("SomeThing wrong in Model, Please recheck")
            return cell
        }
        cell.kingModel = kingModel
        
        return cell
    }
}

extension KingsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row Selected: \(indexPath.row)")
        if let model = self.kingsListViewModel?.masterList![indexPath.row] {
            self.presenter.showKingDetailsScreen(kingModel: model)
        }
    }
}
