//
//  CreateAssetView.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 04/05/24.
//

import SwiftUI

struct AssetFormView: View {
    @Environment(\.dismiss) var dismiss
    @State private var assetFormViewModel: AssetFormViewModel
    
    init(editingAsset: Asset?) {
        if let editingAsset = editingAsset {
            _assetFormViewModel = State(initialValue: AssetFormViewModel(asset: editingAsset))
            assetFormViewModel.isEditing = true
        } else {
            _assetFormViewModel = State(initialValue: AssetFormViewModel(asset: nil))
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Informações") {
                        TextField("Nome do Ativo", text: $assetFormViewModel.asset.name)
                        TextField("Descrição do Ativo", text: $assetFormViewModel.asset.description)
                    }
                    
                    Section("Próxima Manutenção") {
                        DatePicker("Data da Manutenção", selection: $assetFormViewModel.nextMaintanceAssetDataFormat, displayedComponents: .date)
                            .datePickerStyle(.automatic)
                            .onAppear {
                                assetFormViewModel.nextMaintanceAssetDataFormat = assetFormViewModel.initialNextMaintenanceDate
                            }
                    }
                    
                    Section("Preço") {
                        TextField("Valor do Ativo", value: $assetFormViewModel.asset.value,formatter: NumberFormatter())
                    }
                    
                    Section("Estado do Ativo") {
                        Picker("Status", selection: $assetFormViewModel.asset.status) {
                            ForEach(Status.allCases) { status in
                                Text(status.title).tag(status)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section(header: Text("Dependências")) {
                        ForEach(assetFormViewModel.asset.dependencies.indices, id: \.self) { index in
                            Text(assetFormViewModel.asset.dependencies[index].name)
                        }
                        .onDelete { indexSet in
                            assetFormViewModel.asset.dependencies.remove(atOffsets: indexSet)
                        }
                        
                        Button(action: {
                            assetFormViewModel.isAddingDependency.toggle()
                        }) {
                            Label("Adicionar Dependência", systemImage: "plus")
                        }
                    }

                }
                
                Button {
                    if assetFormViewModel.isEditing {
                        assetFormViewModel.updateAsset()
                        dismiss()
                    } else {
                        assetFormViewModel.postAsset()
                        dismiss()
                    }
                } label: {
                    if assetFormViewModel.isEditing {
                        Text("Salvar")
                            .fontWeight(.bold)
                    } else {
                        Text("Adicionar")
                            .fontWeight(.bold)
                    }
                }
                .disabled(assetFormViewModel.disableAssetForm)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(Color(.systemBlue))
            }
            .navigationTitle(assetFormViewModel.isEditing ? "Editar Ativo" : "Novo Ativo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundStyle(.black)
                }
            }
            .sheet(isPresented: $assetFormViewModel.isAddingDependency) {
                CreateDependencyView(assetFormViewModel: assetFormViewModel)
            }
        }
    }
}

#Preview {
    AssetFormView(editingAsset: nil)
}


struct CreateDependencyView: View {
    @State var assetFormViewModel: AssetFormViewModel
    
    var body: some View {
        VStack {
            Text("Nova Dependência")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
            
            Form {
                Section(header: Text("Informações")) {
                    TextField("Nome da Dependência", text: $assetFormViewModel.dependency.name)
                    TextField("Descrição da Dependência", text: $assetFormViewModel.dependency.description)
                    
                }
                
                Section("Estado da Dependência") {
                    Picker("Status", selection: $assetFormViewModel.dependency.status) {
                        ForEach(Status.allCases) { status in
                            Text(status.title).tag(status)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Próxima Manutenção") {
                    DatePicker("Data da Manutenção", selection: $assetFormViewModel.nextMaintanceDependencyDataFormat, displayedComponents: .date)
                        .datePickerStyle(.automatic)
                }
                
                Section("Preço da Dependência") {
                    TextField("Valor da Dependência", value: $assetFormViewModel.dependency.value,formatter: NumberFormatter())
                }
            }
            
            Button("Adicionar") {
                assetFormViewModel.addDependencyToAsset()
                assetFormViewModel.isAddingDependency = false
            }
            .disabled(assetFormViewModel.disableDependencyForm)
            .padding()
        }
        .background(Color(.systemGray6))
    }
}
