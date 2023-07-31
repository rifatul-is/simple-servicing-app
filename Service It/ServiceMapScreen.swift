//
//  ServiceMapScreen.swift
//  Service It
//
//  Created by Rifatul Islam on 4/6/23.
//

import SwiftUI
import MapKit
import Alamofire

struct SerciveShopLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ServiceMapScreen: View {
    
    @State var showAlert : Bool = false
    
    @State var loginId : String
    @State var shopId : String
    @State var shopName : String
    @State var shopContact : String
    @State var serviceDetails : [ServiceDetails] = []
    
    @State var bookServiceActive = false
    
    @State var region : MKCoordinateRegion
    
    var body: some View {
        
        let annotations = [
            SerciveShopLocation(name: "Shop", coordinate: CLLocationCoordinate2D(latitude: region.center.latitude , longitude: region.center.longitude))
        ]
        
        ZStack(alignment: .top){
            
            ScrollView(showsIndicators: false) {
                
                Text("All Services")
                    .font(.title2)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    .padding(.top)
                
                ForEach(serviceDetails, id: \.self) { i in
                    NavigationLink{
                        ServiceDetailsFromMap(loginId: self.loginId, shopId: self.shopId, serviceDetails: i, region: self.region)
                    } label: {
//                        ShopServiceList(user_id: self.loginId, serviceName: i.service_name, serviceDetails: i.service_details, servicePrice: i.price, serviceTime: i.required_time, serviceRating: i.shop_details.rating)
                        VStack {
                            Text(i.service_name)
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                
                VStack{
                    Text("Shop Details")
                        .font(.title2)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        .padding(.top)
                    
                    Map(coordinateRegion: $region, annotationItems: annotations) {
                        MapMarker(coordinate: $0.coordinate)
                    }
                    .frame(height: 400)
                    .cornerRadius(10)
                    
                    HStack{
                        
                        Text(shopName)
                            .font(.title3)
                            .bold()
                        
                        Spacer()
                        
                        Button {
                            let tel = "tel://\(shopContact)"
                            guard let url = URL(string: tel) else { return }
                            UIApplication.shared.open(url)
                        } label: {
                            Text("Call Store")
                                .bold()
                                .padding(.all, 10)
                                .foregroundColor(.blue)
                                .background(Color(.systemGray4))
                                .cornerRadius(5)
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
                    Button {
                        bookServiceActive.toggle()
                    } label: {
                        Text("Book Service")
                            .bold()
                            .padding(.all, 10)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .foregroundColor(.blue)
                            .background(Color(.systemGray4))
                            .cornerRadius(5)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 40)
                .cornerRadius(10)
                .navigationDestination(isPresented: $bookServiceActive, destination: {BookServiceForm(loginId: self.loginId, shopId: self.shopId)})
            }
            
            
        }
        .navigationTitle("Shop Details")
        .onAppear{
            getShopServiceList()
            print(loginId)
            print(shopId)
        }
//        .alert(isPresented: $showAlert, content: {
//            Alert(title: Text("Service Booked"), dismissButton: .default(Text("Got it!")))
//        })
        
    }
    
    func getShopServiceList() {
        
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

struct ServiceMapScreen_Previews: PreviewProvider {
    static var previews: some View {
        ServiceMapScreen(loginId: "1", shopId: "1", shopName: "Shop Name", shopContact: "1", region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    }
}
