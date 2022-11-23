//
//  3dModel.swift
//  ikea
//
//  Created by Michele Trombone  on 21/11/22.
//

import SwiftUI
import Model3DView

struct _dModel: View {
    
    @State var camera = PerspectiveCamera()
    
    var body: some View {
        Model3DView(named: "house.gltf")
            .cameraControls(OrbitControls(
                camera: $camera,
                sensitivity: 0.5,
                friction: 0.1
            ))
    }
}

struct _dModel_Previews: PreviewProvider {
    static var previews: some View {
        _dModel()
    }
}
