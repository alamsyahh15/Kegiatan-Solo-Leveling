package com.udacoding.transactionpurchaseapp.utils

import android.annotation.SuppressLint
import android.app.Activity
import android.app.AlertDialog
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.util.Base64
import android.util.Log
import android.view.View
import android.widget.EditText
import android.widget.ProgressBar
import android.widget.Toast
import androidx.core.app.ActivityCompat.requestPermissions
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.textfield.TextInputLayout
import com.google.gson.internal.bind.ReflectiveTypeAdapterFactory
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.DialogProgressBinding
import com.udacoding.transactionpurchaseapp.view.home.finance.adapter.PurchaseAdapter
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePurchase
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream
import java.text.NumberFormat
import java.text.SimpleDateFormat
import java.util.*
import java.util.regex.Matcher
import java.util.regex.Pattern

fun showToast(context: Context, message: String?) {
    Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
}

fun showError(context: Context?, it: Throwable?) {
    context?.let { it1 -> showToast(it1, it?.message) }
}

fun loadingFragment(it: Boolean?, progressBar: ProgressBar) {
    if (it == true)
        progressBar.show()
    else
        progressBar.hide()
}

fun showLoading(it: Boolean?, fragmentManager: FragmentManager, dialog: DialogFragment) {
    if (it == true)
        dialog.show(fragmentManager, "")
    else
        dialog.dismiss()
}

fun requiredEditText(it: Boolean?, editText: EditText, message: String?) {
    if (it == true)
        editText.error = message
}

fun requiredTextInputLayout(it: Boolean?, editText: TextInputLayout, message: String?) {
    if (it == true)
        editText.error = message
}

fun requiredToast(context: Context, it: Boolean?, message: String?) {
    if (it == true) {
        showToast(context, message)
    }
}

fun convertByteArray(file_path: String): ByteArray {
    val bitmap = BitmapFactory.decodeFile(file_path)
    val baos = ByteArrayOutputStream()
    bitmap.compress(Bitmap.CompressFormat.PNG, 100, baos)
    return baos.toByteArray()
}

fun encodeBase64(file_path: String?): String{
    return Base64.encodeToString(convertByteArray(file_path ?: ""), Base64.DEFAULT)
}

fun validationEmail(email: String?): Boolean {
    val emailPattern =
        "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
    val pattern = Pattern.compile(emailPattern)
    val matcher = pattern.matcher(email.toString())
    return matcher.matches()
}

fun validationPassword(password: String?): Boolean {
    val PASSWORD_PATTERN = "^(?=.*[0-9])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{4,}$"
    val pattern = Pattern.compile(PASSWORD_PATTERN)
    val matcher = pattern.matcher(password)
    return matcher.matches()
}

fun toRinggit(amount: Double?): String {
    val COUNTRY = "MY"
    val LANGUAGE = "en"
    val str = NumberFormat.getCurrencyInstance(Locale(LANGUAGE, COUNTRY)).format(amount)
    return str
}

@SuppressLint("SimpleDateFormat")
fun formatDate(date: String?): String {
    val inputFormat1 = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    val inputFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:SS")
    val inputDate = inputFormat.parse(date)

    val pattern = "dd-MM-yyyy HH:mm:SS"
    val sdf = SimpleDateFormat(pattern)

    return sdf.format(inputDate ?: "")
}

@SuppressLint("SimpleDateFormat")
fun formatDate1(date: String?): String {
    val inputFormat1 = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    val inputFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:SS")
    val inputDate = inputFormat.parse(date)

    val pattern = "dd-MM-yyyy HH:mm:SS"
    val sdf = SimpleDateFormat(pattern)

    return sdf.format(inputDate ?: "")
}



