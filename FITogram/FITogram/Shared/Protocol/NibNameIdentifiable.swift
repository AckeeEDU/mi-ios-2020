//
//  NibNameIdentifiable.swift
//  FITogram
//
//  Created by Pacek on 23/04/2019.
//

import UIKit

protocol NibNameIdentifiable {}

extension NibNameIdentifiable where Self: UIView {

    static var identifier: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: Self.identifier, bundle: Bundle(for: Self.self))
    }

}
