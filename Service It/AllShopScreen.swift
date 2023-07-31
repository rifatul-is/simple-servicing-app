//
//  AllShopScreen.swift
//  Service It
//
//  Created by Rifatul Islam on 4/6/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct ShopDetails: Codable, Hashable {
    let shop_id : String
    let shop_name : String
    let location : String
    let contact_number : String
    let image : String
    let rating : String
}

struct AllShopScreen: View {
    @State var user_id : String
    
    @State var shopList : [ShopDetails] = []
    
    var body: some View {
        
        VStack{
            Text("All Servicing Shop")
                .font(.largeTitle)
                .bold()
                //.padding(.bottom, 5)
            
            List{
                ForEach(shopList , id: \.self) {i in
                    
                    let locationArray = i.location.components(separatedBy: ", ")
                    
                    let locationlat = (locationArray[0] as NSString).doubleValue
                    let locationlong = (locationArray[1] as NSString).doubleValue
                    
                    
                    VStack{
                        AsyncImage(url: URL(string: i.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)

                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: .infinity)
                        .cornerRadius(5)
                        
                        VStack (alignment: .center){
                            Text(i.shop_name)
                                .font(.title3)
                                .bold()

                            Text("Rating : \(i.rating) ☆")
                                .bold()
                                .foregroundColor(.gray)
                        }
                    }
                    .overlay(NavigationLink(destination: ServiceMapScreen(loginId: self.user_id, shopId: i.shop_id, shopName: i.shop_name, shopContact: i.contact_number, region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationlat, longitude: locationlong), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), label: {EmptyView()}).opacity(0))

                }
            }
        }
        .background(Color(.systemGray6))
        .onAppear{
            getShopList()
        }
    }
    
    private func getShopList(){
        var request = URLRequest(url: URL(string: "https://service-hub.mosnippet.xyz/shops.php")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if httpResponse.statusCode == 200 {
                print("Success")
            }
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            //print(String(data: data, encoding: .utf8)!)
            
            do {
                self.shopList = try JSONDecoder().decode([ShopDetails].self, from: data)
                print("report decoded")
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
}

struct AllShopScreen_Previews: PreviewProvider {
    static var previews: some View {
        AllShopScreen(user_id: "0")
    }
}
