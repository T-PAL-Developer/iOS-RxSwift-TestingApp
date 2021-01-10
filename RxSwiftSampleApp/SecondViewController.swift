//
//  SecondViewController.swift
//  RxSwiftSampleApp
//
//  Created by Tomasz Paluszkiewicz on 10/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SecondViewController: UIViewController {
    
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let disposeBag = DisposeBag()
    let nameSubject = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    bindSubmitButton()
        
    }
    
    func bindSubmitButton() {
        submitButton.rx.tap.subscribe(onNext: {
            if self.newNameTextField.text != "" {
                self.nameSubject.onNext(self.newNameTextField.text!)
            }
        })
        .disposed(by: disposeBag)
    }


}
