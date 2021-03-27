package com.udacoding.transactionpurchaseapp.view.home.history

import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.google.android.material.tabs.TabLayoutMediator
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.FragmentHistoryBinding
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.CASH
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.TRANSFER
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.UNPAID
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.QUOTATION
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.VOID
import com.udacoding.transactionpurchaseapp.view.home.history.adapter.HistoryAdapter
import com.udacoding.transactionpurchaseapp.view.home.history.adapter.PagerAdapter
import com.udacoding.transactionpurchaseapp.view.home.history.model.DataItemHistory
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseTransactionByUser
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.fragment_history.*
import javax.inject.Inject

@AndroidEntryPoint
class HistoryFragment : Fragment() {

    @Inject
    lateinit var session: SessionManager

    private lateinit var viewModel: HistoryViewModel

    private lateinit var binding: FragmentHistoryBinding

    private var arg: ArrayList<String>? = null

    private val ARG_OBJECT = "object"

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentHistoryBinding.inflate(inflater, container, false)
        return binding.root

        arg = arguments?.getStringArrayList(ARG_OBJECT)

    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(this).get(HistoryViewModel::class.java)

        initView()
        observeData()

    }

    private fun observeData() {

    }

    private fun initView() {

        binding.viewPager.adapter = PagerAdapter(this)

        TabLayoutMediator(binding.tabLayout, binding.viewPager) {tab, position ->

            when(position){
                0 -> tab.text = CASH
                1 -> tab.text = TRANSFER
                2 -> tab.text = QUOTATION
                3 -> tab.text = UNPAID
                4 -> tab.text = VOID
            }

        }.attach()

    }
}