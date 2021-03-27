package com.udacoding.transactionpurchaseapp.view.home.customer

import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.provider.MediaStore
import android.util.Log
import android.view.View
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.ActivityPostCustomerBinding
import com.udacoding.transactionpurchaseapp.databinding.DialogChooseImageBinding
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.code.CUSTOMER_RESULT
import com.udacoding.transactionpurchaseapp.view.FragmentProgress
import com.udacoding.transactionpurchaseapp.view.home.customer.model.ResponsePostCustomer
import dagger.hilt.android.AndroidEntryPoint
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody
import java.io.File
import java.io.IOException
import javax.inject.Inject
import kotlin.random.Random

@AndroidEntryPoint
class PostCustomerActivity : AppCompatActivity() {

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var dialogProgress: FragmentProgress

    lateinit var dialogBottom: BottomSheetDialog

    private lateinit var viewModel: CustomerViewModel

    lateinit var binding: ActivityPostCustomerBinding

    lateinit var dialogChooseImageBinding: DialogChooseImageBinding

    private var image_path: String? = null

    private var mime_type: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityPostCustomerBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        viewModel = ViewModelProvider(this).get(CustomerViewModel::class.java)

        initPermission()
        initView()
        observeData()

    }

    private fun observeData() {
        viewModel.postCustomer.observe(this, Observer { successSaveCustomer(it) })
        viewModel.loading.observe(
            this,
            Observer { showLoading(it, supportFragmentManager, dialogProgress) })
        viewModel.empty_photo.observe(this, Observer { actionEmptyPhoto(it) })
        viewModel.empty_id_company.observe(this, Observer {
            requiredToast(
                applicationContext, it, getString(
                    R.string.id_company_required
                )
            )
        })
        viewModel.empty_name.observe(this, Observer {
            requiredEditText(
                it, binding.editTextCustomerName, getString(
                    R.string.name_required
                )
            )
        })
        viewModel.empty_telp.observe(this, Observer {
            requiredEditText(
                it, binding.editTextCustomerTelp, getString(
                    R.string.phone_required
                )
            )
        })
        viewModel.empty_email.observe(
            this,
            Observer {
                requiredEditText(
                    it,
                    binding.editTextCustomerEmail,
                    getString(R.string.email_required)
                )
            })
        viewModel.email_invalid.observe(
            this,
            Observer {
                requiredEditText(
                    it,
                    binding.editTextCustomerEmail,
                    getString(R.string.invalid_email)
                )
            })
        viewModel.empty_address.observe(this, Observer {
            requiredEditText(
                it, binding.editTextCustomerAddress, getString(
                    R.string.address_required
                )
            )
        })
        viewModel.error.observe(this, Observer { showError(applicationContext, it) })

    }

    private fun successSaveCustomer(it: ResponsePostCustomer?) {
        if (it?.success == true) {
            when (intent.getBooleanExtra("transaction", false)){
                true -> {
                    val data = intent
                    data.putExtra("id", it.data?.idCustomer.toString())
                    data.putExtra("name", binding.editTextCustomerName.text.toString())
                    data.putExtra("telp", binding.editTextCustomerTelp.text.toString())
                    setResult(CUSTOMER_RESULT, data)
                    finish()
                }
                false -> {
                    showToast(applicationContext, getString(R.string.success_save_customer))
                    finish()
                }
            }
        }
    }

    private fun initView() {

        dialogProgress.isCancelable = false

        binding.imageViewBack.setOnClickListener { finish() }

        binding.imageView.setOnClickListener {
            showChooseImage()
        }

        binding.buttonSave.setOnClickListener {
            save()
        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == Constant.Companion.code.CAMERA_CODE && resultCode == Activity.RESULT_OK) {
            initCamera(data)
        } else if (requestCode == Constant.Companion.code.GALLERY_CODE && resultCode == Activity.RESULT_OK) {
            initGallery(data)
        }
    }

    private fun actionEmptyPhoto(it: Boolean?) {
        if (it == true) {
            showChooseImage()
            showToast(applicationContext, getString(R.string.image_required))
        }
    }

    private fun showChooseImage() {
        dialogChooseImageBinding =
            DialogChooseImageBinding.bind(View.inflate(this, R.layout.dialog_choose_image, null))
        dialogBottom = BottomSheetDialog(this).apply {
            setContentView(dialogChooseImageBinding.root)
            show()
        }
        dialogChooseImageBinding.imageViewCamera.setOnClickListener {
            openCamera()
            dialogBottom.dismiss()
        }

        dialogChooseImageBinding.imageViewGallery.setOnClickListener {
            openGallery()
            dialogBottom.dismiss()
        }
    }

    private fun save() {

        try {
            viewModel.postCustomer(
                session.id_company,
                "${binding.editTextCustomerName.text}",
                "${binding.editTextCustomerTelp.text}",
                "${binding.editTextCustomerEmail.text}",
                "${binding.editTextCustomerAddress.text}",
                encodeBase64(image_path.toString()),
                mime_type
            )
        } catch (e: NullPointerException){
            showAlert(getString(R.string.required), getString(R.string.image_required), true)
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

            name_file = if (session.credit)
                "PurchaseImage$random"
            else
                "PettyCashImage$random"

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
        if (data != null) {
            try {

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

}