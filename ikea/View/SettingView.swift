//
//  SettingView.swift
//  ikea
//
//  Created by Michele Trombone  on 15/11/22.
//

import SwiftUI
import CodeScanner

struct SettingView: View
{
    @State var showCam = false
    @Environment(\.colorScheme) var colorScheme
    @State var showPopup = false
    @State var onClick = false
    @State var clickedButtonToResetToggle = false
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a BarCode to get a started"
    
    
    var support = IkeaModel()
    
    
    var scanner : some View
    {
        CodeScannerView(codeTypes: [.qr],
            completion:
                { result in
                if case let .success(code) = result
                    {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                    }
                })
    }

    var products = IkeaModel()
    
    
    var body: some View
    {
        
            ScrollView(.vertical, showsIndicators: false)
            {
                    Spacer(minLength: 40)
                    VStack(alignment: .leading, spacing: 30)
                    {
                        Text("Benvenuto in IKEA!")
                            .font(.title2)
                            .bold()
                        
                        Text("Iscriviti o accedi per usufruire di sconti speciali, accedere ai tuoi preferiti e usare la tua carta IKEA Family")
                            .font(.subheadline)
                        
                        Text("Pagina IKEA Business Network")
                            .font(.subheadline)
                        
                       
                        
                        // BOTTONI PER LOGIN
                        
                        
                        HStack(alignment: .center)
                        {
                            NavigationLink(destination: SplashScreen())
                            {
                                Text("Iscriviti")
                                
                                    .colorInvert()
                                    .foregroundColor(.white)
                                    .padding(.vertical,15)
                                    .padding(.horizontal,60)
                                    .background(Color.white)
                                    .cornerRadius(50)
                                
                            }.overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.gray, lineWidth: 1))
                            
                            NavigationLink(destination: SplashScreen())
                            {
                                Text("Accedi")
                                    .foregroundColor(.white)
                                    .padding(.vertical,15)
                                    .padding(.horizontal,60)
                                    .background(Color.blue)
                                    .cornerRadius(50)
                            }
                        }.frame(alignment: .center)
                        
                        Text("Shop & Go")
                            .font(.subheadline)
                            .bold()
                    }
 
                
                VStack(alignment: .leading, spacing: 30)
                {
                    HStack
                    {
                        Toggle(isOn : $showCam)
                        {
                            Label{
                                
                                VStack(alignment: .leading){
                                    
                                    Text("Scansiona i prodotti in negozio")
                                        .font(.subheadline)
                                        .bold()
                                    
                                    Text("Scansonami i prodotti e salta la coda alla cassa ")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                            } icon:{
                                VStack(alignment: .leading)
                                {
                                    Spacer()
                                    HStack
                                    {
                                        Image(systemName: "barcode.viewfinder")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    }.frame(width: 50)
                                }
                                
                            }
                        }
                    }.frame(width:355)
                    Divider()
                    
                    
                        
                        Text("La tua IKEA")
                            .font(.subheadline)
                            .bold()
                        
                        VStack(spacing: 40)
                        {
                            
                            
                            HStack(spacing: 260)
                            {
                                Label("Napoli",systemImage: "map")
                                
                                Image(systemName: "arrow.right")
                            }
                            Divider()
                            
                            HStack(spacing: 250)
                            {
                                Label("Carrello",systemImage: "cart")
                                
                                Image(systemName: "arrow.right")
                            }
                            Divider()
                            
                            HStack(spacing: 70)
                            {
                                Label("Carte regalo e carte di rimborso",systemImage: "gift")
                                
                                Image(systemName: "arrow.right")
                            }
                            Divider()
                            
                            
                        }
                        
                        Text("Impostazione dell'app")
                            .font(.subheadline)
                            .bold()
                        
                        VStack(spacing: 40)
                        {
                            
                            
                            HStack(spacing: 190)
                            {
                                Label("Preferenza dati",systemImage: "lock")
                                
                                Image(systemName: "arrow.right")
                            }
                            Divider()
                            
                            HStack(spacing: 180)
                            {
                                Label("Lingue e regione",systemImage: "globe")
                                
                                Image(systemName: "arrow.right")
                            }
                            Divider()
                        }
                        
                    Text("Informazioni e supporto IKEA")
                        .font(.subheadline)
                        .bold()
                }
                Spacer(minLength: 40)
                VStack(alignment: .leading, spacing: 40)
                {
                    ForEach(0..<support.supportText.count)
                    {
                        index in
                        Text(support.supportText[index])
                        Divider()
                    }
                        
                    
                }
                
            }.frame(width:360)
        
//            productScan = ScannedProduct(products: products,scannedCode: scannedCode)
            //FUNZIONE PER ATTIVARE IL BOTTONE IN CASO DI FLAG ATTIVA
            .safeAreaInset(edge: .bottom)
            {
                floatingButton
               
                
                if showPopup
                {
                    ZStack{
                        PopupView(isShowing: $showPopup)
                        
                        // vedere come spegnere toggle una volta che si apre la popupview
                        
                        
//                            .onChange(of: showCam == false, perform: {
//                                value in
//                                print(showCam)
//                            })
                    }
                }
            }
            
            
            // inserisco lo spazio non scrollabile sopra la scroll view
            .safeAreaInset(edge: .top)
            {
                Form
                {
                    
                }.frame(maxWidth: .infinity,maxHeight: 15)
            }
        
            // Cambio il valore di onClick in modo che se ho avviato l'azione di scan tramite questa booleana faccio aprire la view del popup
        
            .onChange(of: onClick == true, perform: {
                value in
                print(onClick)
            })
            // chiamo la funzione per lo scan del prodotto che restituisce l'immagine del prodotto che ho trovato nel db in questo caso prova con https://www.google.com per far apparire lugia
            
             
    }
    
    // CHECK BUTTON IN VARIUS MODE
    
    var floatingButton: some View
    {
        VStack
        {
            if showCam
            {
                Button(action:
                    {
                    isPresentingScanner = true
                    self.showPopup = true
                    onClick = true
                    }
                       // CONTROLLO SE E' ATTIVA LA DARK MODE PER SWITCHARE I COLORI DEI BOTTONI
                       ,label:
                        {
                    if colorScheme == .light
                    {
                        HStack(spacing: 100)
                        {
                            Text("Scansiona i prodotti")
                            Image(systemName: "barcode.viewfinder")
                                .resizable()
                                .frame(width: 25,height: 25)
                        } .foregroundColor(.white)
                            .frame(width: 360, height: 70)
                            .background(Color.black)
                            .cornerRadius(50)
                    
                    }
                    else
                    {
                        HStack(spacing: 100)
                        {
                            Text("Scansiona i prodotti")
                                
                            Image(systemName: "barcode.viewfinder")
                                .resizable()
                                .frame(width: 25,height: 25)
                        }
                        
                        .foregroundColor(.black)
                        .frame(width: 350, height: 70)
                        .background(Color.white)
                        .cornerRadius(50)
                        
                    }
                })
                .sheet(isPresented: $isPresentingScanner)
                {
                    self.scanner
                }
                
            }
        }
    }
}


func ScannedProduct(products : IkeaModel, scannedCode: String) // -> Product
{
    
    
    
    ForEach(0..<products.products.count)
    {
        product in
        
        if(scannedCode == products.products[product].id)
        {
            Image(products.products[product].image)
            //let productScanned = products.products[product]
        }
    }
    
    // return productScanned but da errore
}



struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
