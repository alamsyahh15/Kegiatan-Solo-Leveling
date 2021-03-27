package com.udacoding.transactionpurchaseapp.view.home.history.model

import com.google.gson.annotations.SerializedName

data class ResponseDetailTransaction(

	@field:SerializedName("data")
	val data: List<DataItem?>? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class UserCompanyDetailTransaction(

	@field:SerializedName("user_status")
	val userStatus: String? = null,

	@field:SerializedName("user_email")
	val userEmail: String? = null,

	@field:SerializedName("is_active")
	val isActive: String? = null,

	@field:SerializedName("company_id")
	val companyId: Int? = null,

	@field:SerializedName("user_name")
	val userName: String? = null,

	@field:SerializedName("user_address")
	val userAddress: String? = null,

	@field:SerializedName("payment_status")
	val paymentStatus: String? = null,

	@field:SerializedName("api_token")
	val apiToken: Any? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("email_verified_at")
	val emailVerifiedAt: Any? = null,

	@field:SerializedName("id_user")
	val idUser: Int? = null,

	@field:SerializedName("id_paket_subscription")
	val idPaketSubscription: Int? = null,

	@field:SerializedName("user_ic_number")
	val userIcNumber: String? = null,

	@field:SerializedName("paid_at")
	val paidAt: Any? = null,

	@field:SerializedName("user_code")
	val userCode: String? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("user_telp")
	val userTelp: String? = null,

	@field:SerializedName("user_expired")
	val userExpired: String? = null,

	@field:SerializedName("cash_in_hand")
	val cashInHand: String? = null,

	@field:SerializedName("user_photo")
	val userPhoto: String? = null
)

data class Customer(

	@field:SerializedName("customer_address")
	val customerAddress: String? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("id_customer")
	val idCustomer: Int? = null,

	@field:SerializedName("customer_email")
	val customerEmail: String? = null,

	@field:SerializedName("id_company")
	val idCompany: Int? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("customer_name")
	val customerName: String? = null,

	@field:SerializedName("customer_telp")
	val customerTelp: String? = null,

	@field:SerializedName("customer_image")
	val customerImage: String? = null
)

data class DetailTransaksiItem(

	@field:SerializedName("product")
	val product: ProductItem? = null,

	@field:SerializedName("id_detail_transaction")
	val idDetailTransaction: Int? = null,

	@field:SerializedName("id_product")
	val idProduct: Int? = null,

	@field:SerializedName("total_item_price")
	val totalItemPrice: String? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("qty")
	val qty: String? = null,

	@field:SerializedName("id_transaction")
	val idTransaction: Int? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null
)

data class ProductItem(

	@field:SerializedName("is_active")
	val isActive: String? = null,

	@field:SerializedName("id_kategori")
	val idKategori: Int? = null,

	@field:SerializedName("product_image")
	val productImage: String? = null,

	@field:SerializedName("calc_price")
	val calcPrice: String? = null,

	@field:SerializedName("id_company")
	val idCompany: Int? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("product_price")
	val productPrice: String? = null,

	@field:SerializedName("product_name")
	val productName: String? = null,

	@field:SerializedName("product_desc")
	val productDesc: String? = null,

	@field:SerializedName("id_product")
	val idProduct: Int? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("diskon_type")
	val diskonType: String? = null,

	@field:SerializedName("product_stock")
	val productStock: String? = null,

	@field:SerializedName("is_promo")
	val isPromo: String? = null
)

data class DataItem(

	@field:SerializedName("transaction_code")
	val transactionCode: String? = null,

	@field:SerializedName("transaction_status")
	val transactionStatus: String? = null,

	@field:SerializedName("reason_void")
	val reasonVoid: String? = null,

	@field:SerializedName("produk_tambahan")
	val produkTambahan: List<Any?>? = null,

	@field:SerializedName("total_price")
	val totalPrice: String? = null,

	@field:SerializedName("id_customer")
	val idCustomer: Int? = null,

	@field:SerializedName("transaction_note")
	val transactionNote: String? = null,

	@field:SerializedName("latitude")
	val latitude: String? = null,

	@field:SerializedName("id_transaction")
	val idTransaction: Int? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("id_user")
	val idUser: Int? = null,

	@field:SerializedName("image_signature")
	val imageSignature: String? = null,

	@field:SerializedName("image_report")
	val imageReport: String? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("payment_method")
	val paymentMethod: String? = null,

	@field:SerializedName("longitude")
	val longitude: String? = null,

	@field:SerializedName("detail_transaksi")
	val detailTransaksi: List<DetailTransaksiItem?>? = null,

	@field:SerializedName("user_company")
	val userCompany: UserCompanyDetailTransaction? = null,

	@field:SerializedName("customer")
	val customer: Customer? = null
)
