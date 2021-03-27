package com.udacoding.transactionpurchaseapp.view.home.profile.model

import com.google.gson.annotations.SerializedName

data class ResponseProfileUser(

	@field:SerializedName("data")
	val data: Data? = null,

	@field:SerializedName("success")
	val success: String? = null
)

data class Data(

	@field:SerializedName("user_status")
	val userStatus: Any? = null,

	@field:SerializedName("user_email")
	val userEmail: String? = null,

	@field:SerializedName("company_id")
	val companyId: Any? = null,

	@field:SerializedName("user_name")
	val userName: String? = null,

	@field:SerializedName("user_address")
	val userAddress: Any? = null,

	@field:SerializedName("created_at")
	val createdAt: String? = null,

	@field:SerializedName("email_verified_at")
	val emailVerifiedAt: Any? = null,

	@field:SerializedName("id_user")
	val idUser: Int? = null,

	@field:SerializedName("user_ic_number")
	val userIcNumber: Any? = null,

	@field:SerializedName("user_code")
	val userCode: Any? = null,

	@field:SerializedName("updated_at")
	val updatedAt: String? = null,

	@field:SerializedName("user_telp")
	val userTelp: Int? = null,

	@field:SerializedName("user_expired")
	val userExpired: String? = null,

	@field:SerializedName("cash_in_hand")
	val cashInHand: String? = null,

	@field:SerializedName("user_photo")
	val userPhoto: Any? = null
)
