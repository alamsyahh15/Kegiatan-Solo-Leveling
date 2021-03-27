package com.udacoding.transactionpurchaseapp.view.home.profile.model

import com.google.gson.annotations.SerializedName

data class ResponseDataIncome(

	@field:SerializedName("data")
	val data: DataIncome? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("erros")
	val erros: Any? = null,

	@field:SerializedName("isSuccess")
	val isSuccess: Boolean? = null
)

data class DataIncome(

	@field:SerializedName("total_unpaid")
	val totalUnpaid: TotalUnpaid? = null,

	@field:SerializedName("total_transfer")
	val totalTransfer: TotalTransfer? = null
)

data class TotalTransfer(

	@field:SerializedName("total")
	val total: Double? = null
)

data class TotalUnpaid(

	@field:SerializedName("total_unpaid")
	val totalUnpaid: Double? = null
)
