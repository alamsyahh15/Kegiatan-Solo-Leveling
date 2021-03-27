package com.udacoding.transactionpurchaseapp.view.home.finance

import android.app.Activity
import android.content.ContentResolver
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.provider.MediaStore
import android.util.Base64
import android.util.Log
import android.view.View
import android.webkit.MimeTypeMap
import android.widget.Toast
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.ActivityPurchaseBinding
import com.udacoding.transactionpurchaseapp.databinding.DialogChooseImageBinding
import com.udacoding.transactionpurchaseapp.databinding.DialogProgressBinding
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.code.CAMERA_CODE
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.code.GALLERY_CODE
import com.udacoding.transactionpurchaseapp.view.FragmentProgress
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePostPettyCash
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePostPurchase
import dagger.hilt.android.AndroidEntryPoint
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody
import java.io.File
import java.io.IOException
import java.lang.NullPointerException
import javax.inject.Inject
import kotlin.random.Random

@AndroidEntryPoint
class PostFinanceActivity : AppCompatActivity() {

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var dialogProgress: FragmentProgress

    lateinit var dialog: BottomSheetDialog

    private val viewModel: FinanceViewModel by viewModels()

    lateinit var binding: ActivityPurchaseBinding

    lateinit var dialogChooseImageBinding: DialogChooseImageBinding

    lateinit var dialogProgressBinding: DialogProgressBinding

    private val CODE_PERMISSION = 1

    private var image_path: String? = null
    private var mime_type: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityPurchaseBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        initPermission()
        initView()
        observeData()

    }

    private fun observeData() {
        viewModel.postPurchase.observe(this, Observer { showDataPurchase(it) })
        viewModel.postPettyCash.observe(this, Observer { showDataPettyCash(it) })
        viewModel.loading.observe(this, Observer { showLoading(it, supportFragmentManager, dialogProgress) })
        viewModel.empty_photo.observe(this, Observer { actionEmptyPhoto(it) })
        viewModel.empty_id_user.observe(
            this,
            Observer { requiredToast(applicationContext, it, getString(R.string.id_not_found)) })
        viewModel.empty_purchase.observe(
            this,
            Observer {
                requiredTextInputLayout(
                    it,
                    binding.editTextNominal,
                    getString(R.string.purchase_required)
                )
            })

        viewModel.empty_petty_cash.observe(
            this,
            Observer {
                requiredTextInputLayout(
                    it,
                    binding.editTextNominal,
                    getString(R.string.petty_cash_required)
                )
            })
        viewModel.empty_note.observe(
            this,
            Observer {
                requiredTextInputLayout(
                    it,
                    binding.editTextNote,
                    getString(R.string.note_required)
                )
            })
        viewModel.error.observe(this, Observer { showError(applicationContext, it) })
    }

    private fun actionEmptyPhoto(it: Boolean?) {
        if (it == true) {
            showChooseImage()
            showToast(applicationContext, getString(R.string.image_required))
        }
    }

    private fun initView() {

        dialogProgress.isCancelable = false

        binding.imageViewBack.setOnClickListener { finish() }

        dialogProgressBinding =
            DialogProgressBinding.bind(View.inflate(this, R.layout.dialog_progress, null))

        if (session.credit) {
            binding.textViewName.text = getString(R.string.purchase)
            binding.editTextNominal.hint = getString(R.string.title_purchase)
        } else {
            binding.textViewName.text = getString(R.string.petty_cash)
            binding.editTextNominal.hint = getString(R.string.title_petty_cash)
        }

        binding.imageView.setOnClickListener {
            showChooseImage()
        }

        binding.buttonSave.setOnClickListener {
            save()
        }
    }

    private fun save() {

        try {
            if (session.credit) {
                viewModel.postPurchase(
                    image_path.toString(),
                    mime_type,
                    session.id_user,
                    "${binding.editTextNominal.editText?.text}",
                    "${binding.editTextNote.editText?.text}"
                )
            } else {
                viewModel.postPettyCash(
                    image_path.toString(),
                    mime_type,
                    session.id_user,
                    "${binding.editTextNominal.editText?.text}",
                    "${binding.editTextNote.editText?.text}"
                )
            }
        } catch (e: NullPointerException){
            showAlert(getString(R.string.required), getString(R.string.image_required), true)
        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == CAMERA_CODE && resultCode == Activity.RESULT_OK) {
            initCamera(data)
        } else if (requestCode == GALLERY_CODE && resultCode == Activity.RESULT_OK) {
            initGallery(data)
        }
    }

    private fun showChooseImage() {
        dialogChooseImageBinding =
            DialogChooseImageBinding.bind(View.inflate(this, R.layout.dialog_choose_image, null))
        dialog = BottomSheetDialog(this).apply {
            setContentView(dialogChooseImageBinding.root)
            show()
        }
        dialogChooseImageBinding.imageViewCamera.setOnClickListener {
            openCamera()
            dialog.dismiss()
        }

        dialogChooseImageBinding.imageViewGallery.setOnClickListener {
            openGallery()
            dialog.dismiss()
        }
    }

    private fun initGallery(data: Intent?) {
        val image_bitmap = onSelectFromGalleryResult(data)

        mime_type = getMimeTypeFile(Uri.parse(data?.data.toString()))

        Log.d("TAG", "initGallery: MimeType : $mime_type")

        binding.imageView.setImageBitmap(image_bitmap)
    }

    private fun initCamera(data: Intent?) {
        try {
            val image = data?.extras?.get("data")
            val random = Random.nextInt(0, 999999)
            var name_file = ""

            Log.d("debug", "initCamera: $image")

            if (session.credit)
                name_file = "PurchaseImage$random"
            else
                name_file = "PettyCashImage$random"

            image_path = persistImage(image as Bitmap, name_file)

            mime_type = getMimeTypeFile(Uri.parse(image_path))

            Log.d("TAG", "initCamera: MimeType : $mime_type")

            binding.imageView.setImageBitmap(BitmapFactory.decodeFile(image_path))

        } catch (e: Exception) {
            Log.d("Error", "initCameraException: $e")
        }
    }

    private fun onSelectFromGalleryResult(data: Intent?): Bitmap {
        var bm: Bitmap? = null

        Log.d("TAG", "onSelectFromGalleryResult: Masuk kesini")
        if (data != null) {
            Log.d("TAG", "onSelectFromGalleryResult: Sini juga Masuk")
            try {

                Log.d("TAG", "onSelectFromGalleryResult: Sini juga Masuk lah rafi")


                image_path = data.data?.let { FilePath.getPath(this, it) }

                Log.d("gallery_path", image_path ?: "")

                bm =
                    MediaStore.Images.Media.getBitmap(applicationContext.contentResolver, data.data)

            } catch (e: IOException) {
                e.printStackTrace()
            }

        }
        return bm!!
    }

    private fun showDataPettyCash(it: ResponsePostPettyCash?) {
        if (it?.success == true) {
            showToast(applicationContext, getString(R.string.success_save_petty_cash))
            finish()
        }
    }

    private fun showDataPurchase(it: ResponsePostPurchase?) {
        if (it?.success == true) {
            showToast(applicationContext, getString(R.string.success_save_purchase))
            finish()
        }
    }

}
