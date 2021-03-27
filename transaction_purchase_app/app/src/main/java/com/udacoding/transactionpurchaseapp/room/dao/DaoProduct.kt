package com.udacoding.transactionpurchaseapp.room.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.udacoding.transactionpurchaseapp.room.model.EntityProduct

@Dao
interface DaoProduct {

    @Insert
    fun insertProduct(entityProduct: EntityProduct)

    @Query("SELECT * FROM product")
    fun getProduct(): List<EntityProduct>

    @Query("DELETE FROM product")
    fun deleteProductAll()

}