package com.udacoding.transactionpurchaseapp.view.home.customer.model

import com.google.gson.annotations.SerializedName

data class ResponsePostCustomer(

	@field:SerializedName("data")
	val data: DataPostCustomer? = null,

	@field:SerializedName("success")
	val success: Boolean? = null
)

data class DataPostCustomer(

	@field:SerializedName("customer_address")
	val customerAddress: String? = null,

	@field:SerializedName("customer_email")
	val customerEmail: String? = null,

	@field:SerializedName("id_company")
	val idCompany: String? = null,

	@field:SerializedName("customer_name")
	val customerName: String? = null,

	@field:SerializedName("customer_telp")
	val customerTelp: String? = null,

	@field:SerializedName("customer_image")
	val customerImage: String? = null,

	@field:SerializedName("id_customer")
	val idCustomer: String? = null


)
