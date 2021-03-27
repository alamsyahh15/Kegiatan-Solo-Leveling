package com.udacoding.transactionpurchaseapp.room.repository

import com.udacoding.transactionpurchaseapp.room.Database
import com.udacoding.transactionpurchaseapp.room.model.EntityCart
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers
import javax.inject.Inject

class RepositoryLocalCart @Inject constructor(
    private val database: Database,
    private val compositeDisposable: CompositeDisposable
) {

    fun insertCart(
        entityCart: EntityCart,
        responseHandler: (Int) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCart().insertCart(entityCart)
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(200)
            }, {
                errorHandler(it)
            }))
    }

    fun getCart(
        responseHandler: (List<EntityCart>) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCart().getCart()
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun getTotalPay(
        responseHandler: (Double) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCart().getTotalPay()
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun getCartByIdProduk(
        id_produk: Int,
        responseHandler: (List<EntityCart>) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCart().getCartByIdProduk(id_produk)
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun updateQtyCart(
        id_produk: Int,
        qty: Int,
        total: Double,
        responseHandler: (Boolean) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCart().updateQtyCart(id_produk, qty, total)
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(true)
            },{
                errorHandler(it)
            }))
    }

    fun deleteCart(
        id_produk: Int,
        responseHandler: (Boolean) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCart().deleteCart(id_produk)
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                responseHandler(true)
            },{
                errorHandler(it)
            }))
    }

    fun deleteCartAll() {
        compositeDisposable.add(Observable.fromCallable {
            database.daoCart().deleteCartAll()
        }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe())
    }
}