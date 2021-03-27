package com.udacoding.transactionpurchaseapp.room.repository

import com.udacoding.transactionpurchaseapp.room.Database
import com.udacoding.transactionpurchaseapp.room.model.EntityProduct
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers

import javax.inject.Inject

class RepositoryLocalProduct @Inject constructor(
    private val database: Database,
    private val compositeDisposable: CompositeDisposable
) {

    fun insertProduct(
        entityProduct: EntityProduct
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoProduct().insertProduct(entityProduct)
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())

    }

    fun deleteProductAll() {
        compositeDisposable.add(Observable.fromCallable { database.daoProduct().deleteProductAll() }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())

    }

    fun getProduct(responseHandler: (List<EntityProduct>) -> Unit) {
        compositeDisposable.add(Observable.fromCallable { database.daoProduct().getProduct() }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(it)
            }, {}))
    }

}