package com.udacoding.transactionpurchaseapp.room.model

import androidx.annotation.NonNull
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "purchase")
data class EntityPurchase(
    @NonNull
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id")
    var id: Int? = null,

    @ColumnInfo(name = "id_purchase")
    var id_purchase: Int? = null,

    @ColumnInfo(name = "id_user")
    var id_user: Int? = null,

    @ColumnInfo(name = "purchase")
    var purchase: String? = null,

    @ColumnInfo(name = "note")
    var note: String? = null,

    @ColumnInfo(name = "image")
    var image: String? = null,

    @ColumnInfo(name = "created_at")
    var created_at: String? = null

)