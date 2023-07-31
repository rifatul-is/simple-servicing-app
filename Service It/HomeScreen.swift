//
//  ContentView.swift
//  Service It
//
//  Created by Rifatul Islam on 4/6/23.
//

import SwiftUI

struct HomeScreen: View {
    @State var user_id : String
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Servicing Hub")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 5)
            
            Text("Repairing your tech troubles, restoring devices to their prime with expertise and precision.")
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            Text("Choose The Service You Require")
                .font(.title3)
                .bold()
                .padding(.top)
                .multilineTextAlignment(.center)
            
            HStack{
                NavigationLink{
                    ServiceDetailScreen(user_id: self.user_id, serviceType: 2, shopId: "0")
                }label: {
                    VStack {
                        Image(systemName: "laptopcomputer")
                            .font(.largeTitle)
                            .padding()
                        
                        
                        Text("Laptop Servicing")
                            .font(.title3)
                            .bold()
                    }
                    .frame(width: 140, height: 140)
                    .padding(.all, 20)
                    .background(Color(.systemGray6))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                }
                
                NavigationLink{
                    ServiceDetailScreen(user_id: self.user_id, serviceType: 3, shopId: "0")
                }label: {
                    VStack {
                        Image(systemName: "gamecontroller.fill")
                            .font(.largeTitle)
                            .padding()
                        
                        
                        Text("Console Servicing")
                            .font(.title3)
                            .bold()
                    }
                    .frame(width: 140, height: 140)
                    .padding(.all, 20)
                    .background(Color(.systemGray6))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                }
            }
            .padding(.horizontal)
            
            HStack{
                NavigationLink{
                    ServiceDetailScreen(user_id: self.user_id, serviceType: 1, shopId: "0")
                }label: {
                    VStack {
                        Image(systemName: "iphone.gen2")
                            .font(.largeTitle)
                            .padding()
                        
                        Text("Phone Servicing")
                            .font(.title3)
                            .bold()
                    }
                    .frame(width: 140, height: 140)
                    .padding(.all, 20)
                    .background(Color(.systemGray6))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                }
                
                NavigationLink{
                    ServiceDetailScreen(user_id: self.user_id, serviceType: 4, shopId: "0")
                }label: {
                    VStack {
                        Image(systemName: "desktopcomputer")
                            .font(.title)
                            .padding()
                        
                        Text("Electronics Servicing")
                            .font(.title3)
                            .bold()
                    }
                    .frame(width: 140, height: 140)
                    .padding(.all, 20)
                    .background(Color(.systemGray6))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .onAppear{
            debugPrint("Home screen \(user_id)")
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(user_id: "0")
    }
}
