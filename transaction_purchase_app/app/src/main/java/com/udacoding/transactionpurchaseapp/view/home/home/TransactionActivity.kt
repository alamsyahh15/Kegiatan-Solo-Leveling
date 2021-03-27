package com.udacoding.transactionpurchaseapp.view.home.home

import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.github.gcacace.signaturepad.views.SignaturePad
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.ojekamanah.app.utils.GPSTracker
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.ActivityTransactionBinding
import com.udacoding.transactionpurchaseapp.databinding.DialogChooseImageBinding
import com.udacoding.transactionpurchaseapp.databinding.DialogChoosePaymentBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityCart
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.code.CUSTOMER_RESULT
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.UNPAID
import com.udacoding.transactionpurchaseapp.view.FragmentProgress
import com.udacoding.transactionpurchaseapp.view.PrintDialogFragment
import com.udacoding.transactionpurchaseapp.view.home.customer.PostCustomerActivity
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataItemCompany
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataTransaction
import com.udacoding.transactionpurchaseapp.view.home.home.model.DetailTransaction
import com.udacoding.transactionpurchaseapp.view.home.home.model.Transaction
import com.udacoding.transactionpurchaseapp.view.home.home.viewmodel.HomeViewModel
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.activity_transaction.*
import java.io.IOException
import javax.inject.Inject
import kotlin.random.Random

@AndroidEntryPoint
class TransactionActivity : AppCompatActivity() {

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var dialogProgress: FragmentProgress

    private lateinit var binding: ActivityTransactionBinding

    lateinit var dialogChooseImageBinding: DialogChooseImageBinding

    lateinit var dialogChoosePaymentBinding: DialogChoosePaymentBinding

    private lateinit var viewModel: HomeViewModel

    lateinit var dialog: BottomSheetDialog

    private var image_path: String? = null

    private var sign_path: String? = null

    private var isSign = false

    private var mime_type_report: String? = null

    private var mime_type_signature: String? = null

    private var itemProduct = ArrayList<String>()
    private var itemTotalPrice = ArrayList<String>()
    private var itemQty = ArrayList<String>()
    private var totalPrice = 0.0
    private var customerId = ""

    private var lat = 0.0
    private var lon = 0.0

    private val TAG = "TransactionActivity"

    private var dataPrint: List<EntityCart>? = null

    lateinit var dataCompany: DataItemCompany

    private var gps: GPSTracker? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTransactionBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        viewModel = ViewModelProvider(this).get(HomeViewModel::class.java)

        initPermission()
        initPermissionBluetooth()
        observer()
        initView()

    }

    private fun observer() {
        with(viewModel) {

            app_config.observe(this@TransactionActivity, Observer {
                binding.editTextNote.setText(it?.data?.remarks)
            })

            companyById.observe(this@TransactionActivity, Observer { dataCompany =
                it.data?.get(0)!!
            })

            loading.observe(
                this@TransactionActivity,
                Observer { showLoading(it, supportFragmentManager, dialogProgress) })
            error.observe(
                this@TransactionActivity,
                Observer { showAlert(getString(R.string.error), it.toString(), true) })
            transactionResponse.observe(this@TransactionActivity, Observer { showResponse(it) })

            empty_report.observe(this@TransactionActivity, Observer {
                showAlert(getString(R.string.required), getString(R.string.empty_report), true)
            })

            empty_format_report.observe(this@TransactionActivity, Observer {
                showAlert(getString(R.string.required), getString(R.string.empty_format_report), true)
            })

            empty_sign.observe(this@TransactionActivity, Observer {
                showAlert(getString(R.string.required), getString(R.string.empty_sign), true)
            })

            empty_format_sign.observe(this@TransactionActivity, Observer {
                showAlert(getString(R.string.required), getString(R.string.empty_format_sign), true)
            })

            empty_data_transaction.observe(this@TransactionActivity, Observer {
                showAlert(getString(R.string.required), getString(R.string.empty_data_transaction), true)
            })

            empty_detail_transaction.observe(this@TransactionActivity, Observer {
                showAlert(getString(R.string.required), getString(R.string.empty_detail_transaction), true)
            })

            empty_customer_id.observe(this@TransactionActivity, Observer {
                showAlert(getString(R.string.required), getString(R.string.empty_customer), true)
            })

            empty_note.observe(this@TransactionActivity, Observer {
                requiredEditText(true, binding.editTextNote, getString(R.string.note_required))
            })

            data_cart_local.observe(this@TransactionActivity, Observer { showDataCart(it) })

            total_pay.observe(
                this@TransactionActivity,
                Observer {
                    binding.textViewTotalPay.text = toRinggit(it ?: 0.0)
                    totalPrice = it
                })
        }
    }

    private fun showDataCart(it: List<EntityCart>?) {

        dataPrint = it

        for (i in it?.indices ?: 0..1) {
            itemProduct.add(it?.get(i)?.id_product.toString())
            itemTotalPrice.add(it?.get(i)?.total_item_price.toString())
            itemQty.add(it?.get(i)?.qty.toString())
        }

    }

    private fun showResponse(it: Transaction?) {

        if (it?.success == "true") {
            viewModel.deleteCartAll()
            val dialog = PrintDialogFragment(
                dataPrint,
                session.name_user,
                binding.textViewName.text.toString(),
                binding.textViewPhone.text.toString(),
                it.data,
                dataCompany
            )
            dialog.isCancelable = false
            dialog.show(supportFragmentManager, "")
        }

    }

    private fun initView() {

        gps = GPSTracker(this)

        dataCompany = DataItemCompany()

        if (gps?.canGetLocation != false) {
            lat = gps?.getLatitude() ?: 0.0
            lon = gps?.getLongitude() ?: 0.0

            Log.d(TAG, "initView: lat1 : $lat")
            Log.d(TAG, "initView: lon1 : $lon")
        } else {
            gps?.showSettingGps()
        }

        binding.checkboxRequired.setOnCheckedChangeListener { buttonView, isChecked ->
            session.required_image = !isChecked
        }

        viewModel.getCartLocal()

        viewModel.getCompanyById(session.id_company)

        viewModel.appConfig()

        if (session.quotation) {
            binding.layoutImage.hide()
            binding.layoutQuotation.show()
            binding.layoutPayment.hide()
            binding.checkboxRequired.hide()
        } else {
            binding.layoutImage.show()
            binding.layoutQuotation.hide()
            binding.layoutPayment.show()
            binding.checkboxRequired.show()
        }

        binding.changePayment.setOnClickListener {
            showChoosePayment()
        }

        binding.textViewSearch.setOnClickListener {
            val intent = Intent(this, ChooseCustomerActivity::class.java)
            startActivityForResult(intent, CUSTOMER_RESULT)
        }

        binding.buttonAddCustomer.setOnClickListener {

            val intent = Intent(this, PostCustomerActivity::class.java)
            intent.putExtra("transaction", true)
            startActivityForResult(intent, CUSTOMER_RESULT)

        }

        binding.imageViewBack.setOnClickListener {
            finish()
        }

        binding.icTakePic.setOnClickListener {
            showChooseImage()
        }

        binding.icDraw.setOnClickListener {

            binding.firstLinear.visibility = View.GONE
            binding.relativeSign.visibility = View.VISIBLE
        }

        binding.btnDoneSign.setOnClickListener {
            binding.firstLinear.visibility = View.VISIBLE
            binding.relativeSign.visibility = View.GONE
            if (isSign) {
                val random = Random.nextInt(0, 999999)
                binding.imageViewSignature.setImageBitmap(binding.signaturePad.signatureBitmap)
                sign_path = persistImage(binding.signaturePad.signatureBitmap, "Signature$random")

                mime_type_signature = getMimeTypeFile(Uri.parse(sign_path))

            }
        }


        binding.btnComplete.setOnClickListener {

            actionCheckOut()
        }
        binding.signaturePad.setOnSignedListener(object : SignaturePad.OnSignedListener {
            override fun onStartSigning() {
            }

            override fun onSigned() {
                isSign = true
            }

            override fun onClear() {
            }
        })
    }

    private fun actionCheckOut() {

            val payment_method = if (binding.textViewChoosePayment.text.toString() == getString(R.string.cod)) UNPAID
            else binding.textViewChoosePayment.text.toString()

            val dataTransaction = DataTransaction(
                "",
                "",
                "",
                totalPrice.toString(),
                "",
                customerId,
                binding.editTextNote.text.toString(),
                "${lat}",
                "",
                0,
                session.id_user.toString(),
                payment_method,
                "${lon}"
            )

            val detail = DetailTransaction(itemProduct, itemQty, itemTotalPrice)

            try {

            val IMAGE_PATH = if (session.required_image) encodeBase64(image_path ?: "" ) else ""
            val SIGN_PATH = if (session.required_image) encodeBase64(sign_path ?: "") else ""

                viewModel.transaction(
                    customerId,
                    IMAGE_PATH,
                    mime_type_report ?: "",
                    SIGN_PATH,
                    mime_type_signature ?: "",
                    dataTransaction,
                    detail
                )
            } catch (e: NullPointerException){
                showAlert(getString(R.string.required), getString(R.string.image_report_signature_required), true)
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

    private fun showChoosePayment() {
        dialogChoosePaymentBinding =
            DialogChoosePaymentBinding.bind(View.inflate(this, R.layout.dialog_choose_payment, null))
        dialog = BottomSheetDialog(this).apply {
            setContentView(dialogChoosePaymentBinding.root)
            show()
        }
        dialogChoosePaymentBinding.btnCash.setOnClickListener {
            binding.textViewChoosePayment.text = getString(R.string.cash)
            dialog.dismiss()
        }

        dialogChoosePaymentBinding.btnTransfer.setOnClickListener {
            binding.textViewChoosePayment.text = getString(R.string.transfer)
            dialog.dismiss()
        }

        dialogChoosePaymentBinding.btnPayLater.setOnClickListener {
            binding.textViewChoosePayment.text = getString(R.string.cod)
            dialog.dismiss()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == Constant.Companion.code.CAMERA_CODE && resultCode == Activity.RESULT_OK) {
            initCamera(data)
        } else if (requestCode == Constant.Companion.code.GALLERY_CODE && resultCode == Activity.RESULT_OK) {
            initGallery(data)
        } else if (requestCode == CUSTOMER_RESULT) {
            if (data != null) {
                showDataCustomer(data)
            }
        }
    }

    private fun showDataCustomer(data: Intent) {
        binding.layoutCustomer.show()
        binding.textViewName.text = data.getStringExtra("name")
        binding.textViewPhone.text = data.getStringExtra("telp")
        customerId = data.getStringExtra("id") ?: ""
        Log.d(TAG, "showDataCustomer: $customerId")
    }

    private fun initGallery(data: Intent?) {
        val image_bitmap = onSelectFromGalleryResult(data)

        mime_type_report = getMimeTypeFile(Uri.parse(data?.data.toString()))

        Log.d("TAG", "initGallery: MimeType : $mime_type_report")

        binding.imageViewReport.setImageBitmap(image_bitmap)

    }

    private fun initCamera(data: Intent?) {
        try {
            val image = data?.extras?.get("data")
            val random = Random.nextInt(0, 999999)
            var name_file = ""

            name_file = "ReportImage$random"

            image_path = persistImage(image as Bitmap, name_file)

            mime_type_report = getMimeTypeFile(Uri.parse(image_path))

            binding.imageViewReport.setImageBitmap(BitmapFactory.decodeFile(image_path))

        } catch (e: Exception) {
            Log.d("Error", "initCameraException: $e")
        }
    }

    private fun onSelectFromGalleryResult(data: Intent?): Bitmap {
        var bm: Bitmap? = null
        if (data != null) {
            try {

                image_path = data.data?.let { FilePath.getPath(this, it) }

                bm =
                    MediaStore.Images.Media.getBitmap(applicationContext.contentResolver, data.data)

            } catch (e: IOException) {
                e.printStackTrace()
            }

        }
        return bm!!
    }

}