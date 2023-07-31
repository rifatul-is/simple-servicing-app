//
//  test.swift
//  Service It
//
//  Created by Rifatul Islam on 18/6/23.
//

import SwiftUI
import MapKit

struct ServiceDetailsFromMap: View {
    @State var showAlert : Bool = false
    
    @State var loginId : String
    @State var shopId : String
    @State var serviceDetails : ServiceDetails
    
    @State var bookServiceActive = false
    
    @State var region : MKCoordinateRegion
    
    var body: some View {
        
        let annotations = [
            SerciveShopLocation(name: "Shop", coordinate: CLLocationCoordinate2D(latitude: region.center.latitude , longitude: region.center.longitude))
        ]
        
        ZStack(alignment: .top){
            
            ScrollView(showsIndicators: false) {
                
                VStack{
                    
                    Map(coordinateRegion: $region, annotationItems: annotations) {
                        MapMarker(coordinate: $0.coordinate)
                    }
                    .frame(height: 400)
                    .cornerRadius(10)
                    
                    
                    
                    Text(serviceDetails.shop_details.shop_name)
                        .font(.title2)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        .padding(.top)
                    
                    Text(serviceDetails.service_details)
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    
                    Text("Pricing : \(serviceDetails.price)")
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        .padding(.top, 1)
                    
                    
                    Text("Time Required : \(serviceDetails.required_time)")
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    
                    Text("Rating : \(serviceDetails.required_time) ☆ ")
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    
                    
                    HStack{
                        
                        Text(serviceDetails.shop_details.shop_name)
                            .font(.title3)
                            .bold()
                        
                        Spacer()
                        
                        Button {
                            let tel = "tel://\(serviceDetails.shop_details.contact_number)"
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
        .navigationTitle(serviceDetails.service_name)
        .onAppear{
            print(loginId)
            print(shopId)
        }
//        .alert(isPresented: $showAlert, content: {
//            Alert(title: Text("Service Booked"), dismissButton: .default(Text("Got it!")))
//        })
        
    }
}

struct ServiceDetailsFromMap_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailsFromMap(loginId: "Text", shopId: "Text", serviceDetails: ServiceDetails(service_id: "Text", service_type_id: "Text", service_name: "Text", service_details: "Text", price: "Text", required_time: "Text", shop_id: "Text", shop_details: ShopDetails(shop_id: "Text", shop_name: "Text", location: "Text", contact_number: "Text", image: "Text", rating: "Text")), region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
}
