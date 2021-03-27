package com.udacoding.transactionpurchaseapp.room.model

import androidx.annotation.NonNull
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "petty_cash")
data class EntityPettyCash(
    @NonNull
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id")
    var id: Int? = null,

    @ColumnInfo(name = "id_petty_cash")
    var id_petty_cash: Int? = null,

    @ColumnInfo(name = "id_user")
    var id_user: Int? = null,

    @ColumnInfo(name = "petty_cash")
    var petty_cash: String? = null,

    @ColumnInfo(name = "note")
    var note: String? = null,

    @ColumnInfo(name = "image")
    var image: String? = null,

    @ColumnInfo(name = "created_at")
    var created_at: String? = null

)