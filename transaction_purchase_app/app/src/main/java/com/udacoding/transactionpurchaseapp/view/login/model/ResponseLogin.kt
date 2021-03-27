package com.udacoding.transactionpurchaseapp.view.login.model

import com.google.gson.annotations.SerializedName

data class ResponseLogin(

	@field:SerializedName("data")
	val data: Data? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class User(

	@field:SerializedName("user_status")
	val userStatus: String? = null,

	@field:SerializedName("user_email")
	val userEmail: String? = null,

	@field:SerializedName("is_active")
	val isActive: String? = null,

	@field:SerializedName("company_id")
	val companyId: String? = null,

	@field:SerializedName("user_name")
	val userName: String? = null,

	@field:SerializedName("user_address")
	val userAddress: String? = null,

	@field:SerializedName("payment_status")
	val paymentStatus: String? = null,

	@field:SerializedName("api_token")
	val apiToken: Any? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("email_verified_at")
	val emailVerifiedAt: Any? = null,

	@field:SerializedName("id_user")
	val idUser: Int? = null,

	@field:SerializedName("id_paket_subscription")
	val idPaketSubscription: Int? = null,

	@field:SerializedName("user_ic_number")
	val userIcNumber: String? = null,

	@field:SerializedName("user_code")
	val userCode: String? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("user_telp")
	val userTelp: Int? = null,

	@field:SerializedName("user_expired")
	val userExpired: String? = null,

	@field:SerializedName("cash_in_hand")
	val cashInHand: String? = null,

	@field:SerializedName("user_photo")
	val userPhoto: String? = null
)

data class Data(

	@field:SerializedName("company")
	val company: String? = null,

	@field:SerializedName("user")
	val user: User? = null,

	@field:SerializedName("token")
	val token: String? = null
)
