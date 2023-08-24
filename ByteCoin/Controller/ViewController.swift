//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var currentPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currentPicker.dataSource = self
        currentPicker.delegate = self
    }
    
    
}
    // MARK: - CoinManagerDelegate
    
extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoin(_ rate: String, current: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = rate
            self.currentLabel.text = current
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


    // MARK: - UIPickerViewDataSource, UIPickerViewDelegate
    
    
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectRow = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectRow)
    }
    
    
}

