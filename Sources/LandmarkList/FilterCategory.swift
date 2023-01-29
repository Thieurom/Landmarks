//
//  FilterCategory.swift
//  
//
//  Created by Doan Le Thieu on 29/01/2023.
//

public enum FilterCategory: String, CaseIterable, Equatable, Identifiable {

    case all = "All"
    case lakes = "Lakes"
    case rivers = "Rivers"
    case mountains = "Mountains"

    public var id: FilterCategory { self }
}
