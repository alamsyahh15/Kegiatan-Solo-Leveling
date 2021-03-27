package com.udacoding.transactionpurchaseapp.room.repository

import com.udacoding.transactionpurchaseapp.room.Database
import com.udacoding.transactionpurchaseapp.room.model.EntityPettyCash
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers

import javax.inject.Inject

class RepositoryLocalPettyCash @Inject constructor(
    private val database: Database,
    private val compositeDisposable: CompositeDisposable
) {

    fun insertPettyCash(
        entityPettyCash: EntityPettyCash
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoPettyCash().insertPettyCash(entityPettyCash)
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())

    }

    fun deletePettyCashAll() {
        compositeDisposable.add(Observable.fromCallable {
            database.daoPettyCash().deletePettyCashAll()
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())

    }

    fun getPettyCash(responseHandler: (List<EntityPettyCash>) -> Unit) {
        compositeDisposable.add(Observable.fromCallable { database.daoPettyCash().getPettyCash() }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(it)
            }, {}))
    }

}