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
    @State var scannedCode: String = ""
    
    
    var support = IkeaModel()
    
    
    var scanner : some View
    {
        CodeScannerView(codeTypes: [.qr],
            completion:
                { result in
                if case let .success(code) = result
                    {
                    self.scannedCode = code.string
                    products.testo = scannedCode
                    self.isPresentingScanner = false
                    }
                })
    }

    
    
    
    var body: some View
    {
        NavigationStack()
        {
            ScrollView(.vertical, showsIndicators: false)
            {
                Spacer(minLength: 40)
                VStack(alignment: .leading, spacing: 30)
                {
                    Text("Welcome to IKEA!")
                        .font(.title2)
                        .bold()
                    
                    Text("Sign up or log in to access special discounts, yout favourites and yout IKEA Family card.")
                        .font(.subheadline)
                    
                    Text("IKEA for Business")
                        .font(.subheadline)
                    
                    
                    
                    // BOTTONI PER LOGIN
                    
                    
                    HStack(alignment: .center)
                    {
                        NavigationLink(destination: SplashScreen())
                        {
                            Text("Log in")
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
                            Text("Sign up")
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
                                    
                                    Text("Scan items in-store")
                                        .font(.subheadline)
                                        .bold()
                                    
                                    Text("Scan items and skip the queue at the checkout")
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
                        }.tint(.blue)
                    }.frame(width:355)
                    Divider()
                    
                    if showCam
                    {
                        selectedShop
                    }
                    
                    Spacer()
                    
                   
                        
// YOUR IKEA SECTION NAVIGATION VIEW
                    
                Text("Your IKEA")
                    .font(.subheadline)
                    .bold()
                    
                Spacer(minLength: -10)
                VStack(alignment: .leading ,spacing: 40)
                {
                    ForEach (0..<support.yourIkeaText.count)
                    {
                        index in
                            HStack
                            {
                                NavigationLink(destination: SettingView())
                                {
                                    Label(support.yourIkeaText[index], systemImage:support.youtIkeaIcon[index])
                                    Spacer()
                                    
                                    if colorScheme == .light{
                                        Image("arrow")
                                            .resizable()
                                            .frame(width: 15,height: 15,alignment: .trailing)
                                    }
                                    else
                                    {
                                        Image("arrow.darkmode")
                                            .resizable()
                                            .frame(width: 15,height: 15,alignment: .trailing)
                                    }
                                }
                            }
                        Divider()
                            
                        }
                
// YOUR IKEA SETTING NAVIGATION VIEW
                        Text("Settings")
                            .font(.subheadline)
                            .bold()
                    Spacer(minLength: -20)
                        
                    ForEach(0..<support.settingText.count)
                    {
                        index in
                        HStack
                        {
                            NavigationLink(destination: SettingView())
                            {
                                Label(support.settingText[index],systemImage: support.settingIcon[index])
                                Spacer()
                                if colorScheme == .light{
                                    Image("arrow")
                                        .resizable()
                                        .frame(width: 15,height: 15,alignment: .trailing)
                                }
                                else
                                {
                                    Image("arrow.darkmode")
                                        .resizable()
                                        .frame(width: 15,height: 15,alignment: .trailing)
                                }
                            }
                            
                        }
                        Divider()
                    }
                        
                        
                    
                    
//IKEA INFORMATION SUPPORT TEXT
                        Text("IKEA information and support")
                            .font(.subheadline)
                            .bold()
                    }
                }
            
                Spacer(minLength: 60)
                VStack(alignment: .leading, spacing: 40)
                {
                    ForEach(0..<support.supportText.count)
                    {
                        index in
                        
                        HStack
                        {
                            NavigationLink(destination: SettingView())
                            {
                                Text(support.supportText[index])
                                Spacer()
                                if colorScheme == .light{
                                    Image("arrow")
                                        .resizable()
                                        .frame(width: 15,height: 15,alignment: .trailing)
                                }
                                else
                                {
                                    Image("arrow.darkmode")
                                        .resizable()
                                        .frame(width: 15,height: 15,alignment: .trailing)
                                }
                                    
                            }
                           
                        }
                        Divider()

                    }
                    
                }
            }.frame(width:360)
            
            
            //FUNZIONE PER ATTIVARE IL BOTTONE IN CASO DI FLAG ATTIVA
                .safeAreaInset(edge: .bottom)
            {
                floatingButton
                
                
                if showPopup && scannedCode != ""
                {
                    ZStack
                    {
                        PopupView(isShowing: $showPopup)
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
    }
    
    
    
    var floatingButton: some View
    {
        VStack
        {
            if showCam
            {
                Button(action:
                    {
                    let impact = UIImpactFeedbackGenerator(style: .heavy)
                      impact.impactOccurred()
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
                            Text("Scan items")
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
                            Text("Scan items")
                                
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
        }.padding()
    }
    
    func hapticFeedbackOnTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) -> some View {
        self.onTapGesture {
          let impact = UIImpactFeedbackGenerator(style: style)
          impact.impactOccurred()
        }
      }
    
    var selectedShop : some View
    {
        NavigationStack
        {
            HStack()
            {
                Text("Selected Shop")
                    .font(.subheadline)
                    .bold()
                Spacer(minLength: 50)
                Text("Naples")
                    .font(.subheadline)
                
                if colorScheme == .light{
                    Image("arrow")
                        .resizable()
                        .frame(width: 15,height: 15,alignment: .trailing)
                }
                else
                {
                    Image("arrow.darkmode")
                        .resizable()
                        .frame(width: 15,height: 15,alignment: .trailing)
                }
                    
            }
        }
    }
}





struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
