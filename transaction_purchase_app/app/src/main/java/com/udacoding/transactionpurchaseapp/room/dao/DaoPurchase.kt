package com.udacoding.transactionpurchaseapp.room.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.udacoding.transactionpurchaseapp.room.model.EntityPurchase

@Dao
interface DaoPurchase {

    @Insert
    fun insertPurchase(purchase: EntityPurchase)

    @Query("SELECT * FROM purchase")
    fun getPurchase(): List<EntityPurchase>

    @Query("DELETE FROM purchase")
    fun deletePurchaseAll()

}