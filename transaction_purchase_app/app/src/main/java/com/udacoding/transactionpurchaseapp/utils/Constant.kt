package com.udacoding.transactionpurchaseapp.utils

class Constant {

    companion object {

        object url {
            const val BASE_URL = "http://transaction.purchase.web.indonesiafintechforum.org/api/"
            const val BASE_URL_IMAGE_PRODUCT = "http://transaction.purchase.web.indonesiafintechforum.org/upload_image/product/"
            const val BASE_URL_IMAGE_CUSTOMER = "http://transaction.purchase.web.indonesiafintechforum.org/upload_image/customer/"
            const val BASE_URL_IMAGE_USER = "http://transaction.purchase.web.indonesiafintechforum.org/upload_image/user/"
            const val BASE_URL_IMAGE_PURCHASE = "http://transaction.purchase.web.indonesiafintechforum.org/upload_image/purchase/"
            const val BASE_URL_IMAGE_PETTYCASH = "http://transaction.purchase.web.indonesiafintechforum.org/upload_image/pettyCash/"
            const val BASE_URL_IMAGE_REPORT = "http://transaction.purchase.web.indonesiafintechforum.org/upload_image/report/"
            const val BASE_URL_IMAGE_SIGNATURE = "http://transaction.purchase.web.indonesiafintechforum.org/upload_image/signature/"

//            const val BASE_URL = "https://api.rikod.my/api/"
//            const val BASE_URL_IMAGE_PRODUCT = "http://transaction.purchase.indonesiafintechforum.org/upload_image/product/"
//            const val BASE_URL_IMAGE_CUSTOMER = "http://transaction.purchase.indonesiafintechforum.org/upload_image/customer/"
//            const val BASE_URL_IMAGE_USER = "http://transaction.purchase.indonesiafintechforum.org/upload_image/user/"
//            const val BASE_URL_IMAGE_PURCHASE = "https://api.rikod.my/upload_image/purchase/"
//            const val BASE_URL_IMAGE_PETTYCASH = "https://api.rikod.my/upload_image/pettyCash/"
        }

        object code {
            const val CAMERA_CODE = 0
            const val GALLERY_CODE = 1
            const val CUSTOMER_RESULT = 5
        }

        object database {
            const val VERSION = 6
            const val NAME = "DB_TRANSACTION_PURCHASE_APP"
        }

        object value {
            const val ROUND_IMAGE = 15
        }

        object payment_method {
            const val CASH = "CASH"
            const val TRANSFER = "TRANSFER"
            const val UNPAID = "UNPAID"
        }

        object transaction_status {
            const val COMPLETED = "COMPLETED"
            const val VOID = "VOID SALES"
            const val QUOTATION = "QUOTATION"
            const val INVOICE = "INVOICE"
            const val REJECTED = "REJECTED"
            const val PAID = "PAID"
        }
    }

}