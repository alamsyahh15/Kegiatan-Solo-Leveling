package com.udacoding.transactionpurchaseapp.repository

import com.udacoding.transactionpurchaseapp.network.ApiService
import com.udacoding.transactionpurchaseapp.view.home.home.model.ResponseAppConfig
import com.udacoding.transactionpurchaseapp.view.home.home.model.ResponseVersionApp
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers
import javax.inject.Inject

class RepositoryApp @Inject constructor(
    private val api: ApiService?,
    private val composite: CompositeDisposable
) {

    fun apiAppConfig(
        responHandler : (ResponseAppConfig) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.getAppConfig()?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun apiVersionApp(
        responHandler: (ResponseVersionApp) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.getVersionApp()?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))
    }

}