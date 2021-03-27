package com.udacoding.transactionpurchaseapp.utils

import android.content.Context
import android.os.Bundle
import android.os.CancellationSignal
import android.os.ParcelFileDescriptor
import android.print.PageRange
import android.print.PrintAttributes
import android.print.PrintDocumentAdapter
import android.print.PrintDocumentInfo
import android.util.Log
import java.io.*

class PdfDocumentAdapter(val context: Context, val path: String): PrintDocumentAdapter() {
    override fun onLayout(
        oldAttributes: PrintAttributes?,
        newAttributes: PrintAttributes?,
        cancellationSignal: CancellationSignal?,
        callback: LayoutResultCallback?,
        extras: Bundle?
    ) {
        if (cancellationSignal?.isCanceled == true)
            callback?.onLayoutCancelled()
        else {
            val builder = PrintDocumentInfo.Builder("file_name")
            builder.setContentType(PrintDocumentInfo.CONTENT_TYPE_DOCUMENT)
                .setPageCount(PrintDocumentInfo.PAGE_COUNT_UNKNOWN)
                .build()
            callback?.onLayoutFinished(builder.build(), oldAttributes != newAttributes)
        }
    }

    override fun onWrite(
        pages: Array<out PageRange>?,
        destination: ParcelFileDescriptor?,
        cancellationSignal: CancellationSignal?,
        callback: WriteResultCallback?
    ) {
        var `in` : InputStream? = null
        var out : OutputStream? = null

        try {
            val file = File(path)
            `in` = FileInputStream(file)
            out = FileOutputStream(destination?.fileDescriptor)

            if (cancellationSignal?.isCanceled == true){
                `in`.copyTo(out)
                callback?.onWriteFinished(arrayOf(PageRange.ALL_PAGES))
            }
            else
                callback?.onWriteCancelled()
        } catch (e: Exception){
            callback?.onWriteFailed(e.message)
            Log.e("TAG", "onWrite: ${e.message}")
        } finally {
            try {
                `in`?.close()
                out?.close()
            } catch (e: IOException){
                Log.e("TAG", "onWrite: ${e.message}")
            }
        }
    }


}