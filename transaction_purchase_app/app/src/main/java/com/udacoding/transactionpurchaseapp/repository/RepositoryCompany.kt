package com.udacoding.transactionpurchaseapp.repository

import com.udacoding.transactionpurchaseapp.network.ApiService
import com.udacoding.transactionpurchaseapp.view.home.home.model.ResponseCompanyById
import com.udacoding.transactionpurchaseapp.view.login.model.ResponseLogin
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers
import javax.inject.Inject

class RepositoryCompany @Inject constructor(
    private val api: ApiService?,
    private val composite: CompositeDisposable
) {

    fun apiCompanyById(
        id_company: Int?,
        responHandler: (ResponseCompanyById) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.getCompanyById(id_company ?: 0)?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            })
        )
    }
}