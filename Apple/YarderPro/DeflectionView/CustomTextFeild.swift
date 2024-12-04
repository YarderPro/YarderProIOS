//
//  CustomTextFeild.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/17/24.
//

import SwiftUI

/*
 All text feilds used within YarderPro come from this custom text feild style struct, the is editing porition of this code allows for the change in color when a box is selected. 
 */

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

