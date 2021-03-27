package com.udacoding.transactionpurchaseapp.view.home.history

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.ActivityDetailHistoryBinding
import com.udacoding.transactionpurchaseapp.databinding.DialogChoosePaymentBinding
import com.udacoding.transactionpurchaseapp.databinding.DialogReasonBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityCart
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.CASH
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.TRANSFER
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.UNPAID
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.COMPLETED
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.INVOICE
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.QUOTATION
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.REJECTED
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.VOID
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_CUSTOMER
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_PRODUCT
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_REPORT
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_SIGNATURE
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.value.ROUND_IMAGE
import com.udacoding.transactionpurchaseapp.view.PrintDialogFragmentHistory
import com.udacoding.transactionpurchaseapp.view.ViewFragment
import com.udacoding.transactionpurchaseapp.view.home.history.adapter.HistoryProductAdapter
import com.udacoding.transactionpurchaseapp.view.home.history.model.DataItem
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseDetailTransaction
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataItemCompany
import com.udacoding.transactionpurchaseapp.view.home.home.viewmodel.HomeViewModel
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class DetailHistoryActivity : AppCompatActivity() {

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var bundle: Bundle

    @Inject
    lateinit var viewFragment: ViewFragment

    lateinit var dialogChoosePaymentBinding: DialogChoosePaymentBinding

    lateinit var dialogTextReason: DialogReasonBinding

    lateinit var dialog: BottomSheetDialog

    private lateinit var viewModel: HistoryViewModel

    private lateinit var viewModelHome: HomeViewModel


    private var id_transaction: String? = null

    lateinit var dataCompany: DataItemCompany

    private var payment_method: String? = null

    private var dataPrint: List<EntityCart>? = null

    private var detailTransaksi: List<DataItem?>? = null

    lateinit var binding: ActivityDetailHistoryBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityDetailHistoryBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        viewModel = ViewModelProvider(this).get(HistoryViewModel::class.java)
        viewModelHome = ViewModelProvider(this).get(HomeViewModel::class.java)

        initView()

        observeData()

    }

    private fun showChoosePayment() {
        dialogChoosePaymentBinding =
            DialogChoosePaymentBinding.bind(
                View.inflate(
                    this,
                    R.layout.dialog_choose_payment,
                    null
                )
            )
        dialog = BottomSheetDialog(this).apply {
            setContentView(dialogChoosePaymentBinding.root)
            show()
        }
        dialogChoosePaymentBinding.btnCash.setOnClickListener {
            viewModel.updateTransaction(id_transaction?.toInt() ?: 0, CASH, COMPLETED)
            payment_method = CASH
            dialog.dismiss()
        }

        dialogChoosePaymentBinding.btnTransfer.setOnClickListener {
            viewModel.updateTransaction(id_transaction?.toInt() ?: 0, TRANSFER, COMPLETED)
            payment_method = TRANSFER
            dialog.dismiss()
        }

        dialogChoosePaymentBinding.btnPayLater.visibility = View.GONE

    }

    private fun showTextReason() {
        dialogTextReason =
            DialogReasonBinding.bind(View.inflate(this, R.layout.dialog_reason, null))
        dialog = BottomSheetDialog(this).apply {
            setContentView(dialogTextReason.root)
            show()
        }

        dialogTextReason.btnSubmitReason.setOnClickListener {
            viewModel.updateTransaction(
                id_transaction?.toInt() ?: 0,
                "",
                VOID,
                "${dialogTextReason.editTextReason.text}"
            )
        }
    }

    private fun initView() {

        dataCompany = DataItemCompany()

        val intent = intent
        id_transaction = intent.getStringExtra("id_transaction")

        viewModel.detailTransaction(id_transaction?.toInt() ?: 0)

        viewModelHome.getCompanyById(session.id_company)

        binding.imageViewBack.setOnClickListener {
            finish()
        }

        binding.btnPayNow.setOnClickListener {
            showChoosePayment()
        }

        binding.btnVoid.setOnClickListener {
            showTextReason()
        }

        binding.btnInvoice.setOnClickListener {
            session.quotation = true
            viewModel.updateTransaction(
                id_transaction?.toInt() ?: 0,
                "",
                INVOICE,
                ""
            )

            payment_method = UNPAID
        }

        binding.btnReject.setOnClickListener {
            viewModel.updateTransaction(
                id_transaction?.toInt() ?: 0,
                "",
                REJECTED,
                ""
            )
        }
    }

    private fun observeData() {

        viewModelHome.companyById.observe(this, Observer {
            dataCompany =
                it.data?.get(0)!!
            Log.d("TAG", "observeData: data_company ${it.data.get(0)!!}")
        })

        with(viewModel) {

            detail_transaction.observe(this@DetailHistoryActivity, Observer {
                showDetailTransaction(it)
                detailTransaksi = it?.data
            })

            loading.observe(this@DetailHistoryActivity, Observer { showLoading(it) })

            error.observe(this@DetailHistoryActivity, Observer { showError(it.message) })

            message.observe(this@DetailHistoryActivity, Observer { showError(it) })

            update_transaction.observe(this@DetailHistoryActivity, Observer { successUpdate() })

            success_void.observe(this@DetailHistoryActivity, Observer { successVoid(it) })

            success_reject.observe(this@DetailHistoryActivity, Observer {
                if (it == true){
                    showToast(applicationContext, getString(R.string.reject_quotation))
                    finish()
                }

            })

            empty_reason_void.observe(this@DetailHistoryActivity, Observer {
                requiredEditText(
                    it,
                    dialogTextReason.editTextReason,
                    getString(R.string.reason_required)
                )
            })
        }

    }

    private fun successVoid(it: Boolean) {

        if (it == true){
            dialog.dismiss()

            showToast(applicationContext, getString(R.string.success_void))

            finish()
        }

    }

    private fun successUpdate() {
//        showAlert("Message", "", false)
//        AlertDialog.Builder(this).apply {
//            setTitle("Message")
//            setMessage(getString(R.string.payment_success))
//            setCancelable(false)
//            setPositiveButton("OK") { _, _  ->
//                finish()
//            }.show()
//        }

        val dialogPrint = PrintDialogFragmentHistory(
            detailTransaksi,
            dataCompany,
            payment_method
        )
        dialogPrint.isCancelable = false
        dialogPrint.show(supportFragmentManager, "")


//        val dialogPrint = PrintDialogFragment(
//            dataPrint,
//            session.name_user,
//            binding.textViewName.text.toString(),
//            binding.textViewPhone.text.toString(),
//            it.data,
//            dataCompany
//
//        )
//        dialogPrint.isCancelable = false
//        dialogPrint.show(supportFragmentManager, "")

    }

    private fun showLoading(it: Boolean?) {
        if (it == true) {
            binding.progressBar.show()
//            binding.layoutView.hide()
        } else {
            binding.progressBar.hide()
//            binding.layoutView.show()
        }
    }

    private fun showError(it: String?) {
        applicationContext?.let { it1 -> showToast(it1, it) }
    }


    private fun showDetailTransaction(it: ResponseDetailTransaction?) {
        val item_transaction = it?.data?.get(0)
        val item_customer = it?.data?.get(0)?.customer

        binding.textViewDate.text = formatDate(item_transaction?.createdAt) 
        binding.textViewCustomer.text = item_customer?.customerName

        Glide.with(this)
            .load(BASE_URL_IMAGE_CUSTOMER + item_customer?.customerImage)
            .transform(CenterCrop(), RoundedCorners(ROUND_IMAGE))
            .error(R.drawable.ex_product).into(binding.imageView)

        binding.textViewPhone.text = item_customer?.customerTelp

        binding.textViewPayment.text = item_transaction?.paymentMethod
        binding.textViewReason.text = item_transaction?.reasonVoid

        if (item_transaction?.imageReport.equals(null) || item_transaction?.imageReport.equals("")){
            binding.imageViewReport.hide()
            binding.labelReport.visibility = View.GONE
        } else {
            binding.imageViewReport.show()
            binding.labelReport.visibility = View.VISIBLE
        }

        if (item_transaction?.imageSignature.equals(null) || item_transaction?.imageSignature.equals("")){
            binding.imageViewSignature.hide()
            binding.labelSignature.visibility = View.GONE
        } else {
            binding.imageViewSignature.show()
            binding.labelSignature.visibility = View.VISIBLE
        }

        if (item_transaction?.paymentMethod == UNPAID && item_transaction.transactionStatus == COMPLETED || item_transaction?.transactionStatus == INVOICE) {
//            if (item_transaction.transactionStatus == INVOICE){
//                binding.imageViewSignature.hide()
//                binding.imageViewReport.hide()
//                binding.labelReport.visibility = View.GONE
//                binding.labelSignature.visibility = View.GONE
//            } else {
//                binding.imageViewSignature.show()
//                binding.imageViewReport.show()
//                binding.labelReport.visibility = View.VISIBLE
//                binding.labelSignature.visibility = View.VISIBLE
//            }

            with(binding){
                layoutButtonQuotation.hide()
                btnPayNow.visibility = View.VISIBLE
                btnVoid.visibility = View.GONE
                textViewLabelReason.visibility = View.GONE
                textViewReason.visibility = View.GONE
            }
        } else if (item_transaction?.paymentMethod == UNPAID && item_transaction.transactionStatus == QUOTATION) {
            with(binding){
                layoutButtonQuotation.show()
                btnPayNow.visibility = View.GONE
                btnVoid.visibility = View.GONE
                btnReject.visibility = View.VISIBLE
                btnInvoice.visibility = View.VISIBLE
                imageViewSignature.hide()
                imageViewReport.hide()
                labelReport.visibility = View.GONE
                labelSignature.visibility = View.GONE
                textViewLabelReason.visibility = View.GONE
                textViewReason.visibility = View.GONE
            }

        }
        else if (item_transaction?.transactionStatus != VOID && item_transaction?.paymentMethod != UNPAID) {
            with(binding){
                layoutButtonQuotation.hide()
                btnPayNow.visibility = View.GONE
                btnVoid.visibility = View.VISIBLE
                textViewLabelReason.visibility = View.GONE
                textViewReason.visibility = View.GONE
            }

        } else {
            with(binding){
                layoutButtonQuotation.hide()
                btnPayNow.visibility = View.GONE
                btnVoid.visibility = View.GONE
                textViewLabelReason.visibility = View.VISIBLE
                textViewReason.visibility = View.VISIBLE
            }
        }

        Glide.with(this)
            .load(BASE_URL_IMAGE_CUSTOMER + item_customer?.customerImage)
            .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
            .error(R.drawable.ex_product).into(binding.imageView)

        binding.imageView.setOnClickListener {
            bundle.putString("url", BASE_URL_IMAGE_CUSTOMER + item_customer?.customerImage)
            viewFragment.arguments = bundle
            viewFragment.show(supportFragmentManager, "")
        }

        Glide.with(this)
            .load(BASE_URL_IMAGE_REPORT + item_transaction?.imageReport)
            .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
            .error(R.drawable.ex_product).into(binding.imageViewReport)

        binding.imageViewReport.setOnClickListener {
            bundle.putString("url", BASE_URL_IMAGE_REPORT + item_transaction?.imageReport)
            viewFragment.arguments = bundle
            viewFragment.show(supportFragmentManager, "")
        }

        Glide.with(this)
            .load(BASE_URL_IMAGE_SIGNATURE + item_transaction?.imageSignature)
            .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
            .error(R.drawable.ex_product).into(binding.imageViewSignature)

        binding.imageViewSignature.setOnClickListener {
            bundle.putString("url", BASE_URL_IMAGE_SIGNATURE + item_transaction?.imageSignature)
            viewFragment.arguments = bundle
            viewFragment.show(supportFragmentManager, "")
        }

        binding.recyclerViewProduct.adapter =
            HistoryProductAdapter(
                this,
                item_transaction?.detailTransaksi,
                object : HistoryProductAdapter.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", BASE_URL_IMAGE_PRODUCT +item)
                        viewFragment.arguments = bundle
                        viewFragment.show(supportFragmentManager, "")
                    }

                })

        binding.textViewTotal.text =
            getString(R.string.total, toRinggit(item_transaction?.totalPrice?.toDouble()))

    }

}