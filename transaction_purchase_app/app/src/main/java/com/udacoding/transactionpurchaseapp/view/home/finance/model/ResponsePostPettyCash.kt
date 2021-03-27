package com.udacoding.transactionpurchaseapp.view.home.finance.model

import com.google.gson.annotations.SerializedName

data class ResponsePostPettyCash(

	@field:SerializedName("data")
	val data: DataPostPettyCash? = null,

	@field:SerializedName("success")
	val success: Boolean? = null
)

data class DataPostPettyCash(

	@field:SerializedName("note")
	val note: String? = null,

	@field:SerializedName("image")
	val image: String? = null,

	@field:SerializedName("id_user")
	val idUser: String? = null,

	@field:SerializedName("petty_cash")
	val pettyCash: String? = null
)
