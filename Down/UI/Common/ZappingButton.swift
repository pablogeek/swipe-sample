//
//  ZappingButton.swift
//  Down
//
//  Created by Pablo Martinez Piles on 3/2/24.
//

import SwiftUI

struct ZappingButton: View {
    let title: String?
    let iconName: String
    var body: some View {
        let size = title != nil ? Constants.buttonSize : Constants.buttonSizeNoTitle
        VStack(alignment: .center, spacing: Constants.spacing) {
            Image(systemName: iconName)
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
            if let title {
                Text(title)
                    .textCase(.uppercase)
            }
        }
        .frame(width: size, height: size)
        .foregroundColor(Color.white)
        .background(Color.black.opacity(Constants.opacity))
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.white, lineWidth: Constants.borderLineWidth)
        }
    }
}

extension ZappingButton {
    enum Constants {
        static let spacing: CGFloat = 5
        static let buttonSize: CGFloat = 100
        static let buttonSizeNoTitle: CGFloat = 50
        static let opacity: CGFloat = 0.4
        static let borderLineWidth: CGFloat = 1.0
    }
}
