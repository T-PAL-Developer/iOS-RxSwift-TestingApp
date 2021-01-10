//
//  ViewController.swift
//  RxSwiftSampleApp
//
//  Created by Tomasz Paluszkiewicz on 10/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var nameEntryTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var namesLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var namesArray: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        bindTextFieldWithLabel()
        bindSubmitButton()
        
    }
    
    func bindTextFieldWithLabel() {
        nameEntryTextField.rx.text
            //.debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                if $0 == "" {
                    return "Type your name bellow."
                }
                else {
                    return "Hello, \($0!)."
                }
            }
            .bind(to: helloLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindSubmitButton() {
        submitButton.rx.tap.subscribe(onNext: {
            if self.nameEntryTextField.text != "" {
                self.namesArray.accept(self.namesArray.value + [self.nameEntryTextField.text!])
                self.namesLabel.rx.text.onNext(self.namesArray.value.joined(separator: ", "))
                self.nameEntryTextField.rx.text.onNext("")
                self.nameEntryTextField.rx.text.onNext("Type your name bellow.")
            }
        })
        .disposed(by: disposeBag)
    }
    
    func configUI() {
        nameEntryTextField.layer.cornerRadius = 10
        submitButton.layer.cornerRadius = 10
    }
    
}

