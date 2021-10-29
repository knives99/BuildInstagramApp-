//
//  SettingViewController.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/25.
//

import UIKit
import SafariServices

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
        data.append([SettingCellModel(title: "Edit Profile", handler: {[weak self]  in self?.didTapEditProfie() }),
                     SettingCellModel(title: "Invite Friend", handler: {[weak self]  in
            self?.didTapInviteFriend()
        }),
                     SettingCellModel(title: "Save OriginalPosts", handler: {[weak self]  in
            self?.didTapSaveOriginalPosts()
        })
                    ])
        data.append([SettingCellModel(title: "Terms of Service", handler: {[weak self]  in
            self?.openUrl(type:.terms)
        }),
                     SettingCellModel(title: "Privacy Policy", handler: {[weak self]  in                       self?.openUrl(type:.privacy)
        }),
                     SettingCellModel(title: "Help/FeedBack", handler: {[weak self]  in
            self?.openUrl(type:.help)
        })
                    ])
        data.append([SettingCellModel(title: "Log out", handler: {[weak self]  in
            self?.didTapLogout()
        })
                    ])
        
        
        
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
    
    enum SettingUrlType{
        case terms,privacy,help
    }
    private func didTapEditProfie(){
        let VC = EditProfileViewController()
        VC.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: VC)
        present(navVC, animated: true, completion: nil)
    }
    private func didTapInviteFriend(){
        //show share Sheet to invite Friends
    }
    private func didTapSaveOriginalPosts(){

    }
    private func openUrl(type:SettingUrlType){
        let urlString :String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/196883487377501"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlString) else {return}
        let VC = SFSafariViewController(url: url)
        present(VC, animated: true, completion: nil)
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
