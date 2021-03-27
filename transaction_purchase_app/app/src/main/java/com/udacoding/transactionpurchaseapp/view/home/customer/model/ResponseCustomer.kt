package com.udacoding.transactionpurchaseapp.view.home.customer.model

import com.google.gson.annotations.SerializedName

data class ResponseCustomer(

	@field:SerializedName("data")
	val data: List<DataItemCustomer?>? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class DataItemCustomer(

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
