package com.udacoding.transactionpurchaseapp.view.home.home.viewmodel

import android.util.Log
import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.repository.RepositoryApp
import com.udacoding.transactionpurchaseapp.repository.RepositoryCompany
import com.udacoding.transactionpurchaseapp.repository.RepositoryProduct
import com.udacoding.transactionpurchaseapp.room.model.EntityCart
import com.udacoding.transactionpurchaseapp.room.model.EntityCustomer
import com.udacoding.transactionpurchaseapp.room.model.EntityProduct
import com.udacoding.transactionpurchaseapp.room.repository.RepositoryLocalCart
import com.udacoding.transactionpurchaseapp.room.repository.RepositoryLocalCustomer
import com.udacoding.transactionpurchaseapp.room.repository.RepositoryLocalProduct
import com.udacoding.transactionpurchaseapp.view.home.home.model.*

class HomeViewModel @ViewModelInject constructor(
    val repository: RepositoryProduct,
    val repositoryApp: RepositoryApp,
    val repositoryLocalProduct: RepositoryLocalProduct,
    val repositoryLocalCart: RepositoryLocalCart,
    val repositoryLocalCustomer: RepositoryLocalCustomer,
    val repositoryCompany: RepositoryCompany,
    val session: SessionManager
) : ViewModel() {

    private val _app_config = MutableLiveData<ResponseAppConfig>()
    val app_config: LiveData<ResponseAppConfig> = _app_config

    private val _version_app = MutableLiveData<ResponseVersionApp>()
    val version_app: LiveData<ResponseVersionApp> = _version_app

    private val _companyById = MutableLiveData<ResponseCompanyById>()
    val companyById: LiveData<ResponseCompanyById> = _companyById

    private var _transactionResponse = MutableLiveData<Transaction>()
    val transactionResponse: LiveData<Transaction> = _transactionResponse

    private val _productByCompany = MutableLiveData<ResponseListProduct>()
    val productByCompany: LiveData<ResponseListProduct> = _productByCompany

    private val _kategoriByCompany = MutableLiveData<ResponseListKategori>()
    val kategoriByCompany: LiveData<ResponseListKategori> = _kategoriByCompany

    private val _data_product_local = MutableLiveData<List<EntityProduct>>()
    val data_product_local: LiveData<List<EntityProduct>> = _data_product_local

    private val _data_cart_local = MutableLiveData<List<EntityCart>>()
    val data_cart_local: LiveData<List<EntityCart>> = _data_cart_local

    private val _data_customer_local = MutableLiveData<List<EntityCustomer>>()
    val data_customer_local: LiveData<List<EntityCustomer>> = _data_customer_local

    private val _add_to_cart = MutableLiveData<Boolean>()
    val add_to_cart: LiveData<Boolean> = _add_to_cart

    private val _available_on_cart = MutableLiveData<List<EntityCart>>()
    val available_on_cart: LiveData<List<EntityCart>> = _available_on_cart

    private val _update_qty_cart = MutableLiveData<Boolean>()
    val update_qty_cart: LiveData<Boolean> = _update_qty_cart

    private val _delete_cart = MutableLiveData<Boolean>()
    val delete_cart: LiveData<Boolean> = _delete_cart

    private val _count = MutableLiveData<Int>()
    val count: LiveData<Int> = _count

    private val _total_item_pay = MutableLiveData<Double>()
    val total_item_pay: LiveData<Double> = _total_item_pay

    private val _total_pay = MutableLiveData<Double>()
    val total_pay: LiveData<Double> = _total_pay

    private val _text_total_pay = MutableLiveData<Boolean>()
    val text_total_pay: LiveData<Boolean> = _text_total_pay

    private val _button_plus = MutableLiveData<Boolean>()
    val button_plus: LiveData<Boolean> = _button_plus

    private val _button_minus = MutableLiveData<Boolean>()
    val button_minus: LiveData<Boolean> = _button_minus

    private val _empty_qty = MutableLiveData<Boolean>()
    val empty_qty: LiveData<Boolean> = _empty_qty

    private val _empty_report = MutableLiveData<Boolean>()
    val empty_report: LiveData<Boolean> = _empty_report

    private val _empty_customer_id = MutableLiveData<Boolean>()
    val empty_customer_id: LiveData<Boolean> = _empty_customer_id

    private val _empty_note = MutableLiveData<Boolean>()
    val empty_note: LiveData<Boolean> = _empty_note

    private val _empty_format_report = MutableLiveData<Boolean>()
    val empty_format_report: LiveData<Boolean> = _empty_format_report

    private val _empty_sign = MutableLiveData<Boolean>()
    val empty_sign: LiveData<Boolean> = _empty_sign

    private val _empty_format_sign = MutableLiveData<Boolean>()
    val empty_format_sign: LiveData<Boolean> = _empty_format_sign

    private val _empty_data_transaction = MutableLiveData<Boolean>()
    val empty_data_transaction: LiveData<Boolean> = _empty_data_transaction

    private val _empty_detail_transaction = MutableLiveData<Boolean>()
    val empty_detail_transaction: LiveData<Boolean> = _empty_detail_transaction

    private val _error = MutableLiveData<Throwable>()
    val error: LiveData<Throwable> = _error

    private val _loading = MutableLiveData<Boolean>()
    val loading: LiveData<Boolean> = _loading

    private val _is_empty = MutableLiveData<Boolean>()
    val is_empty: LiveData<Boolean> = _is_empty


    fun appConfig(){
        repositoryApp.apiAppConfig({
            _app_config.value = it
        }, {
            _error.value = it
        })
    }

    fun versionApp(){
        repositoryApp.apiVersionApp({
            _version_app.value = it
        }, {
            _error.value = it
        })
    }

    fun getCompanyById(id_company: Int){
        repositoryCompany.apiCompanyById(id_company, {
            _companyById.postValue(it)
        }, {
            _error.postValue(it)
        })
    }

    fun actionCount(flag_action: Int, last_count: Int, stock: Int, price: Double) {
        when (flag_action) {
            0 -> {
                _count.value = last_count.minus(1)
                _total_item_pay.value = count.value?.times(price)
                if (last_count in 2..stock) {
                    _button_plus.value = true
                    _button_minus.value = true
                } else if (last_count in 1..2) {
                    _button_minus.value = false
                    _button_plus.value = true
                }
            }
            1 -> {
                _count.value = last_count.plus(1)
                _total_item_pay.value = count.value?.times(price)
                if (last_count >= 0 && last_count < stock - 1) {
                    _button_minus.value = true
                } else if (last_count >= stock - 1) {
                    _button_plus.value = false
                    _button_minus.value = true
                }
            }
        }
    }

    fun getProductByCompany(
        id: Int?
    ) {
        _loading.value = true
        repository.apiProductByCompany(id, {

            if (it.isSuccess == true){

                _is_empty.value = false

                deleteProductLocal()

                for (i in it.data?.indices ?: 0..1) {
                    val item = it.data?.get(i)
                    saveProductLocal(
                        EntityProduct(
                            null,
                            item?.idProduct,
                            item?.idCompany,
                            item?.productName,
                            item?.productDesc,
                            item?.productPrice,
                            item?.productImage,
                            item?.productStock?.toInt(),
                            item?.createdAt
                        )
                    )

                    Log.d("viewModel", "getProductByCompany: $i, ${item?.productName}")

                    if (i == it.data?.size?.minus(1)) {
                        _productByCompany.value = it
                        _loading.value = false
                    }
                }
            } else {

                _is_empty.value = true
                _loading.value = false

            }

        }, {
            getProductLocal()
            _error.value = it
            _loading.value = false
        })
    }

    fun searchProduct(
        id: Int?,
        product_name: String
    ) {
        _loading.value = true
        repository.apiSearchProduct(id, product_name, {

            if (it.isSuccess == true){

                _is_empty.value = false

                deleteProductLocal()

                for (i in it.data?.indices ?: 0..1) {
                    val item = it.data?.get(i)
                    saveProductLocal(
                        EntityProduct(
                            null,
                            item?.idProduct,
                            item?.idCompany,
                            item?.productName,
                            item?.productDesc,
                            item?.productPrice,
                            item?.productImage,
                            item?.productStock?.toInt(),
                            item?.createdAt
                        )
                    )

                    Log.d("viewModel", "getProductByCompany: $i, ${item?.productName}")

                    if (i == it.data?.size?.minus(1)) {
                        _productByCompany.value = it
                        _loading.value = false
                    }
                }
            } else {

                _is_empty.value = true
                _loading.value = false

            }

        }, {
            getProductLocal()
            _error.value = it
            _loading.value = false
        })
    }


    fun getProductByCategory(
        id: Int?,
        id_category: Int?
    ) {
        _loading.value = true
        repository.apiProductByCategory(id, id_category, {

            if (it.isSuccess == true){

                _is_empty.value = false

                deleteProductLocal()

                for (i in it.data?.indices ?: 0..1) {
                    val item = it.data?.get(i)
                    saveProductLocal(
                        EntityProduct(
                            null,
                            item?.idProduct,
                            item?.idCompany,
                            item?.productName,
                            item?.productDesc,
                            item?.productPrice,
                            item?.productImage,
                            item?.productStock?.toInt(),
                            item?.createdAt
                        )
                    )

                    Log.d("viewModel", "getProductByCompany: $i, ${item?.productName}")

                    if (i == it.data?.size?.minus(1)) {
                        _productByCompany.value = it
                        _loading.value = false
                    }
                }
            } else {
                _is_empty.value = true
                _loading.value = false
            }



        }, {
            getProductLocal()
            _error.value = it
            _loading.value = false
        })
    }


    fun getKategoriByCompany(
        id: Int?
    ) {
        _loading.value = true
        repository.apiKategoriByCompany(id, {
            _kategoriByCompany.value = it
            _loading.value = false
        }, {
            _error.value = it
            _loading.value = false
        })
    }

    fun getCartLocal() {
        repositoryLocalCart.getCart({
            _data_cart_local.value = it
            Log.d("TAG", "getCartLocal: $it")
            if (it.isNotEmpty()) {
                _text_total_pay.value = true
                getTotalPay()
            } else {
                _text_total_pay.value = false
            }
        }, {
            _error.value = it
        })
    }

    fun addToCart(entityCart: EntityCart) {
        repositoryLocalCart.insertCart(entityCart, {
            when (it) {
                200 -> _add_to_cart.value = true
            }
        }, {
            _error.value = it
        })
    }

    fun getTotalPay() {
        repositoryLocalCart.getTotalPay({
            _total_pay.value = it
            Log.d("TAG", "getTotalPay: $it")
        }, {
            _error.value = it
        })
    }

    fun checkAvailableOnCart(id_produk: Int) {
        repositoryLocalCart.getCartByIdProduk(id_produk, {
            _available_on_cart.value = it
        }, {
            _error.value = it
        })
    }

    fun updateQtyCart(
        id_produk: Int,
        qty: Int,
        total: Double
    ) {
        repositoryLocalCart.updateQtyCart(id_produk, qty, total, {
            _update_qty_cart.value = it
        }, {
            _error.value = it
        })
    }

    fun transaction(
        id_customer: String,
        report: String?,
        format_report: String?,
        sign: String?,
        format_sign: String?,
        dataTransaction: DataTransaction,
        detail: DetailTransaction
    ) {

        if (id_customer.equals("") || id_customer.equals(null)){
            _empty_customer_id.postValue(true)
        } else if (dataTransaction.transactionNote.equals("") || dataTransaction.transactionNote.equals(null)){
            _empty_note.postValue(true)
        } else if (report.equals("") && !session.quotation && session.required_image || report.equals(null)){
            _empty_report.postValue(true)
        } else if (format_report.equals("") && !session.quotation && session.required_image || format_report.equals(null)) {
            _empty_format_report.postValue(true)
        } else if(sign.equals("") && !session.quotation && session.required_image || sign.equals(null)){
            _empty_sign.postValue(true)
        } else if (format_sign.equals("") && !session.quotation && session.required_image || format_sign.equals(null)){
            _empty_format_sign.postValue(true)
        } else if (dataTransaction.equals(null)){
            _empty_data_transaction.postValue(true)
        } else if (detail.equals(null)){
            _empty_detail_transaction.postValue(true)
        } else {
            _loading.postValue(true)
            repository.transaction(session.quotation, session.required_image,report ?: "", format_report ?: "", sign ?: "", format_sign ?: "", dataTransaction, detail,
                {
                    _loading.postValue(false); _transactionResponse.postValue(it)
                }, {
                    _loading.postValue(false); _error.postValue(it)
                })
        }
    }

    fun deleteCart(
        id_produk: Int
    ) {
        repositoryLocalCart.deleteCart(id_produk, {
            _delete_cart.value = it
        }, {
            _error.value = it
        })
    }

    private fun saveProductLocal(entityProduct: EntityProduct) {
        repositoryLocalProduct.insertProduct(entityProduct)
    }

    private fun getProductLocal() {
        repositoryLocalProduct.getProduct { _data_product_local.value = it }
    }

    fun deleteProductLocal() {
        repositoryLocalProduct.deleteProductAll()
    }

    fun deleteCartAll() {
        repositoryLocalCart.deleteCartAll()
    }

    fun getCustomerLocal() {
        repositoryLocalCustomer.getCustomer { _data_customer_local.value = it }
    }

    fun searchCustomerLocal(param: String?) {
        repositoryLocalCustomer.searchCustomer(param) { _data_customer_local.value = it }
    }

}
