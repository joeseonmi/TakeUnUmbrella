//
//  Views.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/27.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import UIKit

class baseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func attribute() {
        backgroundColor = AppAttribute.AppColor.background
        layer.borderColor = AppAttribute.AppColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.shadowColor = AppAttribute.AppColor.shadow.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 13
        layer.shadowOpacity = 0.35
    }
}
