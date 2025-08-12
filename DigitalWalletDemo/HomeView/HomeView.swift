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

#Preview {
    HomeView(viewModel: HomeViewModel())
}
