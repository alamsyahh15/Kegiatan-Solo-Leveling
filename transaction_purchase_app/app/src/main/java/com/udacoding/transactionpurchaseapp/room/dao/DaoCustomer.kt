package com.udacoding.transactionpurchaseapp.room.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.udacoding.transactionpurchaseapp.room.model.EntityCustomer

@Dao
interface DaoCustomer {

    @Insert
    fun insertCustomer(customer: EntityCustomer)

    @Query("SELECT * FROM customer")
    fun getCustomer(): List<EntityCustomer>

    @Query("SELECT * FROM customer WHERE customer_name LIKE :param OR customer_telp LIKE :param")
    fun searchCustomer(param: String): List<EntityCustomer>

    @Query("DELETE FROM customer")
    fun deleteCustomerAll()

}