//
//  HeatmapView.swift
//  Countorama
//
//  Created by Raj Singh on 15/01/25.
//
import SwiftUI
import Charts

struct HeatmapDataPoint: Identifiable {
    let id = UUID()
    let x: Int
    let y: Int
    let value: Double
}

struct HeatmapChartView: View {
    let data: [HeatmapDataPoint] = {
        var points = [HeatmapDataPoint]()
        for x in 0..<10 {
            for y in 0..<3 {
                let value = Double.random(in: 0...1)
                points.append(HeatmapDataPoint(x: x, y: y, value: value))
            }
        }
        return points
    }()

    var body: some View {
        Chart {
            ForEach(data) { point in
                RectangleMark(
                    x: .value("", point.x),
                    y: .value("", point.y),
                    width: .fixed(20),
                    height: .fixed(20)
                )
                .foregroundStyle(Color.pink.opacity(point.value*2))
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: 1))
                
        }
        
        .chartYAxis {
            AxisMarks(values: .stride(by: 1))
        }
        .padding()
       
    }
}

#Preview {
    HeatmapChartView()
}
