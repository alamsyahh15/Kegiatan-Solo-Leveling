package com.udacoding.transactionpurchaseapp.view.home.home

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.ActivityCartBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityCart
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.view.home.home.adapter.CartAdapter
import com.udacoding.transactionpurchaseapp.view.home.home.viewmodel.HomeViewModel
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.activity_login.*
import javax.inject.Inject

@AndroidEntryPoint
class CartActivity : AppCompatActivity() {

    private lateinit var viewModel: HomeViewModel

    private lateinit var binding: ActivityCartBinding

    @Inject
    lateinit var session: SessionManager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityCartBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        viewModel = ViewModelProvider(this).get(HomeViewModel::class.java)

        initPermissionLocation()

        initView()
        observeData()

    }

    private fun initView() {
        with(viewModel) {
            getCartLocal()
            getTotalPay()
        }

        binding.imageViewBack.setOnClickListener {
            finish()
        }

        binding.buttonContinue.setOnClickListener {

            AlertDialog.Builder(this).apply {
                title = getString(R.string.confirmation)
                setMessage(getString(R.string.ask_quotation))
                setCancelable(false)
                setPositiveButton(R.string.yes) { _, _ ->
                    session.quotation = true
                    session.required_image = false
                    openActivity(TransactionActivity::class.java)
                }
                setNegativeButton(R.string.go_to_payment) { _, _ ->
                    session.quotation = false
                    session.required_image = true
                    openActivity(TransactionActivity::class.java)
                }
            }.show()
        }

        binding.textViewClearCart.setOnClickListener {
            viewModel.deleteCartAll()
            finish()
        }
    }

    private fun observeData() {
        with(viewModel) {
            data_cart_local.observe(this@CartActivity, Observer { showDataCart(it) })

            total_pay.observe(
                this@CartActivity,
                Observer {
                    binding.textViewTotalPay.text = toRinggit(it ?: 0.0)
                })

        }

    }

    private fun showDataCart(it: List<EntityCart>?) {

        binding.recyclerView.adapter = CartAdapter(this, it)
    }
}