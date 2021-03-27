package com.udacoding.transactionpurchaseapp.view.home.finance

import android.util.Log
import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.udacoding.transactionpurchaseapp.repository.RepositoryUser
import com.udacoding.transactionpurchaseapp.room.model.EntityCustomer
import com.udacoding.transactionpurchaseapp.room.model.EntityPettyCash
import com.udacoding.transactionpurchaseapp.room.model.EntityPurchase
import com.udacoding.transactionpurchaseapp.room.repository.RepositoryLocalPettyCash
import com.udacoding.transactionpurchaseapp.room.repository.RepositoryLocalPurchase
import com.udacoding.transactionpurchaseapp.utils.encodeBase64
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePettyCash
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePostPettyCash
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePostPurchase
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePurchase

class FinanceViewModel @ViewModelInject constructor(
    val repository: RepositoryUser,
    val repositoryLocalPurchase: RepositoryLocalPurchase,
    val repositoryLocalPettyCash: RepositoryLocalPettyCash
) : ViewModel() {

    private val _purchaseByUser = MutableLiveData<ResponsePurchase>()
    val purchaseByUser: LiveData<ResponsePurchase> = _purchaseByUser

    private val _data_purchase_local = MutableLiveData<List<EntityPurchase>>()
    val data_purchase_local: LiveData<List<EntityPurchase>> = _data_purchase_local

    private val _data_petty_cash_local = MutableLiveData<List<EntityPettyCash>>()
    val data_petty_cash_local: LiveData<List<EntityPettyCash>> = _data_petty_cash_local

    private val _pettyCashByUser = MutableLiveData<ResponsePettyCash>()
    val pettyCashByUser: LiveData<ResponsePettyCash> = _pettyCashByUser

    private val _postPurchase = MutableLiveData<ResponsePostPurchase>()
    val postPurchase: LiveData<ResponsePostPurchase> = _postPurchase

    private val _postPettyCash = MutableLiveData<ResponsePostPettyCash>()
    val postPettyCash: LiveData<ResponsePostPettyCash> = _postPettyCash

    private val _error = MutableLiveData<Throwable>()
    val error: LiveData<Throwable> = _error

    private val _loading = MutableLiveData<Boolean>()
    val loading: LiveData<Boolean> = _loading

    private val _empty_photo = MutableLiveData<Boolean>()
    val empty_photo: LiveData<Boolean> = _empty_photo

    private val _empty_id_user = MutableLiveData<Boolean>()
    val empty_id_user: LiveData<Boolean> = _empty_id_user

    private val _empty_purchase = MutableLiveData<Boolean>()
    val empty_purchase: LiveData<Boolean> = _empty_purchase

    private val _empty_petty_cash = MutableLiveData<Boolean>()
    val empty_petty_cash: LiveData<Boolean> = _empty_petty_cash

    private val _empty_note = MutableLiveData<Boolean>()
    val empty_note: LiveData<Boolean> = _empty_note

    private val _is_empty = MutableLiveData<Boolean>()
    val is_empty: LiveData<Boolean> = _is_empty

    fun getPurchaseByUser(
        id_user: Int?
    ) {
        _loading.value = true
        repository.apiPurchaseByUser(id_user, {

            if (it.isSuccess == true){

                _is_empty.value = false

                deletePurchaseLocal()

                for (i in it.data?.indices ?: 0..1) {
                    val item = it.data?.get(i)
                    savePurchaseLocal(
                        EntityPurchase(
                            null,
                            item?.idPurchase,
                            item?.idUser,
                            item?.purchase,
                            item?.note,
                            item?.image,
                            item?.createdAt
                        )
                    )

                    Log.d("viewModel", "getCPurchase: $i, ${item?.purchase}")

                    if (i == it.data?.size?.minus(1)) {
                        _purchaseByUser.value = it
                        _loading.value = false
                    }
                }
            } else {
                _is_empty.value = true
                _loading.value = false
            }

        }, {
            getPurchaseLocal()
            _error.value = it
            _loading.value = false
        })
    }

    fun getPettyCashByUser(
        id_user: Int?
    ) {
        _loading.value = true
        repository.apiPettyCashByUser(id_user, {

            if (it.isSuccess == true){

                _is_empty.value = false

                deletePettyCashLocal()

                for (i in it.data?.indices ?: 0..1) {
                    val item = it.data?.get(i)
                    savePettyCashLocal(
                        EntityPettyCash(
                            null,
                            item?.idPettyCash,
                            item?.idUser,
                            item?.pettyCash,
                            item?.note,
                            item?.image,
                            item?.createdAt
                        )
                    )

                    Log.d("viewModel", "getPettyCash: $i, ${item?.pettyCash}")

                    if (i == it.data?.size?.minus(1)) {
                        _pettyCashByUser.value = it
                        _loading.value = false
                    }
                }
            } else {
                _is_empty.value = true
                _loading.value = false
            }

        }, {
            getPettyCashLocal()
            _error.value = it
            _loading.value = false
        })
    }

    fun postPurchase(
        photo: String?,
        format: String?,
        id_user: Int?,
        nominal: String?,
        note: String?
    ) {
        if (photo?.equals("") == true) {
            _empty_photo.value = true
            _loading.value = false
        } else if (id_user?.equals(0) == true) {
            _empty_id_user.value = true
            _loading.value = false
        } else if (nominal.equals("")) {
            _empty_purchase.value = true
            _loading.value = false
        } else if (note.equals("")) {
            _empty_note.value = true
            _loading.value = false
        } else {
            _loading.value = true
            repository.apiPostPurchase(
                encodeBase64(photo.toString()),
                format.toString(),
                id_user.toString(),
                nominal.toString(),
                note.toString(),
                {
                    _postPurchase.value = it
                    _loading.value = false
                },
                {
                    _error.value = it
                    _loading.value = false
                })
        }
    }

    fun postPettyCash(
        photo: String?,
        format: String?,
        id_user: Int?,
        nominal: String?,
        note: String?
    ) {
        if (photo?.equals("") == true) {
            _empty_photo.value = true
            _loading.value = false
        } else if (id_user?.equals(0) == true) {
            _empty_id_user.value = true
            _loading.value = false
        } else if (nominal.equals("")) {
            _empty_petty_cash.value = true
            _loading.value = false
        } else if (note.equals("")) {
            _empty_note.value = true
            _loading.value = false
        } else {
            _loading.value = true
            repository.apiPostPettyCash(
                encodeBase64(photo.toString()),
                format.toString(),
                id_user.toString(),
                nominal.toString(),
                note.toString(),
                {
                    _postPettyCash.value = it
                    _loading.value = false
                },
                {
                    _error.value = it
                    _loading.value = false
                })
        }
    }

    private fun savePurchaseLocal(entityPurchase: EntityPurchase) {
        repositoryLocalPurchase.insertPurchase(entityPurchase)
    }

    private fun getPurchaseLocal() {
        repositoryLocalPurchase.getPurchase { _data_purchase_local.value = it }
    }

    private fun deletePurchaseLocal() {
        repositoryLocalPurchase.deletePurchaseAll()
    }

    private fun savePettyCashLocal(entityPettyCash: EntityPettyCash) {
        repositoryLocalPettyCash.insertPettyCash(entityPettyCash)
    }

    private fun getPettyCashLocal() {
        repositoryLocalPettyCash.getPettyCash { _data_petty_cash_local.value = it }
    }

    private fun deletePettyCashLocal() {
        repositoryLocalPettyCash.deletePettyCashAll()
    }

}