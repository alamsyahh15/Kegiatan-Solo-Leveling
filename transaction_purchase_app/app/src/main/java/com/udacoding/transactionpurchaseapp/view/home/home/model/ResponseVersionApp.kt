package com.udacoding.transactionpurchaseapp.view.home.home.model

import com.google.gson.annotations.SerializedName

data class ResponseVersionApp(

	@field:SerializedName("data")
	val data: DataVersion? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class DataVersion(

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("id")
	val id: Int? = null,

	@field:SerializedName("version")
	val version: String? = null
)
