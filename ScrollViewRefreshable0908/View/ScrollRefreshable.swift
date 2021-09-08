//
//  ScrollRefreshable.swift
//  ScrollViewRefreshable0908
//
//  Created by 张亚飞 on 2021/9/8.
//

import SwiftUI

//note it will use apple's refreshable modifier...
//not any form uikit...

struct ScrollRefreshable<Content: View>: View {
    
    var content: Content
    
    var onRefresh: () async ->()
    
    init(title: String, tintColor: Color, @ViewBuilder content: @escaping () -> Content, onRefresh:@escaping () async ->()) {
        
        self.content = content()
        self.onRefresh = onRefresh
        
        //modifying refresh control...
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title)
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
    }
    
    
    var body: some View {
        
        List {
            
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            
            await onRefresh()
        }
    }
}

struct ScrollRefreshable_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
