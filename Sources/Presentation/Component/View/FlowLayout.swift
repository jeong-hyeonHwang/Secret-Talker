//
//  FlowLayout.swift
//  SecretTalker
//
//  Created by 황정현 on 7/10/25.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 4

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var size = CGSize.zero
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity

        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified)
            if rowWidth + viewSize.width > maxWidth {
                size.height += rowHeight + spacing
                rowWidth = 0
                rowHeight = 0
            }
            rowWidth += viewSize.width + spacing
            rowHeight = max(rowHeight, viewSize.height)
        }

        size.height += rowHeight

        return CGSize(width: maxWidth, height: size.height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x: CGFloat = bounds.minX + spacing
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0
        let maxWidth = bounds.width

        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified)

            if x + viewSize.width > maxWidth {
                x = bounds.minX + spacing
                y += rowHeight + spacing
                rowHeight = 0
            }

            view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(viewSize))
            x += viewSize.width + spacing
            rowHeight = max(rowHeight, viewSize.height)
        }
    }
}
