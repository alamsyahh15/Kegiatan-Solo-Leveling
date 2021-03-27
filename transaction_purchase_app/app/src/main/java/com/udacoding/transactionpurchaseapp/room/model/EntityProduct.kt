package com.udacoding.transactionpurchaseapp.room.model

import androidx.annotation.NonNull
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "product")
data class EntityProduct (
    @NonNull
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id")
    var id: Int? = null,

    @ColumnInfo(name = "id_product")
    var idProduct: Int? = null,

    @ColumnInfo(name = "id_company")
    var idCompany: Int? = null,

    @ColumnInfo(name = "product_name")
    var productName: String? = null,

    @ColumnInfo(name = "product_desc")
    var productDesc: String? = null,

    @ColumnInfo(name = "product_price")
    var productPrice: String? = null,

    @ColumnInfo(name = "product_image")
    var productImage: String? = null,

    @ColumnInfo(name = "product_stock")
    var productStock: Int? = null,

    @ColumnInfo(name = "qty")
    var createdAt: String? = null

)