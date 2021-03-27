package com.udacoding.transactionpurchaseapp.view.home.profile

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.udacoding.transactionpurchaseapp.repository.RepositoryUser
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseDataIncome
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseProfileUser

class ProfileViewModel @ViewModelInject constructor(val repository: RepositoryUser) : ViewModel() {

    private val _profileUser = MutableLiveData<ResponseProfileUser>()
    val profileUser: LiveData<ResponseProfileUser> = _profileUser

    private val _data_transfer = MutableLiveData<Double>()
    val data_transfer: LiveData<Double> = _data_transfer

//    private val _data_transfer = MutableLiveData<Double>()
//    val data_transfer: LiveData<Double> = _data_transfer

    private val _data_unpaid = MutableLiveData<Double>()
    val data_unpaid: LiveData<Double> = _data_unpaid

    private val _error = MutableLiveData<Throwable>()
    val error: LiveData<Throwable> = _error

    private val _loading = MutableLiveData<Boolean>()
    val loading: LiveData<Boolean> = _loading

    private val _empty = MutableLiveData<Boolean>()
    val empty: LiveData<Boolean> = _empty

    fun profileUser(
        id_user: Int
    ){
        _loading.value = true
        repository.apiProfileUser(id_user, {
            _profileUser.value = it
            _loading.value = false
        }, {
            _error.value = it
            _loading.value = false
        })
    }

    fun dataTransferByIdUser(
        id_user: Int
    ){
        _loading.value = true
        repository.apiDataIncome(id_user, {

            if (it.isSuccess == true){

                if (it.data?.totalTransfer?.total != null) {
                    _data_transfer.value = it.data.totalTransfer.total.toDouble()
                } else {
                    _data_transfer.value = 0.0
                }

                if (it.data?.totalUnpaid?.totalUnpaid != null){
                    _data_unpaid.value = it.data.totalUnpaid.totalUnpaid.toDouble()
                } else {
                    _data_unpaid.value = 0.0
                }
            }
            else {
                _data_transfer.value = 0.0
                _data_unpaid.value = 0.0
            }
            _loading.value = false

        }, {
            _error.value = it
            _loading.value = false
        })
    }


}