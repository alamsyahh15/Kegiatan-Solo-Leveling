package com.udacoding.transactionpurchaseapp.view.home.finance.model

import com.google.gson.annotations.SerializedName

data class ResponsePettyCash(

	@field:SerializedName("data")
	val data: List<DataItemPettyCash?>? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class DataItemPettyCash(

	@field:SerializedName("note")
	val note: String? = null,

	@field:SerializedName("image")
	val image: String? = null,

	@field:SerializedName("id_petty_cash")
	val idPettyCash: Int? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("id_user")
	val idUser: Int? = null,

	@field:SerializedName("petty_cash")
	val pettyCash: String? = null
)
