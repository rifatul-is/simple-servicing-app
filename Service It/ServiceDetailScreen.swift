//
//  ServiceDetailScreen.swift
//  Service It
//
//  Created by Rifatul Islam on 4/6/23.
//

import SwiftUI

struct ServiceDetails: Codable, Hashable{
    let service_id : String
    let service_type_id : String
    let service_name : String
    let service_details : String
    let price : String
    let required_time : String
    let shop_id : String
    let shop_details : ShopDetails
}

struct ServiceDetailScreen: View {
    @State var user_id : String
    
    @State var serviceType : Int
    @State var shopId : String
    
    @State var serviceDetails : [ServiceDetails] = []
    
    var body: some View {
        ScrollView {
            ForEach(serviceDetails, id: \.self){i in
                ServiceDetailCard(user_id: self.user_id, shopId: i.shop_details.shop_id, shopName: i.shop_details.shop_name, serviceDetails: i, rating: i.shop_details.rating)
            }
        }
        .navigationTitle("Service Details")
        .onAppear{
            if serviceType != 0 {
                getServiceByType()
            }
            
            if shopId != "0" {
                getServiceByShop()
            }
            
            
            
        }
    }
    
    func getServiceByType() {
        
        if serviceType != 0 {
            var request = URLRequest(url: URL(string: "https://service-hub.mosnippet.xyz/services.php?type=\(serviceType)")!,timeoutInterval: Double.infinity)
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
                
                do {
                    self.serviceDetails = try JSONDecoder().decode([ServiceDetails].self, from: data)
                    print("report decoded")
                } catch let error {
                    print(error)
                }
                
            }.resume()
        }
    }
    
    func getServiceByShop() {
        
        if shopId != "0" {
            var request = URLRequest(url: URL(string: "https://service-hub.mosnippet.xyz/service_by_shop.php?shop=\(shopId)")!,timeoutInterval: Double.infinity)
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
                
                do {
                    self.serviceDetails = try JSONDecoder().decode([ServiceDetails].self, from: data)
                    print("report decoded")
                } catch let error {
                    print(error)
                }
                
            }.resume()
        }
    }
}

struct ServiceDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailScreen(user_id: "0", serviceType: 0, shopId: "1")
    }
}
