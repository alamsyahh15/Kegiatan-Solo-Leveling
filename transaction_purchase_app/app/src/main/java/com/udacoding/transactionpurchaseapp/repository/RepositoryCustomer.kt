package com.udacoding.transactionpurchaseapp.repository

import com.udacoding.transactionpurchaseapp.network.ApiService
import com.udacoding.transactionpurchaseapp.view.home.customer.model.ResponseCustomer
import com.udacoding.transactionpurchaseapp.view.home.customer.model.ResponsePostCustomer
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers
import javax.inject.Inject

class RepositoryCustomer @Inject constructor(val api: ApiService?) {

    fun apiCustomerAll(
        id_company: Int?,
        responHandler: (ResponseCustomer) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        api?.getCustomerAll(id_company ?: 0)?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            })
    }

    fun apiSearchCustomer(
        id_company: Int?,
        customer_name: String?,
        responHandler: (ResponseCustomer) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        api?.searchCustomer(id_company ?: 0, customer_name ?: "")?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            })
    }

    fun apiPostCustomer(
        id_company: String,
        customer_name: String,
        customer_telp: String,
        customer_email: String,
        customer_address: String,
        photo: String,
        format: String,
        responHandler: (ResponsePostCustomer) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        api?.postCustomer(
            id_company,
            customer_name,
            customer_telp,
            customer_email,
            customer_address,
            photo,
            format
        )?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            })

    }


}