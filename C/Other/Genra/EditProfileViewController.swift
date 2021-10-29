//
//  EditProfileViewController.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/25.
//

import UIKit

struct EditProfileFormModel{
    let label :String
    let placeholder :String
    var Value:String?
}

class EditProfileViewController: UIViewController, UITableViewDataSource {
    private var models = [[EditProfileFormModel]]()

    private let tableView :UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(didTapCancel))
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        

    }
    private func configureModels(){
        //name username website bio
        let section1Label = ["Name","Username","Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Label {
            let model = EditProfileFormModel(label: label, placeholder: "Enter\(label)....", Value: nil)
            section1.append(model)
        }
        models.append(section1)
        //email form gender
        let section2Label = ["Email","Form","Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Label {
            let model = EditProfileFormModel(label: label, placeholder: "Enter\(label)....", Value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    //MARK: - TableView
    private func createTableHeaderView() -> UIView{
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: floor(view.frame.height/4)))
        let size = header.height  / 1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size)/2, y: (header.height-size)/2, width: size, height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1.0
        profilePhotoButton.layer.borderColor  = UIColor.secondarySystemBackground.cgColor
             return header
        
     }
    @objc private func didTapProfilePhotoButton (){
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.label
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        return "Private Information"
    }
    
    //MARK: - Action
    
    @objc private func didTapSave(){
        // save info to database
    }
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    @objc private func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title: "Profiler Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "take a photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Form Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            
        }))
        //防ipad crash
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true, completion: nil)
    }

}
