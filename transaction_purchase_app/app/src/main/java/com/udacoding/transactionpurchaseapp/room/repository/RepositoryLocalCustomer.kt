package com.udacoding.transactionpurchaseapp.room.repository

import com.udacoding.transactionpurchaseapp.room.Database
import com.udacoding.transactionpurchaseapp.room.model.EntityCustomer
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers

import javax.inject.Inject

class RepositoryLocalCustomer @Inject constructor(
    private val database: Database,
    private val compositeDisposable: CompositeDisposable
) {

    fun insertCustomer(
        entityCustomer: EntityCustomer
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCustomer().insertCustomer(entityCustomer)
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())

    }

    fun deleteCustomerAll() {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCustomer().deleteCustomerAll()
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())

    }

    fun getCustomer(responseHandler: (List<EntityCustomer>) -> Unit) {
        compositeDisposable.add(Observable.fromCallable { database.daoCustomer().getCustomer() }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(it)
            }, {}))
    }

    fun searchCustomer(param: String?, responseHandler: (List<EntityCustomer>) -> Unit) {
        compositeDisposable.add(Observable.fromCallable { database.daoCustomer().searchCustomer("%$param%") }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(it)
            }, {}))
    }

}