//
//  AlertChangeView.swift
//  ikea
//
//  Created by Michele Trombone  on 24/11/22.
//

import SwiftUI

struct AlertChangeView: View {
    @State var showDetail: Bool = false
    @State private var displayPopupMessage: Bool = false
        
        var body: some View {
            
            VStack {
                        NavigationLink(destination: SettingView(), isActive: self.$showDetail) { EmptyView() }
                        Button(action: {
                            self.displayPopupMessage = true
                                // self.showDetail = true
                                // self.displayPopupMessage = self.prepossess()
                              } )
                        {
                            Text("Alert and Navigate")
                        }
                    }
                    .alert(isPresented: $displayPopupMessage){
                        Alert(title: Text("Warning"), message: Text("This is a test"), dismissButton: .default(Text("OK"), action:{
                            print("Ok Click")
                            self.showDetail = true}))
                    }
                }
            
        }


struct AlertChangeView_Previews: PreviewProvider {
    static var previews: some View {
        AlertChangeView()
    }
}
