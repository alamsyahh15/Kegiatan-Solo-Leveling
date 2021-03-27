package com.udacoding.transactionpurchaseapp.repository

import android.util.Log
import com.udacoding.transactionpurchaseapp.network.ApiService
import com.udacoding.transactionpurchaseapp.view.home.home.model.*
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers
import javax.inject.Inject

class RepositoryProduct @Inject constructor(
    val api: ApiService?,
    val compositeDisposable: CompositeDisposable?
) {

    fun apiProductByCompany(
        id: Int?,
        responHandler: (ResponseListProduct) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable?.add(
            api?.getProductByCompany(id ?: 0)?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                ?.subscribe({
                    responHandler(it)
                }, {
                    errorHandler(it)
                })
        )

    }

    fun apiSearchProduct(
        id: Int?,
        product_name: String?,
        responHandler: (ResponseListProduct) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable?.add(
            api?.searchProduct(id ?: 0, product_name ?: "")?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                ?.subscribe({
                    responHandler(it)
                }, {
                    errorHandler(it)
                })
        )

    }



    fun apiProductByCategory(
        id: Int?,
        id_category: Int?,
        responHandler: (ResponseListProduct) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable?.add(
            api?.getProductByCategory(id ?: 0, id_category ?: 0)?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                ?.subscribe({
                    responHandler(it)
                }, {
                    errorHandler(it)
                })
        )

    }

    fun apiKategoriByCompany(
        id: Int?,
        responHandler: (ResponseListKategori) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        compositeDisposable?.add(
            api?.getKategoriByCompany(id ?: 0)?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                ?.subscribe({
                    responHandler(it)
                }, {
                    errorHandler(it)
                })
        )
    }

    fun transaction(
        is_quotation: Boolean,
        image_required: Boolean,
        report: String,
        format_report: String,
        sign: String,
        format_sign: String,
        transaction: DataTransaction,
        detail_transaction: DetailTransaction,
        responseHandler: (Transaction) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {

        Log.d("TAG", "transaction: format_sign : $format_sign,\n" +
                "                transaction.idUser : ${transaction.idUser}\n" +
                "                quotation : ${is_quotation}\n" +
                "                transaction.idCustomer : ${transaction.idCustomer}\n" +
                "                transaction.transactionNote : ${transaction.transactionNote}\n" +
                "                transaction.totalPrice : ${transaction.totalPrice}\n" +
                "                transaction.latitude : ${transaction.latitude}\n" +
                "                transaction.longitude : ${transaction.longitude}\n" +
                "                transaction.paymentMethod : ${transaction.paymentMethod}\n" +
                "                detail_transaction.item_product : ${detail_transaction.item_product}\n" +
                "                detail_transaction.item_qty : ${detail_transaction.item_qty}\n" +
                "                detail_transaction.item_price : ${detail_transaction.item_price}")

        compositeDisposable?.add(
            api?.transaction(
                report, format_report, sign, format_sign,
                transaction.idUser ?: "",
                transaction.idCustomer ?: "",
                transaction.transactionNote ?: "",
                transaction.totalPrice ?: "",
                transaction.latitude ?: "",
                transaction.longitude ?: "",
                transaction.paymentMethod ?: "",
                is_quotation,
                image_required,
                detail_transaction.item_product,
                detail_transaction.item_qty,
                detail_transaction.item_price
//            detail_transaction.tambah_name,
//            detail_transaction.tambah_price,
//            detail_transaction.tambah_qty,
//            detail_transaction.tambah_total
            )?.observeOn(AndroidSchedulers.mainThread())
                ?.subscribeOn(Schedulers.io())
                ?.subscribe({
                    responseHandler(it)
                }, {
                    errorHandler(it)
                })

        )

    }

    fun onClear() {
        compositeDisposable?.clear()
    }
}