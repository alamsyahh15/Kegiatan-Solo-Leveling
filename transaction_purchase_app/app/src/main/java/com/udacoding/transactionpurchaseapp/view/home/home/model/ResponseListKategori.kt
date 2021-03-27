package com.udacoding.transactionpurchaseapp.view.home.home.model

import com.google.gson.annotations.SerializedName

data class ResponseListKategori(

	@field:SerializedName("data")
	val data: List<DataItemKategori?>? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class DataItemKategori(

	@field:SerializedName("id_kategori")
	val idKategori: Int? = null,

	@field:SerializedName("kategori_image")
	val kategoriImage: String? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("id_company")
	val idCompany: Int? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("kategori_name")
	val kategoriName: String? = null
)
