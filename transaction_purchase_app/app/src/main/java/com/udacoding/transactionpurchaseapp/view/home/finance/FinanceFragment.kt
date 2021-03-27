package com.udacoding.transactionpurchaseapp.view.home.finance

import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.get
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.FragmentFinanceBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityPettyCash
import com.udacoding.transactionpurchaseapp.room.model.EntityPurchase
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_PETTYCASH
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_PURCHASE
import com.udacoding.transactionpurchaseapp.view.FragmentProgress
import com.udacoding.transactionpurchaseapp.view.ViewFragment
import com.udacoding.transactionpurchaseapp.view.home.finance.adapter.PettyCashAdapter
import com.udacoding.transactionpurchaseapp.view.home.finance.adapter.PettyCashAdapterLocal
import com.udacoding.transactionpurchaseapp.view.home.finance.adapter.PurchaseAdapter
import com.udacoding.transactionpurchaseapp.view.home.finance.adapter.PurchaseAdapterLocal
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePettyCash
import com.udacoding.transactionpurchaseapp.view.home.finance.model.ResponsePurchase
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class FinanceFragment : Fragment() {

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var viewFragment: ViewFragment

    @Inject
    lateinit var bundle: Bundle

    private val viewModel: FinanceViewModel by viewModels()

    private lateinit var binding: FragmentFinanceBinding

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentFinanceBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initView()
        observeData()

    }

    private fun observeData() {
        viewModel.purchaseByUser.observe(viewLifecycleOwner, Observer { showDataPurchase(it) })
        viewModel.data_purchase_local.observe(
            viewLifecycleOwner,
            Observer { showDataPurchaseLocal(it) })
        viewModel.pettyCashByUser.observe(viewLifecycleOwner, Observer { showDataPettyCash(it) })
        viewModel.data_petty_cash_local.observe(
            viewLifecycleOwner,
            Observer { showDataPettyCashLocal(it) })
        viewModel.pettyCashByUser.observe(viewLifecycleOwner, Observer { showDataPettyCash(it) })
        viewModel.loading.observe(
            viewLifecycleOwner,
            Observer { loadingFragment(it, binding.progressBar) })
        viewModel.error.observe(
            viewLifecycleOwner,
            Observer { showError(activity?.applicationContext, it) })
        viewModel.is_empty.observe(viewLifecycleOwner, Observer {
            if (it == true){
                binding.imageCredit.show()
                binding.recyclerView.hide()
            } else {
                binding.imageCredit.hide()
                binding.recyclerView.show()
            }
        })
    }

    private fun showDataPurchase(it: ResponsePurchase?) {
        binding.recyclerView.adapter =
            activity?.applicationContext?.let { it1 ->
                PurchaseAdapter(it1, it?.data, object : PurchaseAdapter.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", BASE_URL_IMAGE_PURCHASE+item)
                        viewFragment.arguments = bundle
                        viewFragment.show(activity?.supportFragmentManager!!, "")
                    }

                })
            }
    }

    private fun showDataPurchaseLocal(it: List<EntityPurchase?>?) {
        binding.recyclerView.adapter =
            activity?.applicationContext?.let { it1 ->
                PurchaseAdapterLocal(it1, it, object : PurchaseAdapterLocal.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", BASE_URL_IMAGE_PURCHASE+item)
                        viewFragment.arguments = bundle
                        viewFragment.show(activity?.supportFragmentManager!!, "")
                    }

                })
            }
    }

    private fun showDataPettyCash(it: ResponsePettyCash?) {
        binding.recyclerView.adapter =
            activity?.applicationContext?.let { it1 ->
                PettyCashAdapter(it1, it?.data, object : PettyCashAdapter.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", BASE_URL_IMAGE_PETTYCASH+item)
                        viewFragment.arguments = bundle
                        viewFragment.show(activity?.supportFragmentManager!!, "")
                    }

                })
            }
    }

    private fun showDataPettyCashLocal(it: List<EntityPettyCash?>?) {
        binding.recyclerView.adapter =
            activity?.applicationContext?.let { it1 ->
                PettyCashAdapterLocal(it1, it, object : PettyCashAdapterLocal.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", BASE_URL_IMAGE_PETTYCASH+item)
                        viewFragment.arguments = bundle
                        viewFragment.show(activity?.supportFragmentManager!!, "")
                    }

                })
            }
    }

    private fun initView() {

        viewModel.getPurchaseByUser(session.id_user)

        creditActive()
        binding.buttonCredit.setOnClickListener {
            viewModel.getPurchaseByUser(session.id_user)
            creditActive()
        }
        binding.buttonDebit.setOnClickListener {
            viewModel.getPettyCashByUser(session.id_user)
            debitActive()
        }

        binding.fab.setOnClickListener {
            activity?.openActivity(PostFinanceActivity::class.java)
        }

    }

    private fun creditActive() {
        session.credit = true
        binding.buttonCredit.apply {
            background = context?.getDrawable(R.drawable.button_smooth_blue)
            setTextColor(Color.WHITE)
        }

        session.debit = false
        binding.buttonDebit.apply {
            background = context?.getDrawable(R.drawable.border_light_gray)
            setTextColor(Color.BLACK)
        }
    }

    private fun debitActive() {
        session.debit = true
        binding.buttonDebit.apply {
            background = context?.getDrawable(R.drawable.button_smooth_blue)
            setTextColor(Color.WHITE)
        }

        session.credit = false
        binding.buttonCredit.apply {
            background = context?.getDrawable(R.drawable.border_light_gray)
            setTextColor(Color.BLACK)
        }
    }

    private fun available(){
        binding.imageCredit.hide()
        binding.recyclerView.show()
    }

    private fun empty(){
        binding.imageCredit.show()
        binding.recyclerView.hide()
    }

    override fun onResume() {
        super.onResume()
        initView()
    }

}