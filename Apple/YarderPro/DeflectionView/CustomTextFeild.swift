//
//  CustomTextFeild.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/17/24.
//

import SwiftUI

struct CustomBorderedTextFieldStyle: TextFieldStyle {
    var isEditing: Bool

    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isEditing ? Color.blue : Color.gray, lineWidth: 2)
                    .background(Color.white)
                    .cornerRadius(8)
            )
            .padding([.leading, .trailing], 2)
    }
}

