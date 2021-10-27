//
//  SettingViewController.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/25.
//

import UIKit

struct SettingCellModel{
    let title:String
    let handler: (() -> Void)
}

/// View COntroller to show user setting
final class SettingViewController: UIViewController {
    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data =  [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureModels(){
        let section = [
            SettingCellModel(title: "LogOut", handler: {
                [weak self] in
                self?.didTapLogout()
            })
        ]
        data.append(section)
    }
    
    private func didTapLogout(){
        let actionSheet = UIAlertController(title: "Log out", message: "Are you sure u eant to log out", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler:{ _ in
            Authmanager.shared.logOut { result in
                DispatchQueue.main.async {
                    if result == true{
                        // present login VC
                        let VC = LoginViewController()
                        VC.modalPresentationStyle = .fullScreen
                        self.present(VC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        // error occurrred
                        fatalError("Could not log out User")
                    }
                }
            }
        }))
        // prevent Ipad Crash
        actionSheet.popoverPresentationController?.sourceView = tableView 
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension SettingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //handle cell selection
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
    
    
}
