package com.udacoding.transactionpurchaseapp.view.home.finance.model

import com.google.gson.annotations.SerializedName

data class ResponsePurchase(

	@field:SerializedName("data")
	val data: List<DataItemPurchase?>? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class DataItemPurchase(

	@field:SerializedName("note")
	val note: String? = null,

	@field:SerializedName("image")
	val image: String? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("purchase")
	val purchase: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("id_user")
	val idUser: Int? = null,

	@field:SerializedName("id_purchase")
	val idPurchase: Int? = null
)
