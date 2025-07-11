//
//  FlowLayout.swift
//  SecretTalker
//
//  Created by 황정현 on 7/10/25.
//

import SwiftUI

struct FlowLayout: Layout {
    var defaultSize: CGSize
    var padding: CGFloat = 8
    var spacing: CGFloat = 4

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        guard !subviews.isEmpty else { return .zero }

        let availableWidth = max(maxWidth - padding * 2, 0)
        let itemTotalWidth = defaultSize.width + spacing
        let itemsPerRow = max(Int((availableWidth + spacing) / itemTotalWidth), 1)
        let rowCount = (subviews.count + itemsPerRow - 1) / itemsPerRow
        let totalHeight = CGFloat(rowCount) * defaultSize.height + CGFloat(rowCount - 1) * spacing

        return CGSize(width: maxWidth, height: totalHeight + padding * 2)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }

        let maxWidth = bounds.width
        let availableWidth = max(maxWidth - padding * 2, 0)

        let itemFullWidth = defaultSize.width + spacing
        let itemsPerRow = max(Int((availableWidth + spacing) / itemFullWidth), 1)
        let idealRowWidth = CGFloat(itemsPerRow) * defaultSize.width + CGFloat(itemsPerRow - 1) * spacing
        let leadingOffset = padding + (availableWidth - idealRowWidth) / 2

        var y = bounds.minY + padding
        var x = bounds.minX + leadingOffset
        var rowItemCount = 0

        for view in subviews {
            if rowItemCount == itemsPerRow {
                y += defaultSize.height + spacing
                x = bounds.minX + leadingOffset
                rowItemCount = 0
            }

            view.place(
                at: CGPoint(x: x, y: y),
                anchor: .topLeading,
                proposal: ProposedViewSize(defaultSize)
            )
            x += defaultSize.width + spacing
            rowItemCount += 1
        }
    }
}
