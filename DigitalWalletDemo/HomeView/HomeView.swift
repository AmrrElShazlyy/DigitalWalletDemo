//
//  HomeView.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 10/08/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var periodSelection: Period = .monthly
    var expenses: ExpensesData { viewModel.expensesData ?? .placeholder }

    var body: some View {
        VStack() {
            header
                .padding()
            IncomeExpenseView(expenses: expenses)
                .padding()

            progressSection
                .padding(.horizontal, 50)
                .padding(.bottom, 20)
            
            ContainerView {
                VStack {
                    insightsCard(expenses: expenses)
                        .padding(25)
                    timePeriodTabs
                        .padding(.horizontal, 30)
                    transactionsList(expenses: expenses)
                }
            }
        }
        .background(Color.greenBackground)
        .task {
            await viewModel.fetchData()
        }
    }
}

private extension HomeView {
    var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, Welcome Back")
                    .font(.title2.bold())
                    .foregroundColor(.black)
                Text("Good Morning")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            Spacer()
            Button {} label: {
                Image(systemName: "bell")
                    .font(.title3.weight(.semibold))
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.8))
                    )
            }
        }
    }
    
    func IncomeExpenseView(expenses: ExpensesData) -> some View {
        HStack(spacing: 4) {
            BalanceView(
                title: "Total Balance",
                imageName: "Income",
                value: expenses.totalBalance.asCurrency()
            )
            Divider()
                .frame(width: 1, height: 40)
                .background(.white)
            BalanceView(
                title: "Total Expense",
                imageName: "Expense",
                value: "-\(expenses.totalExpenses.asCurrency())",
                valueColor: .blue
            )
        }
    }
    
    var progressSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProgressBar(value: 30, total: 100)
            HStack(spacing: 8) {
                Image("check")
                Text("30% Of Your Expenses, Looks Good.")
                    .font(.footnote)
                    .foregroundColor(.black)
            }
        }
    }
    
    func insightsCard(expenses: ExpensesData) -> some View {
        HStack(spacing: 16) {
            VStack(spacing: 10) {
                CircularProgressBar(value: 0.5)
                Text("Savings\nOn Goals")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
            }
            
            Divider()
                .frame(width: 1.5)
                .background(.white)
            
            VStack(alignment: .leading, spacing: 12) {
                InsightRow(
                    icon: "Salary",
                    title: "Revenue Last Week",
                    value: expenses.revenue.asCurrency(),
                    valueColor: .black
                )
                HorizontalDivider(color: .white)
                InsightRow(
                    icon: "Food",
                    title: "Food Last Week",
                    value: "-\(expenses.foodCost.asCurrency())",
                    valueColor: .blue
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.greenBackground)
        )
    }
    
    var timePeriodTabs: some View {
        SegmentedTabs(selection: $periodSelection, tabs: Period.allCases.map(\.title))
    }
    
    func transactionsList(expenses: ExpensesData) -> some View {
        return VStack(spacing: 12) {
            TransactionRow(
                icon: "IconSalary",
                title: "Salary",
                subtitle: "18:27 – April 30",
                category: "Monthly",
                amount: expenses.salary,
                isExpense: false
            )
            TransactionRow(
                icon: "IconGroceries",
                title: "Groceries",
                subtitle: "18:27 – April 30",
                category: "Pantry",
                amount: expenses.groceries,
                isExpense: true
            )
            TransactionRow(
                icon: "IconSalary",
                title: "Rent",
                subtitle: "18:27 – April 30",
                category: "Rent",
                amount: expenses.rent,
                isExpense: true
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

private struct BalanceView: View {
    let title: String
    let imageName: String
    let value: String
    var valueColor: Color = .white
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(imageName)
                Text(title)
                    .font(.caption)
            }
            Text(value)
                .font(.title3.bold())
                .foregroundColor(valueColor)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ProgressBar: View {
    let value: Double
    let total: Double
    
    private var progress: CGFloat {
        guard total > 0 else { return 0 }
        let p = value / total
        return CGFloat(min(max(p, 0), 1))
    }
    
    var body: some View {
        // note: we can use here scaleEffect modifier on Capsule instead of using GeometryReader
        // i know that GeometryReader isn;t the best option as it makes heavy computation
        GeometryReader { geometry in
            let fillWidth = geometry.size.width * progress
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white)
                Capsule()
                    .fill(Color.black)
                    .frame(width: fillWidth, alignment: .leading)
                Text("\(Int(progress * 100))%")
                    .font(.caption.bold())
                    .foregroundColor(fillWidth > 20 ? Color.white : Color .black)
                    .padding(.horizontal, 15)
            }
        }
        .frame(height: 30)
    }
}

private struct CircularProgressBar: View {
    let value: Double
    var body: some View {
        ZStack {
            Circle().stroke(Color.white, lineWidth: 5)
            Circle()
                .trim(from: 0, to: min(max(value, 0), 1))
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 5)
                )
                .rotationEffect(.degrees(-90))
            Image("Car")
        }
    }
}

private struct InsightRow: View {
    let icon: String
    let title: String
    let value: String
    var valueColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding(8)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .shrinkToFit(0.8)
                Text(value)
                    .font(.subheadline.bold())
                    .foregroundColor(valueColor)
            }
        }
    }
}

struct HorizontalDivider: View {
    var color: Color = Color(.separator)
    var thickness: CGFloat = 1
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: thickness)
            .frame(maxWidth: .infinity)
    }
}

private struct TransactionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let category: String
    let amount: Double
    let isExpense: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(icon)
                .resizedToFill(width: 50, height: 50)
                .padding(.leading, 10)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body.weight(.semibold))
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.blue)
                    .shrinkToFit(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .frame(width: 1, height: 40)
                .background(.greenBackground)
            
            Text(category)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 60, alignment: .center)
            
            Divider()
                .frame(width: 1, height: 40)
                .background(.greenBackground)
            
            Text((isExpense ? "-" : "") + amount.asCurrency())
                .font(.body.weight(.semibold))
                .foregroundColor(isExpense ? .blue : .black)
                .frame(width: 80, alignment: .trailing)
        }
        .frame(height: 60)
        .padding(.vertical, 4)
    }
}


private struct SegmentedTabs: View {
    @Binding var selection: Period
    let tabs: [String]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { id, title in
                let period = Period.allCases[id]
                Button {
                    selection = period
                } label: {
                    Text(title)
                        .font(.subheadline)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .background(selection == period ? Color.greenBackground : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .circular))
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.lightGreen)
        )
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
