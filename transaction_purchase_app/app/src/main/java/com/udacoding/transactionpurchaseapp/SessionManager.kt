package com.udacoding.transactionpurchaseapp

import android.content.Context
import android.content.SharedPreferences

class SessionManager (private val context: Context) {

    private var pref: SharedPreferences
    private var editor: SharedPreferences.Editor

    private val PRIVATE_MODE = 0
    private val PREF_NAME = "transactionPurchaseApp"

    companion object {
        const val KEY_TOKEN = "token"
        const val KEY_LOGIN = "is_login"
        const val ID_USER = "id_user"
        const val NAME_USER = "name_user"
        const val ID_COMPANY = "id_company"
        const val COMPANY_NAME = "company_name"
        const val CREDIT = "credit"
        const val DEBIT = "DEBIT"
        const val QUOTATION = "quotation"
        const val REQUIRED_IMAGE = "required_image"
    }

    init {
        pref = context.getSharedPreferences(PREF_NAME, PRIVATE_MODE)
        editor = pref.edit()
    }

    fun createLoginSession(token: String){
        editor.apply{
            putString(KEY_TOKEN, token)
            putBoolean(KEY_LOGIN, true)
            commit()
        }

    }

    var id_user: Int
        get() = pref.getInt(ID_USER, 0)
        set(value) {
            editor.apply {
                putInt(ID_USER, value)
                commit()
            }
        }

    var name_user: String
        get() = pref.getString(NAME_USER, "") ?: ""
        set(value) {
            editor.apply {
                putString(NAME_USER, value)
                commit()
            }
        }

    var id_company: Int
        get() = pref.getInt(ID_COMPANY, 0)
        set(value) {
            editor.apply {
                putInt(ID_COMPANY, value)
                commit()
            }
        }

    var company_name: String
        get() = pref.getString(COMPANY_NAME, "") ?: ""
        set(value) {
            editor.apply {
                putString(COMPANY_NAME, value)
                commit()
            }
        }

    var credit: Boolean
        get() = pref.getBoolean(CREDIT, false)
        set(value) {
            editor.apply {
                putBoolean(CREDIT, value)
                commit()
            }
        }

    var debit: Boolean
        get() = pref.getBoolean(DEBIT, false)
        set(value) {
            editor.apply {
                putBoolean(DEBIT, value)
                commit()
            }
        }

    var quotation: Boolean
        get() = pref.getBoolean(QUOTATION, false)
        set(value) {
            editor.apply {
                putBoolean(QUOTATION, value)
                commit()
            }
        }

    var required_image: Boolean
        get() = pref.getBoolean(REQUIRED_IMAGE, true)
        set(value) {
            editor.apply {
                putBoolean(REQUIRED_IMAGE, value)
                commit()
            }
        }

    val is_login: Boolean
    get() = pref.getBoolean(KEY_LOGIN, false)

    val get_token: String
    get() = pref.getString(KEY_TOKEN, "") ?: ""

    fun logout(){
        editor.apply {
            clear()
            commit()
        }
    }

}