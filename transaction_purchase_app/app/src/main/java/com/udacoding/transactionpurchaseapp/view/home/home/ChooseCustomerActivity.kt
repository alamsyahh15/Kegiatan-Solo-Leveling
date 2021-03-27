package com.udacoding.transactionpurchaseapp.view.home.home

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.ActivityChooseCustomerBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityCustomer
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.code.CUSTOMER_RESULT
import com.udacoding.transactionpurchaseapp.utils.hide
import com.udacoding.transactionpurchaseapp.utils.show
import com.udacoding.transactionpurchaseapp.utils.showToast
import com.udacoding.transactionpurchaseapp.view.ViewFragment
import com.udacoding.transactionpurchaseapp.view.home.customer.CustomerViewModel
import com.udacoding.transactionpurchaseapp.view.home.customer.adapter.CustomerAdapter
import com.udacoding.transactionpurchaseapp.view.home.customer.adapter.CustomerAdapterLocal
import com.udacoding.transactionpurchaseapp.view.home.customer.model.DataItemCustomer
import com.udacoding.transactionpurchaseapp.view.home.home.viewmodel.HomeViewModel
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class ChooseCustomerActivity : AppCompatActivity() {

    @Inject
    lateinit var bundle: Bundle

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var viewFragment: ViewFragment

    private val viewModel: HomeViewModel by viewModels()

    private val viewModelCustomer: CustomerViewModel by viewModels()

    private lateinit var binding: ActivityChooseCustomerBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityChooseCustomerBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        initView()
        observeData()

    }

    private fun observeData() {
        with(viewModel){
//            data_customer_local.observe(this@ChooseCustomerActivity, Observer { showDataLocal(it) })
        }

        viewModelCustomer.customerAll.observe(this@ChooseCustomerActivity, Observer { showDataCustomer(it.data) })

        viewModelCustomer.error.observe(this, Observer { showError(it) })

        viewModelCustomer.loading.observe(this@ChooseCustomerActivity, Observer { showLoading(it) })


    }

    private fun showLoading(it: Boolean?) {
        if (it == true) binding.progressBar.show()
        else binding.progressBar.hide()
    }

    private fun showError(it: Throwable?) {
        applicationContext?.let { it1 -> showToast(it1, it?.message) }
    }

    private fun initView() {
        with(viewModel){
//            getCustomerLocal()
        }

        viewModelCustomer.getCustomerAll(session.id_company)

        binding.searchView.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {
                viewModelCustomer.searchCustomer(session.id_company, s.toString())
//                viewModel.searchCustomerLocal(s.toString())
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
//                viewModel.searchCustomerLocal(s.toString())
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
//                viewModel.searchCustomerLocal(s.toString())
            }

        })

    }

    private fun showDataLocal(it: List<EntityCustomer>?) {
        binding.recyclerView.adapter =
            applicationContext?.let { it1 ->
                CustomerAdapterLocal(it1, it, object : CustomerAdapterLocal.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", item)
                        viewFragment.arguments = bundle
                        viewFragment.show(supportFragmentManager, "")
                    }

                    override fun item(item: EntityCustomer?) {
                        val intent = Intent(this@ChooseCustomerActivity, TransactionActivity::class.java)
                        intent.putExtra("id", item?.id_customer.toString())
                        intent.putExtra("name", item?.customer_name.toString())
                        intent.putExtra("telp", item?.customer_telp.toString())
                        setResult(CUSTOMER_RESULT, intent)
                        finish()
                    }

                })
            }
    }

    private fun showDataCustomer(it: List<DataItemCustomer?>?) {
        binding.recyclerView.adapter =
            applicationContext?.let { it1 ->
                CustomerAdapter(it1, it, object : CustomerAdapter.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", item)
                        viewFragment.arguments = bundle
                        viewFragment.show(supportFragmentManager, "")
                    }

                    override fun item(item: DataItemCustomer?) {
                        val intent = Intent(this@ChooseCustomerActivity, TransactionActivity::class.java)
                        intent.putExtra("id", item?.idCustomer.toString())
                        intent.putExtra("name", item?.customerName)
                        intent.putExtra("telp", item?.customerTelp)
                        setResult(CUSTOMER_RESULT, intent)
                        finish()
                    }

                })
            }
    }

}