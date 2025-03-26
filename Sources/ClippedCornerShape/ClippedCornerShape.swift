import SwiftUI

/// An enumeration representing the corner positions for clipping a shape.
enum ClippedCornerPosition {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

struct ClippedCornerShape: Shape {
    /// Creates a new ClippedCornerShape with custom parameters
    ///
    /// - Parameters:
    ///   - cornerRadius: Radius of the corner arcs, default is 16
    ///   - clipX: Horizontal extent of the clip, default is 140
    ///   - clipY: Vertical extent of the clip, default is 70
    ///   - position: Position of the clipped corner, default is .bottomRight\

    var cornerRadius: CGFloat = 16
    var clipX: CGFloat = 140
    var clipY: CGFloat = 70
    var position: ClippedCornerPosition = .bottomRight
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        switch position {
        case .bottomRight:
            createBottomRightPath(&path, rect: rect)
        case .bottomLeft:
            createBottomLeftPath(&path, rect: rect)
        case .topRight:
            createTopRightPath(&path, rect: rect)
        case .topLeft:
            createTopLeftPath(&path, rect: rect)
        }
        
        path.closeSubpath()
        return path
    }
    
    private func createBottomRightPath(_ path: inout Path, rect: CGRect) {
        // Start at top after the top-left corner
        path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        
        // Top edge
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        
        // Top right corner
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        
        // Right edge to the start of clip
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - clipY))
        
        // First arc - top arc of the clip
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - clipY),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        
        // Horizontal line after first arc
        path.addLine(to: CGPoint(x: rect.maxX - clipX + cornerRadius, y: rect.maxY - clipY + cornerRadius))
        
        // Second arc - middle inner corner
        path.addArc(
            center: CGPoint(x: rect.maxX - clipX + cornerRadius, y: rect.maxY - clipY + cornerRadius * 2),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(180),
            clockwise: true
        )
        
        // Vertical line after second arc
        path.addLine(to: CGPoint(x: rect.maxX - clipX, y: rect.maxY - cornerRadius))
        
        // Third arc - bottom corner of the clip
        path.addArc(
            center: CGPoint(x: rect.maxX - clipX - cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        
        // Bottom edge
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        
        // Bottom left corner
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        
        // Left edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        
        // Top left corner
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
    }
    
    private func createBottomLeftPath(_ path: inout Path, rect: CGRect) {
        // Start after the top-left corner
        path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        
        // Top edge
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        
        // Top right corner
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        
        // Right edge
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        
        // Bottom right corner
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        
        // Bottom edge to the start of clip
        path.addLine(to: CGPoint(x: rect.minX + clipX, y: rect.maxY))
        
        // First arc - bottom arc of the clip
        path.addArc(
            center: CGPoint(x: rect.minX + clipX, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        
        // Vertical line after first arc
        path.addLine(to: CGPoint(x: rect.minX + clipX - cornerRadius, y: rect.maxY - clipY - cornerRadius))
        
        // Second arc - middle inner corner
        path.addArc(
            center: CGPoint(x: rect.minX + clipX - cornerRadius * 2, y: rect.maxY - clipY + cornerRadius * 2),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(270),
            clockwise: true
        )
        
        // Horizontal line after second arc
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - clipY + cornerRadius))
        
        // Third arc - left corner of the clip
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - clipY),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        
        // Left edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        
        // Top left corner
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
    }
    
    private func createTopRightPath(_ path: inout Path, rect: CGRect) {
        // Start at the bottom-left corner
        path.move(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
        
        // Bottom right corner
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(0),
            clockwise: true
        )
        
        // Right edge
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + clipY))
        
        // First arc - right arc of the clip
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + clipY),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(-90),
            clockwise: true
        )
        
        // Horizontal line after first arc
        path.addLine(to: CGPoint(x: rect.maxX - clipX + cornerRadius, y: rect.minY + clipY - cornerRadius))
        
        // Second arc - middle inner corner
        path.addArc(
            center: CGPoint(x: rect.maxX - clipX + cornerRadius, y: rect.minY + clipY - cornerRadius * 2),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        
        // Vertical line after second arc
        path.addLine(to: CGPoint(x: rect.maxX - clipX, y: rect.minY + cornerRadius))
        
        // Third arc - top corner of the clip
        path.addArc(
            center: CGPoint(x: rect.maxX - clipX - cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(-90),
            clockwise: true
        )
        
        // Top edge
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        
        // Top left corner
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(-180),
            clockwise: true
        )
        
        // Left edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))

        // Bottom left corner
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(270),
            endAngle: .degrees(90),
            clockwise: true
        )
        
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
    }
    
    private func createTopLeftPath(_ path: inout Path, rect: CGRect) {
        // Start at bottom-right corner
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        
        // Right edge
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius))
        
        // Top-right corner
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(-90),
            clockwise: true
        )
        
        // Top edge to start of clip
        path.addLine(to: CGPoint(x: rect.minX + clipX, y: rect.minY))
        
        // First arc - top arc of the clip
        path.addArc(
            center: CGPoint(x: rect.minX + clipX, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(-180),
            clockwise: true
        )
        
        // Vertical line after first arc
        path.addLine(to: CGPoint(x: rect.minX + clipX - cornerRadius, y: rect.minY + clipY - cornerRadius * 2))
        
        // Second arc - middle inner corner
        path.addArc(
            center: CGPoint(x: rect.minX + clipX - cornerRadius * 2, y: rect.minY + cornerRadius * 2),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        
        // Horizontal line after second arc
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + clipY - cornerRadius))
        
        // Third arc - bottom corner of the clip
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + clipY),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(-180),
            clockwise: true
        )
        
        // Left edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))
        
        // Bottom-left corner
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(90),
            clockwise: true
        )
        
        // Bottom edge
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
        
        // Bottom-right corner
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(0),
            clockwise: true
        )
    }
}

/// A ViewModifier that applies the ClippedCornerShape to a view
struct ClippedCornerModifier: ViewModifier {
    var clipX: CGFloat
    var clipY: CGFloat
    var cornerRadius: CGFloat = 16
    var position: ClippedCornerPosition = .bottomRight
    
    func body(content: Content) -> some View {
        content
            .clipShape(ClippedCornerShape(
                cornerRadius: cornerRadius,
                clipX: clipX,
                clipY: clipY,
                position: position
            ))
    }
}

extension View {
    /// Applies a clipped corner effect to the view
    ///
    /// - Parameters:
    ///   - clipX: Horizontal extent of the clip
    ///   - clipY: Vertical extent of the clip
    ///   - cornerRadius: Radius of the corner arcs, default is 16
    ///   - position: Position of the clipped corner, default is .bottomRight
    ///   - Returns: A view with the clipped corner effect applied
    func clippedCorner(
        clipX: CGFloat,
        clipY: CGFloat,
        cornerRadius: CGFloat = 16,
        position: ClippedCornerPosition = .bottomRight
    ) -> some View {
        modifier(ClippedCornerModifier(
            clipX: clipX,
            clipY: clipY,
            cornerRadius: cornerRadius,
            position: position
        ))
    }
}
