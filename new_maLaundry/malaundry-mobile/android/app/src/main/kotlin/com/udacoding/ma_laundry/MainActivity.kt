
package com.udacoding.ma_laundry
import android.Manifest
import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity(), MethodChannel.MethodCallHandler {
    private val CHANNEL = "com.udacoding/whatsappShare"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            reqPermission()
            onMethodCall(call, result)
        }
    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d("Calling", "Method")
        if (call.method == "sendWaWithFile") {
            sendWaWithFile(call, result)
        }

    }

    private fun sendWaWithFile(call: MethodCall, result: MethodChannel.Result) {
        //shares content on WhatsApp
        val nameFile: String? = call.argument("nameFile")
        val phone: String? = call.argument("numPhone")
        val outputFile = File(Environment.getExternalStorageDirectory().absolutePath, "MaLaundry/Sent/$nameFile")
        val uri = Uri.fromFile(outputFile)
        Log.d("OutputFile", "${outputFile.isFile}")
        var newUri = Uri.parse(uri.path?.replace("file://", "content://"))
        val share = Intent()
        share.action = Intent.ACTION_SEND
        share.type = "application/pdf"
        share.putExtra("jid", "$phone@s.whatsapp.net")
        share.putExtra(Intent.EXTRA_STREAM, newUri)
        share.setPackage("com.whatsapp")
        activity.startActivity(share)
        return result.success("Result Oke")
    }

    fun reqPermission(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            requestPermissions(arrayOf(android.Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE), 0)
        }
    }

}
