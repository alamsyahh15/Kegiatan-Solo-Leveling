package com.udacoding.transactionpurchaseapp.view.home.history

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.udacoding.transactionpurchaseapp.repository.RepositoryUser
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.REJECTED
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.VOID
import com.udacoding.transactionpurchaseapp.view.home.history.model.DataItemHistory
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseDetailTransaction
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseTransactionByUser

class HistoryViewModel @ViewModelInject constructor(val repository: RepositoryUser) :
    ViewModel() {

    private val _history = MutableLiveData<ResponseTransactionByUser>()
    val history: LiveData<ResponseTransactionByUser> = _history

    private val _detail_transaction = MutableLiveData<ResponseDetailTransaction>()
    val detail_transaction: LiveData<ResponseDetailTransaction> = _detail_transaction

    private val _update_transaction = MutableLiveData<ResponseDetailTransaction>()
    val update_transaction: LiveData<ResponseDetailTransaction> = _update_transaction

    private val _success_void = MutableLiveData<Boolean>()
    val success_void: LiveData<Boolean> = _success_void

    private val _success_reject = MutableLiveData<Boolean>()
    val success_reject: LiveData<Boolean> = _success_reject

    private val _error = MutableLiveData<Throwable>()
    val error: LiveData<Throwable> = _error

    private val _loading = MutableLiveData<Boolean>()
    val loading: LiveData<Boolean> = _loading

    private val _is_empty = MutableLiveData<Boolean>()
    val is_empty: LiveData<Boolean> = _is_empty

    private val _empty_id_user = MutableLiveData<Boolean>()
    val empty_id_user: LiveData<Boolean> = _empty_id_user

    private val _empty_id_transaction = MutableLiveData<Boolean>()
    val empty_id_transaction: LiveData<Boolean> = _empty_id_transaction

    private val _empty_reason_void = MutableLiveData<Boolean>()
    val empty_reason_void: LiveData<Boolean> = _empty_reason_void

    private val _message = MutableLiveData<String>()
    val message: LiveData<String> = _message

    fun historyTransaction(
        id_user: Int,
        payment_method: String? = "",
        transaction_status: String? = ""
    ) {
        if (id_user == 0) {
            _empty_id_user.value = true
        } else {
            _loading.value = true
            repository.apiHistoryTransaction(
                id_user,
                payment_method ?: "",
                transaction_status ?: "",
                {

                    if (it.isSuccess == true) {
                        _history.value = it
                        _is_empty.value = false
                        _loading.value = false
                    } else {
                        _is_empty.value = true
                        _loading.value = false
                    }


                },
                {
                    _error.value = it
                    _loading.value = false
                })
        }
    }

    fun detailTransaction(id_transaction: Int) {
        if (id_transaction == 0) {
            _empty_id_transaction.value = true
        } else {
            _loading.value = true
            repository.apiDetailTransaction(id_transaction, {

                if (it.isSuccess == true) {
                    _detail_transaction.value = it
                    _is_empty.value = false
                    _loading.value = false
                } else {
                    _is_empty.value = true
                }


            }, {
                _error.value = it
                _loading.value = false
            })
        }
    }

    fun updateTransaction(
        id_transaction: Int,
        payment_method: String? = "",
        transaction_status: String? = "",
        reason_void: String? = ""
    ) {
        if (id_transaction == 0) {
            _empty_id_transaction.value = true
        } else if (transaction_status == VOID && reason_void == "") {
            _empty_reason_void.value = true
        } else {
            _loading.value = true
            repository.apiUpdateTransaction(
                id_transaction,
                payment_method,
                transaction_status,
                reason_void,
                {

                    if (it.isSuccess == true) {
                        if (transaction_status == VOID){
                            _success_void.value = true
                        } else if (transaction_status == REJECTED){
                            _success_reject.value = true
                        }
                        else {
                            _success_void.value = false
                            _success_reject.value = false
                            _update_transaction.value = it
                        }
                        _is_empty.value = false
                        _loading.value = false
                    } else {
                        _is_empty.value = true
                        _success_void.value = false
                        _message.value = it.message
                    }


                },
                {
                    _error.value = it
                    _loading.value = false
                })
        }
    }

}