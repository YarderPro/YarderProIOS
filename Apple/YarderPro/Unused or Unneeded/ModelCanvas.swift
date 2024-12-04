//
//  ModelCanvas.swift
//  YarderPro
//
//  Created by Drew Hengehold on 10/15/24.
//

/*
 DESCRIPTION:
 A plan for the future, this is how the diagram will be created in the future, and the math for the diagram is layed out in documentation for the app. However the mathematics are complex and still a bit unclear. Unstanding the Canvas Library of swiftui is essential to creating this model.
 
 NOTE, THIS IS STILL IN PROGRESS AND THUS IS NOT FULLY COMMENTED FOR INSTILLED WITHIN THE APP
 */

import SwiftUI

struct ModelDrawing: View{
    let spanGround = 35
    let spanMidSpan = 75
    let canvasWidth: CGFloat = 360
    let canvasHeight: CGFloat = 300
    
    //let pointBY = (spanMidSpan * 10^(-2)) * canvasHeight
    let pointAX = 180
  //  let pointAY = (spanGround * 10^(-2)) *
    var body: some View{
        let pointBX = Int(canvasWidth) - 3
        let pointBY = canvasHeight - (Double(spanMidSpan) * 0.01 * Double(canvasHeight))
        let pointB = CGPoint(x:pointBX, y: Int(pointBY))
        let pointAX = Int(canvasWidth) / 2
        let pointAY = canvasHeight - (Double(spanGround) * 0.01 * Double(canvasHeight))
        let pointA = CGPoint(x:pointAX, y: Int(pointAY))
        let pointO = CGPoint(x:10, y:Int(canvasHeight/2))
        Canvas{context, size in
            context.draw(Image(systemName: "arrow.2.circlepath.circle"), at: pointO)
           
            //Point B
            context.draw(Image(systemName: "arrow.2.circlepath.circle"), at: pointA)
            
            //Point A
            context.draw(Image(systemName: "arrow.2.circlepath.circle"), at: pointB)
            
            var path = Path()
            path.move(to: pointO)
            path.addLine(to: pointA)
            path.addLine(to: pointB)
            context.stroke(path, with: .color(.black), lineWidth: 3)
            
        }
        .frame(width:canvasWidth, height:canvasHeight)
        .border(Color.black)
    }
    
}

struct ModelDrawing_Preview: PreviewProvider{
    static var previews: some View {
        ModelDrawing()
    }
}
