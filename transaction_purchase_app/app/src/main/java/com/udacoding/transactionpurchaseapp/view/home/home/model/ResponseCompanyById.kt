package com.udacoding.transactionpurchaseapp.view.home.home.model

import com.google.gson.annotations.SerializedName

data class ResponseCompanyById(

	@field:SerializedName("data")
	val data: List<DataItemCompany?>? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class DataItemCompany(

	@field:SerializedName("country")
	val country: Country? = null,

	@field:SerializedName("owner_name")
	val ownerName: String? = null,

	@field:SerializedName("owner_ic_number")
	val ownerIcNumber: String? = null,

	@field:SerializedName("city")
	val city: City? = null,

	@field:SerializedName("id_company")
	val idCompany: Int? = null,

	@field:SerializedName("company_email")
	val companyEmail: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("company_telp")
	val companyTelp: String? = null,

	@field:SerializedName("image_lisence")
	val imageLisence: String? = null,

	@field:SerializedName("company_fax")
	val companyFax: String? = null,

	@field:SerializedName("owner_photo")
	val ownerPhoto: String? = null,

	@field:SerializedName("id_country")
	val idCountry: Int? = null,

	@field:SerializedName("id_city")
	val idCity: Int? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("company_name")
	val companyName: String? = null,

	@field:SerializedName("number_lisence")
	val numberLisence: String? = null,

	@field:SerializedName("company_status")
	val companyStatus: String? = null,

	@field:SerializedName("company_code")
	val companyCode: String? = null,

	@field:SerializedName("company_password")
	val companyPassword: String? = null,

	@field:SerializedName("state")
	val state: State? = null,

	@field:SerializedName("id_state")
	val idState: Int? = null,

	@field:SerializedName("image_ic_number")
	val imageIcNumber: String? = null
)

data class City(

	@field:SerializedName("city_name")
	val cityName: String? = null,

	@field:SerializedName("id_city")
	val idCity: Int? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("id_state")
	val idState: Int? = null
)

data class State(

	@field:SerializedName("id_country")
	val idCountry: Int? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("state_name")
	val stateName: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("id_state")
	val idState: Int? = null
)

data class Country(

	@field:SerializedName("id_country")
	val idCountry: Int? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("country_name")
	val countryName: String? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null
)
