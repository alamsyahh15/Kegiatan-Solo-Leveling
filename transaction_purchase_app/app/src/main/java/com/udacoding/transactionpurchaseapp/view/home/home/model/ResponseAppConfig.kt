package com.udacoding.transactionpurchaseapp.view.home.home.model

import com.google.gson.annotations.SerializedName

data class ResponseAppConfig(

	@field:SerializedName("data")
	val data: Data? = null,

	@field:SerializedName("success")
	val success: String? = null
)

data class Data(

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("name")
	val name: String? = null,

	@field:SerializedName("logo")
	val logo: String? = null,

	@field:SerializedName("description")
	val description: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("id")
	val id: Int? = null,

	@field:SerializedName("url")
	val url: String? = null,

	@field:SerializedName("remarks")
	val remarks: String? = null,

	@field:SerializedName("payment_ref_link")
	val paymentRefLink: String? = null
)
