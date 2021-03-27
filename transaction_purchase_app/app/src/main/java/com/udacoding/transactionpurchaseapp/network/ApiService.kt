package com.udacoding.transactionpurchaseapp.network

import com.udacoding.transactionpurchaseapp.view.home.customer.model.ResponseCustomer
import com.udacoding.transactionpurchaseapp.view.home.customer.model.ResponsePostCustomer
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePettyCash
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePostPettyCash
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePostPurchase
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePurchase
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseDetailTransaction
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseTransactionByUser
import com.udacoding.transactionpurchaseapp.view.home.home.model.*
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseDataIncome
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseProfileUser
import com.udacoding.transactionpurchaseapp.view.login.model.ResponseLogin
import io.reactivex.rxjava3.core.Flowable
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Single
import retrofit2.http.*

interface ApiService {

    @GET("appConfig")
    fun getAppConfig(): Single<ResponseAppConfig>

    @GET("versionApp")
    fun getVersionApp(): Single<ResponseVersionApp>

    /*Endpoint User*/
    @FormUrlEncoded
    @POST("login")
    fun login(
        @Field("email") email: String,
        @Field("password") password: String
    ): Single<ResponseLogin>

    @FormUrlEncoded
    @POST("profileUser")
    fun getProfileUser(@Field("id_user") id_user: Int
    ): Single<ResponseProfileUser>

    @FormUrlEncoded
    @POST("companyById")
    fun getCompanyById(@Field("id_company") id_company: Int
    ): Single<ResponseCompanyById>

    @FormUrlEncoded
    @POST("pettyCashByUser")
    fun getPettyCashByUser(@Field("id_user") id_user: Int
    ): Flowable<ResponsePettyCash>

    @FormUrlEncoded
    @POST("purchaseByIdUser")
    fun getPurchaseByUser(@Field("id_user") id_user: Int
    ): Flowable<ResponsePurchase>

    @FormUrlEncoded
    @POST("getDataIncomeByIdUser")
    fun getDataIncomeByIdUser(@Field("id_user") id_user: Int
    ): Observable<ResponseDataIncome>

    @FormUrlEncoded
    @POST("createPurchase")
    fun postPurchase(
        @Field("photo") photo: String,
        @Field("format") format: String,
        @Field("id_user") id_user: String,
        @Field("purchase") purchase: String,
        @Field("note") note: String
    ): Single<ResponsePostPurchase>

    @FormUrlEncoded
    @POST("createPettyCash")
    fun postPettyCash(
        @Field("photo")_photo: String,
        @Field("format") format: String,
        @Field("id_user") id_user: String,
        @Field("petty_cash") purchase: String,
        @Field("note") note: String
        ): Single<ResponsePostPettyCash>

    @FormUrlEncoded
    @POST("customerByCompany")
    fun getCustomerAll(
        @Field("id_company") id_company: Int
    ): Flowable<ResponseCustomer>

    @FormUrlEncoded
    @POST("searchCustomer")
    fun searchCustomer(
        @Field("id_company") id_company: Int,
        @Field("customer_name") customer_name: String
    ): Flowable<ResponseCustomer>

    @FormUrlEncoded
    @POST("createCustomer")
    fun postCustomer(
        @Field("id_company") id_company: String,
        @Field("customer_name") customer_name: String,
        @Field("customer_telp") customer_telp: String,
        @Field("customer_email") customer_email: String,
        @Field("customer_address") customer_address: String,
        @Field("photo") photo: String,
        @Field("format") format: String
        ): Single<ResponsePostCustomer>

    /*Endpoint Product*/
    @FormUrlEncoded
    @POST("productByCompany")
    fun getProductByCompany(
        @Field("id_company") id_company: Int
    ): Flowable<ResponseListProduct>

    @FormUrlEncoded
    @POST("searchProduct")
    fun searchProduct(
        @Field("id_company") id_company: Int,
        @Field("product_name") product_name: String
    ): Flowable<ResponseListProduct>

    @FormUrlEncoded
    @POST("productByCategory")
    fun getProductByCategory(
        @Field("id_company") id_company: Int,
        @Field("id_kategori") id_kategori: Int
    ): Flowable<ResponseListProduct>

    @FormUrlEncoded
    @POST("kategoriByCompany")
    fun getKategoriByCompany(
        @Field("id_company") id_company: Int
    ): Flowable<ResponseListKategori>

    @FormUrlEncoded
    @POST("transactionByIdUser")
    fun historyTransaction(
        @Field("id_user") id_user: Int,
        @Field("payment_method") payment_method: String? = "",
        @Field("transaction_status") transaction_status: String? = ""
    ): Flowable<ResponseTransactionByUser>

    @FormUrlEncoded
    @POST("transactionById")
    fun detailTransaction(
        @Field("id_transaction") id_transaction: Int
    ): Flowable<ResponseDetailTransaction>

    @FormUrlEncoded
    @POST("updateTransaction")
    fun updateTransaction(
        @Field("id_transaction") id_transaction: Int,
        @Field("payment_method") payment_method: String? = "",
        @Field("transaction_status") transaction_status: String? = "",
        @Field("reason_void") reason_void: String? = ""
    ): Flowable<ResponseDetailTransaction>



    /*Endpoint Transaction*/
//    'id_user' => 'required',
//    'id_customer' => 'required',
//    'transaction_note' => 'required',
//    'total_price' => 'required',
//    'latitude' => 'required',
//    'longitude' => 'required',
//    'payment_method' => 'required'
    @FormUrlEncoded
    @POST("transaction")
    fun transaction(
        @Field("report") report: String,
        @Field("format_report") format_report: String,
        @Field("signature") signature: String,
        @Field("format_signature") format_signature: String,
        @Field("id_user") id_user: String,
        @Field("id_customer") id_customer: String,
        @Field("transaction_note") transaction_note: String,
        @Field("total_price") total_price: String,
        @Field("latitude") latitude: String,
        @Field("longitude") longitude: String,
        @Field("payment_method") payment_method: String,
        @Field("is_quotation") is_quotation: Boolean,
        @Field("image_required") image_required: Boolean,
        @Query("item_product[]") item_produk: ArrayList<String>,
        @Query("item_qty[]") item_qty: ArrayList<String>,
        @Query("item_price[]") item_price: ArrayList<String>
//        @Query("tambah_name[]") tambah_name: ArrayList<String>,
//        @Query("tambah_price[]") tambah_price: ArrayList<String>,
//        @Query("tambah_qty[]") tambah_qty: ArrayList<String>,
//        @Query("ambah_total[]") tambah_total: ArrayList<String>
    ): Single<Transaction>
}