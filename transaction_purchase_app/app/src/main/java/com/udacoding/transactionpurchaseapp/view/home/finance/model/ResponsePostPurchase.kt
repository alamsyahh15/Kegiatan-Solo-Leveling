package com.udacoding.transactionpurchaseapp.view.home.finance.model

import com.google.gson.annotations.SerializedName

data class ResponsePostPurchase(

	@field:SerializedName("data")
	val data: DataPostPurchase? = null,

	@field:SerializedName("success")
	val success: Boolean? = null
)

data class DataPostPurchase(

	@field:SerializedName("note")
	val note: String? = null,

	@field:SerializedName("image")
	val image: String? = null,

	@field:SerializedName("purchase")
	val purchase: String? = null,

	@field:SerializedName("id_user")
	val idUser: String? = null
)
