package com.udacoding.transactionpurchaseapp.room.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.udacoding.transactionpurchaseapp.room.model.EntityPettyCash

@Dao
interface DaoPettyCash {

    @Insert
    fun insertPettyCash(petty_cash: EntityPettyCash)

    @Query("SELECT * FROM petty_cash")
    fun getPettyCash(): List<EntityPettyCash>

    @Query("DELETE FROM petty_cash")
    fun deletePettyCashAll()

}