//
//  Font+.swift
//  SecretTalker
//
//  Created by 황정현 on 7/11/25.
//

import SwiftUI

extension Font {
    enum OrbitronWeight {
        case bold
        case regular
        
        var value: String {
            switch self {
            case .bold:
                return "Bold"
            case .regular:
                return "Regular"
            }
        }
    }
    
    static func orbitron(_ weight: OrbitronWeight, size fontSize: CGFloat) -> Font {
        let familyName = "Orbitron"
        let weightString = weight.value

        return Font.custom("\(familyName)-\(weightString)", size: fontSize)
    }
}

extension Font {
    static var orbitronLargeTitle: Font {
        .orbitron(.bold, size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }

    static var orbitronTitle: Font {
        .orbitron(.bold, size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }

    static var orbitronTitle2: Font {
        .orbitron(.regular, size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
    }

    static var orbitronTitle3: Font {
        .orbitron(.regular, size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
    }

    static var orbitronHeadline: Font {
        .orbitron(.bold, size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }

    static var orbitronSubheadline: Font {
        .orbitron(.regular, size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }

    static var orbitronBody: Font {
        .orbitron(.regular, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }

    static var orbitronCallout: Font {
        .orbitron(.regular, size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }

    static var orbitronFootnote: Font {
        .orbitron(.regular, size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }

    static var orbitronCaption: Font {
        .orbitron(.regular, size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    }

    static var orbitronCaption2: Font {
        .orbitron(.regular, size: UIFont.preferredFont(forTextStyle: .caption2).pointSize)
    }
}
