package com.udacoding.transactionpurchaseapp.room.model

import androidx.annotation.NonNull
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "customer")
data class EntityCustomer(
    @NonNull
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id")
    var id: Int? = null,

    @ColumnInfo(name = "id_customer")
    var id_customer: Int? = null,

    @ColumnInfo(name = "id_company")
    var id_company: Int? = null,

    @ColumnInfo(name = "customer_name")
    var customer_name: String? = null,

    @ColumnInfo(name = "customer_telp")
    var customer_telp: String? = null,

    @ColumnInfo(name = "customer_email")
    var customer_email: String? = null,

    @ColumnInfo(name = "customer_address")
    var customer_address: String? = null,

    @ColumnInfo(name = "customer_image")
    var customer_image: String? = null,

    @ColumnInfo(name = "created_at")
    var created_at: String? = null

)