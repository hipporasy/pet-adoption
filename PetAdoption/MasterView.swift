//
//  MasterView.swift
//  PetAdoption
//
//  Created by Marasy Phi on 23/1/21.
//

import SwiftUI

struct MasterView: View {
    
    @State var selectedTabBarType: TabBarType = .home
    
    enum TabBarType: String, Identifiable, CaseIterable {
        
        case home, message, favorite, profile
        
        var image: String {
            "ic.\(rawValue)"
        }
        
        var id: String {
            rawValue.capitalized
        }
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    switch selectedTabBarType {
                    case .home:
                        HomeView()
                    default:
                        Color.white
                    }

                    HStack {
                        ForEach(TabBarType.allCases) { eachTab in
                            Spacer()
                            TabBarItemView(tabBarType: eachTab, isActive: eachTab == selectedTabBarType)
                                .onTapGesture {
                                    selectedTabBarType = eachTab
                                }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: geometry.safeAreaInsets.bottom + 49)
                    .overlay(Divider(), alignment: .top)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            
        }
    }
    
}

struct TabBarItemView: View {
    
    var tabBarType: MasterView.TabBarType
    
    var isActive: Bool
    
    var body: some View {
        HStack {
            Image(tabBarType.image)
            isActive ? Text(tabBarType.id)
                .font(.system(size: 14, weight: .regular))
                .lineLimit(1)
                .frame(width: 50) : nil
        }
        .padding(6)
        .foregroundColor(isActive ? .white : .accent)
        .background(isActive ? Color.primaryDark : .clear)
        .cornerRadius(isActive ? 16 : 0)
    }
    
}

struct MasterViewPreview: PreviewProvider {
    
    static var previews: some View {
        MasterView()
    }
    
}
