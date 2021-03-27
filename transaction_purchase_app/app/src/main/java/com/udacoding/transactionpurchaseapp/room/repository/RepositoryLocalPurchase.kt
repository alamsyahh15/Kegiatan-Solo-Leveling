package com.udacoding.transactionpurchaseapp.room.repository

import com.udacoding.transactionpurchaseapp.room.Database
import com.udacoding.transactionpurchaseapp.room.model.EntityPurchase
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers

import javax.inject.Inject

class RepositoryLocalPurchase @Inject constructor(
    private val database: Database,
    private val compositeDisposable: CompositeDisposable
) {

    fun insertPurchase(
        entityPurchase: EntityPurchase
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoPurchase().insertPurchase(entityPurchase)
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())

    }

    fun deletePurchaseAll() {
        compositeDisposable.add(Observable.fromCallable {
            database.daoPurchase().deletePurchaseAll()
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())

    }

    fun getPurchase(responseHandler: (List<EntityPurchase>) -> Unit) {
        compositeDisposable.add(Observable.fromCallable { database.daoPurchase().getPurchase() }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(it)
            }, {}))
    }

}