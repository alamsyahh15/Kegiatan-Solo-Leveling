package com.udacoding.transactionpurchaseapp.view.home.home.model

import com.google.gson.annotations.SerializedName

data class ResponseListProduct(

	@field:SerializedName("data")
	val data: List<DataItemProduct?>? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class DataItemProduct(

	@field:SerializedName("is_active")
	val isActive: String? = null,

	@field:SerializedName("id_kategori")
	val idKategori: Int? = null,

	@field:SerializedName("product_image")
	val productImage: String? = null,

	@field:SerializedName("calc_price")
	val calcPrice: String? = null,

	@field:SerializedName("id_company")
	val idCompany: Int? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("product_price")
	val productPrice: String? = null,

	@field:SerializedName("product_name")
	val productName: String? = null,

	@field:SerializedName("product_desc")
	val productDesc: String? = null,

	@field:SerializedName("id_product")
	val idProduct: Int? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("diskon_type")
	val diskonType: Any? = null,

	@field:SerializedName("product_stock")
	val productStock: String? = null,

	@field:SerializedName("is_promo")
	val isPromo: String? = null
)
