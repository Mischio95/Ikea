//
//  3dView.swift
//  ikea
//
//  Created by Michele Trombone  on 22/11/22.
//

import SwiftUI
import SceneKit

struct _dView: View {
    @State var prodottoScannerizzato : String = "Lugia_ColladaMax.usdz"
    var body: some View {
        SceneView(scene: SCNScene(named: prodottoScannerizzato),options: [.autoenablesDefaultLighting,.allowsCameraControl])
            .frame(width: UIScreen.main.bounds.width  ,height: UIScreen.main.bounds.height / 3)
    }
}

struct _dView_Previews: PreviewProvider {
    static var previews: some View {
        _dView()
    }
}
