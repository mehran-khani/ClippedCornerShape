@testable import ClippedCornerShape
import SwiftUI
import Testing

@Suite
struct ClippedCornerShapeTests {
    @Test
    func testCornerPositions() throws {
        // Test that different corner positions can be created
        let positions: [ClippedCornerPosition] = [
            .topLeft,
            .topRight,
            .bottomLeft,
            .bottomRight
        ]
        
        for position in positions {
            let shape = ClippedCornerShape(
                cornerRadius: 16,
                clipX: 140,
                clipY: 70,
                position: position
            )
            
            #expect(shape.position == position)
        }
    }
    
    @Test
    func testDefaultValues() throws {
        let defaultShape = ClippedCornerShape()
        
        #expect(defaultShape.cornerRadius == 16)
        #expect(defaultShape.clipX == 140)
        #expect(defaultShape.clipY == 70)
        #expect(defaultShape.position == .bottomRight)
    }
    
    @Test
    func testCustomValues() throws {
        let customShape = ClippedCornerShape(
            cornerRadius: 24,
            clipX: 100,
            clipY: 50,
            position: .topLeft
        )
        
        #expect(customShape.cornerRadius == 24)
        #expect(customShape.clipX == 100)
        #expect(customShape.clipY == 50)
        #expect(customShape.position == .topLeft)
    }
}
