package com.udacoding.transactionpurchaseapp.view.home.customer

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.FragmentCustomerBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityCustomer
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_CUSTOMER
import com.udacoding.transactionpurchaseapp.utils.hide
import com.udacoding.transactionpurchaseapp.utils.openActivity
import com.udacoding.transactionpurchaseapp.utils.show
import com.udacoding.transactionpurchaseapp.utils.showToast
import com.udacoding.transactionpurchaseapp.view.ViewFragment
import com.udacoding.transactionpurchaseapp.view.home.customer.adapter.CustomerAdapter
import com.udacoding.transactionpurchaseapp.view.home.customer.adapter.CustomerAdapterLocal
import com.udacoding.transactionpurchaseapp.view.home.customer.model.DataItemCustomer
import com.udacoding.transactionpurchaseapp.view.home.customer.model.ResponseCustomer
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class CustomerFragment : Fragment() {

    @Inject
    lateinit var viewFragment: ViewFragment

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var bundle: Bundle

    private lateinit var viewModel: CustomerViewModel

    lateinit var binding: FragmentCustomerBinding

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentCustomerBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel = ViewModelProvider(this).get(CustomerViewModel::class.java)

        initView()
        observeData()

    }

    private fun observeData() {
        with(viewModel){
            customerAll.observe(viewLifecycleOwner, Observer { showData(it) })
            data_customer_local.observe(viewLifecycleOwner, Observer { showDataLocal(it) })
            loading.observe(viewLifecycleOwner, Observer { showLoading(it) })
            empty.observe(viewLifecycleOwner, Observer { showEmpty(it) })
            error.observe(viewLifecycleOwner, Observer { showError(it) })
            is_empty.observe(viewLifecycleOwner, Observer {
                if (it == true){
                    binding.imageEmpty.show()
                    binding.recyclerView.hide()
                } else {
                    binding.imageEmpty.hide()
                    binding.recyclerView.show()
                }
            })
        }
    }

    private fun showEmpty(it: Boolean?) {
        if (it == true) {
            Toast.makeText(activity?.applicationContext, "message", Toast.LENGTH_SHORT).show()
        }
    }

    private fun showError(it: Throwable?) {
        activity?.applicationContext?.let { it1 -> showToast(it1, it?.message) }
    }


    private fun showData(it: ResponseCustomer?) {
        binding.recyclerView.adapter =
            activity?.applicationContext?.let { it1 -> CustomerAdapter(it1, it?.data, object : CustomerAdapter.OnClickListener {
                override fun viewImage(item: String?) {
                    bundle.putString("url", BASE_URL_IMAGE_CUSTOMER+item)
                    viewFragment.arguments = bundle
                    viewFragment.show(activity?.supportFragmentManager!!, "")
                }

                override fun item(item: DataItemCustomer?) {

                }

            }) }
    }

    private fun showDataLocal(it: List<EntityCustomer>?) {
        binding.recyclerView.adapter =
            activity?.applicationContext?.let { it1 -> CustomerAdapterLocal(it1, it, object : CustomerAdapterLocal.OnClickListener {
                override fun viewImage(item: String?) {
                    bundle.putString("url", BASE_URL_IMAGE_CUSTOMER+item)
                    viewFragment.arguments = bundle
                    viewFragment.show(activity?.supportFragmentManager!!, "")
                }

                override fun item(item: EntityCustomer?) {

                }

            }) }
    }

    private fun showLoading(it: Boolean?) {
        if (it == true) binding.progressBar.show()
        else binding.progressBar.hide()
    }

    private fun initView() {
        viewModel.getCustomerAll(session.id_company)

        binding.textViewSearch.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {
                viewModel.searchCustomer(session.id_company, s.toString())
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
            }

        })

        binding.fab.setOnClickListener {
            activity?.openActivity(PostCustomerActivity::class.java)
        }
    }

    override fun onResume() {
        super.onResume()
        initView()
    }

}