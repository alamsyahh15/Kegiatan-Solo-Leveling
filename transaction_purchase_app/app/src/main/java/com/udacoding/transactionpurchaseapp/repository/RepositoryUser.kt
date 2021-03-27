package com.udacoding.transactionpurchaseapp.repository

import com.udacoding.transactionpurchaseapp.network.ApiService
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePettyCash
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePostPettyCash
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePostPurchase
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePurchase
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseDetailTransaction
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseTransactionByUser
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseDataIncome
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseProfileUser
import com.udacoding.transactionpurchaseapp.view.login.model.ResponseLogin
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.schedulers.Schedulers
import javax.inject.Inject

class RepositoryUser @Inject constructor(
    private val api: ApiService?,
    private val composite: CompositeDisposable
) {

    fun apiLogin(
        username: String?,
        password: String?,
        responHandler: (ResponseLogin) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.login(username ?: "", password ?: "")?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun apiHistoryTransaction(
        id_user: Int?,
        payment_method: String,
        transaction_status: String,
        responHandler: (ResponseTransactionByUser) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.historyTransaction(id_user ?: 0, payment_method, transaction_status)
            ?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            },{
                errorHandler(it)
            }))
    }

    fun apiDetailTransaction(
        id_transaction: Int?,
        responHandler: (ResponseDetailTransaction) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.detailTransaction(id_transaction ?: 0)
            ?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            },{
                errorHandler(it)
            }))
    }

    fun apiUpdateTransaction(
        id_transaction: Int?,
        payment_method: String? = "",
        transaction_status: String? = "",
        reason_void: String? = "",
        responHandler: (ResponseDetailTransaction) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.updateTransaction(id_transaction ?: 0, payment_method, transaction_status, reason_void)
            ?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            },{
                errorHandler(it)
            }))
    }

    fun apiProfileUser(
        id_user: Int?,
        responHandler: (ResponseProfileUser) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.getProfileUser(id_user ?: 0)?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun apiDataIncome(
        id_user: Int?,
        responHandler: (ResponseDataIncome) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.getDataIncomeByIdUser(id_user ?: 0)?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun apiPurchaseByUser(
        id_user: Int?,
        responHandler: (ResponsePurchase) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.getPurchaseByUser(id_user ?: 0)?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun apiPettyCashByUser(
        id_user: Int?,
        responHandler: (ResponsePettyCash) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.getPettyCashByUser(id_user ?: 0)?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))
    }

    fun apiPostPurchase(
        photo: String,
        format: String,
        id_user: String,
        purchase: String,
        note: String,
        responHandler: (ResponsePostPurchase) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.postPurchase(photo, format, id_user, purchase, note)?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))

    }

    fun apiPostPettyCash(
        photo: String,
        format: String,
        id_user: String,
        petty_cash: String,
        note: String,
        responHandler: (ResponsePostPettyCash) -> Unit,
        errorHandler: (Throwable) -> Unit
    ) {
        composite.add(api?.postPettyCash(photo, format, id_user, petty_cash, note)?.subscribeOn(Schedulers.io())
            ?.observeOn(AndroidSchedulers.mainThread())
            ?.subscribe({
                responHandler(it)
            }, {
                errorHandler(it)
            }))

    }

    fun onClear(){
        composite.clear()
    }

}