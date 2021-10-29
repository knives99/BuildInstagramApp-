//
//  FormTableViewCell.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/28.
//

import UIKit

class FormTableViewCell: UITableViewCell,UITextFieldDelegate {
    private let formLabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let field:UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model:EditProfileFormModel){
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.Value
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Assign Frames
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        field.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width - 10 - formLabel.frame.width, height: contentView.height)
    }
    
    //MARK: -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
