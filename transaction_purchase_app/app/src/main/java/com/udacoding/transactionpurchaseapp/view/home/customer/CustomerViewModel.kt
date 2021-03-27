package com.udacoding.transactionpurchaseapp.view.home.customer

import android.util.Log
import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.udacoding.transactionpurchaseapp.repository.RepositoryCustomer
import com.udacoding.transactionpurchaseapp.room.model.EntityCustomer
import com.udacoding.transactionpurchaseapp.room.repository.RepositoryLocalCustomer
import com.udacoding.transactionpurchaseapp.utils.validationEmail
import com.udacoding.transactionpurchaseapp.view.home.customer.model.ResponseCustomer
import com.udacoding.transactionpurchaseapp.view.home.customer.model.ResponsePostCustomer

class CustomerViewModel @ViewModelInject constructor(
    val repository: RepositoryCustomer,
    val repositoryLocal: RepositoryLocalCustomer
) : ViewModel() {

    private val _customerAll = MutableLiveData<ResponseCustomer>()
    val customerAll: LiveData<ResponseCustomer> = _customerAll

    private val _data_customer_local = MutableLiveData<List<EntityCustomer>>()
    val data_customer_local: LiveData<List<EntityCustomer>> = _data_customer_local

    private val _postCustomer = MutableLiveData<ResponsePostCustomer>()
    val postCustomer: LiveData<ResponsePostCustomer> = _postCustomer

    private val _error = MutableLiveData<Throwable>()
    val error: LiveData<Throwable> = _error

    private val _loading = MutableLiveData<Boolean>()
    val loading: LiveData<Boolean> = _loading

    private val _empty = MutableLiveData<Boolean>()
    val empty: LiveData<Boolean> = _empty

    private val _empty_photo = MutableLiveData<Boolean>()
    val empty_photo: LiveData<Boolean> = _empty_photo

    private val _empty_id_company = MutableLiveData<Boolean>()
    val empty_id_company: LiveData<Boolean> = _empty_id_company

    private val _empty_name = MutableLiveData<Boolean>()
    val empty_name: LiveData<Boolean> = _empty_name

    private val _empty_telp = MutableLiveData<Boolean>()
    val empty_telp: LiveData<Boolean> = _empty_telp

    private val _empty_email = MutableLiveData<Boolean>()
    val empty_email: LiveData<Boolean> = _empty_email

    private val _email_invalid = MutableLiveData<Boolean>()
    val email_invalid: LiveData<Boolean> = _email_invalid

    private val _empty_address = MutableLiveData<Boolean>()
    val empty_address: LiveData<Boolean> = _empty_address

    private val _is_empty = MutableLiveData<Boolean>()
    val is_empty: LiveData<Boolean> = _is_empty

    fun getCustomerAll(id_company: Int?) {
        _loading.value = true
        repository.apiCustomerAll(id_company, {

            if (it.isSuccess == true) {

                _is_empty.value = false

                deleteCustomerLocal()

                for (i in it.data?.indices ?: 0..1) {
                    val item = it.data?.get(i)
                    saveCustomerLocal(
                        EntityCustomer(
                            null,
                            item?.idCustomer,
                            item?.idCompany,
                            item?.customerName,
                            item?.customerTelp,
                            item?.customerEmail,
                            item?.customerAddress,
                            item?.customerImage,
                            item?.createdAt
                        )
                    )

                    Log.d("viewModel", "getCustomer: $i, ${item?.customerName}")

                    if (i == it.data?.size?.minus(1)) {
                        _customerAll.value = it
                        _loading.value = false
                    }
                }
            } else {
                _is_empty.value = true
                _loading.value = false
            }

        }, {
            getCustomerLocal()
            _error.value = it
            _loading.value = false
        })
    }

    fun searchCustomer(id_company: Int?, customer_name: String?) {
        _loading.value = true
        repository.apiSearchCustomer(id_company, customer_name, {

            if (it.isSuccess == true) {

                _is_empty.value = false

                _customerAll.value = it
                _loading.value = false

            } else {

                _is_empty.value = true
                _loading.value = false

            }

        }, {
            _error.value = it
            _loading.value = false
        })
    }


    fun postCustomer(
        id_company: Int?,
        customer_name: String?,
        customer_telp: String?,
        customer_email: String?,
        customer_address: String?,
        photo: String?,
        format: String?
    ) {
        _loading.value = true
        if (photo?.equals("") == true) {
            _empty_photo.value = true
            _loading.value = false
        } else if (id_company?.equals(0) == true) {
            _empty_id_company.value = true
            _loading.value = false
        } else if (customer_name.equals("")) {
            _empty_name.value = true
            _loading.value = false
        } else if (customer_telp.equals("")) {
            _empty_telp.value = true
            _loading.value = false
        } else if (customer_email.equals("")) {
            _empty_email.value = true
            _loading.value = false
        } else if (!validationEmail(customer_email)) {
            _email_invalid.value = true
            _loading.value = false
        } else if (customer_address.equals("")) {
            _empty_address.value = true
            _loading.value = false
        } else {
            repository.apiPostCustomer(
                id_company.toString(),
                customer_name.toString(),
                customer_telp.toString(),
                customer_email.toString(),
                customer_address.toString(),
                photo.toString(),
                format.toString(),
                {
                    _postCustomer.value = it
                    _loading.value = false
                },
                {
                    _error.value = it
                    _loading.value = false
                })
        }
    }

    private fun saveCustomerLocal(entityCustomer: EntityCustomer) {
        repositoryLocal.insertCustomer(entityCustomer)
    }

    private fun getCustomerLocal() {
        repositoryLocal.getCustomer { _data_customer_local.value = it }
    }

    private fun deleteCustomerLocal() {
        repositoryLocal.deleteCustomerAll()
    }


}