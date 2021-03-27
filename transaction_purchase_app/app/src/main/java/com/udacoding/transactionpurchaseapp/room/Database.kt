package com.udacoding.transactionpurchaseapp.room

import androidx.room.Database
import androidx.room.RoomDatabase
import com.udacoding.transactionpurchaseapp.room.dao.*
import com.udacoding.transactionpurchaseapp.room.model.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.database.VERSION

@Database(entities = [EntityCart::class, EntityProduct::class, EntityCustomer::class, EntityPurchase::class, EntityPettyCash::class], version = VERSION, exportSchema = false)
abstract class Database : RoomDatabase() {
    abstract fun daoCart(): DaoCart
    abstract fun daoProduct(): DaoProduct
    abstract fun daoPurchase(): DaoPurchase
    abstract fun daoPettyCash(): DaoPettyCash
    abstract fun daoCustomer(): DaoCustomer
}