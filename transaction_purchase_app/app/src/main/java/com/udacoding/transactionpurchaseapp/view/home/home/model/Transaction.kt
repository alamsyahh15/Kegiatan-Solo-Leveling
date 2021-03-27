package com.udacoding.transactionpurchaseapp.view.home.home.model

import com.google.gson.annotations.SerializedName

data class Transaction(

	@field:SerializedName("data")
	val data: DataTransaction? = null,

	@field:SerializedName("success")
	val success: String? = null
)

data class DataTransaction(

	@field:SerializedName("image_signature")
	val imageSignature: String? = null,

	@field:SerializedName("transaction_code")
	val transactionCode: String? = null,

	@field:SerializedName("image_report")
	val imageReport: String? = null,

	@field:SerializedName("total_price")
	val totalPrice: String? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("id_customer")
	val idCustomer: String? = null,

	@field:SerializedName("transaction_note")
	val transactionNote: String? = null,

	@field:SerializedName("latitude")
	val latitude: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("id_transaction")
	val idTransaction: Int? = null,

	@field:SerializedName("id_user")
	val idUser: String? = null,

	@field:SerializedName("payment_method")
	val paymentMethod: String? = null,

	@field:SerializedName("longitude")
	val longitude: String? = null
)
