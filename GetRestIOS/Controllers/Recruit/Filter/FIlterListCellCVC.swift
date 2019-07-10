//
//  FIlterListCellCVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 09/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class FIlterListCellCVC: UICollectionViewCell {
    @IBOutlet var filterCellBtn: UIButton!
    var isChecked = false
    
    @IBAction func filterClickAction(_ sender: UIButton) {
        isChecked = !isChecked
        if isChecked {
            filterCellBtn.backgroundColor = .mainGreen
            filterCellBtn.setTitleColor(.white, for: .normal)
        } else {
            filterCellBtn.backgroundColor = .white
            filterCellBtn.setTitleColor(.mainGreen, for: .normal)
        }
    }
    
}
