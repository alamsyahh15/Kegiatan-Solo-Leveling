package com.udacoding.transactionpurchaseapp.utils

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.net.Uri
import android.os.Environment
import android.provider.MediaStore
import androidx.core.content.FileProvider
import com.udacoding.transactionpurchaseapp.BuildConfig
import com.udacoding.transactionpurchaseapp.R
import java.io.File


object Common {

    fun getAppPath(context: Context): String {
        val dir = File(Environment.getExternalStorageDirectory().toString()
        +File.separator
        +context.resources.getString(R.string.app_name)
        +File.separator)
        if (!dir.exists())
            dir.mkdir()
        return dir.path+File.separator
    }

    fun getStorageDirectory(fileName: String): File {
        if (Environment.getExternalStorageState() == null) {
            val f = File(Environment.getDataDirectory().absolutePath + "/FILENYA/"+fileName)
            if (!f.exists())
                f.mkdirs()
            return f
        } else {
            val f = File(Environment.getExternalStorageDirectory().absolutePath + "/FILENYA/"+fileName)
            if (!f.exists())
                f.mkdirs()
            return f
        }
    }

}