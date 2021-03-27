package com.udacoding.transactionpurchaseapp.view.home.history

import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.FragmentVoidBinding
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.VOID
import com.udacoding.transactionpurchaseapp.view.home.history.adapter.HistoryAdapter
import com.udacoding.transactionpurchaseapp.view.home.history.model.DataItemHistory
import com.udacoding.transactionpurchaseapp.view.home.history.model.ResponseTransactionByUser
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class VoidFragment : Fragment() {

    @Inject
    lateinit var session: SessionManager

    private lateinit var viewModel: HistoryViewModel

    private lateinit var binding: FragmentVoidBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentVoidBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(this).get(HistoryViewModel::class.java)

        initView()
        observeData()


    }

    private fun observeData() {
        with(viewModel){
            history.observe(viewLifecycleOwner, Observer {
                showData(it)
            })

            loading.observe(viewLifecycleOwner, Observer { loadingFragment(it, binding.progressBar) })

            is_empty.observe(viewLifecycleOwner, Observer {
                if (it == true){
                    binding.imageCredit.show()
                    binding.recyclerView.hide()
                } else {
                    binding.imageCredit.hide()
                    binding.recyclerView.show()
                }
            })

            error.observe(viewLifecycleOwner, Observer { showError(activity?.applicationContext, it) })

            empty_id_user.observe(viewLifecycleOwner, Observer { context?.let { it1 ->
                requiredToast(
                    it1, it, getString(R.string.id_not_found))
            } })
        }
    }

    private fun showData(it: ResponseTransactionByUser?) {
        binding.recyclerView.adapter = context?.let { it1 ->
            HistoryAdapter(it1, it?.data, object : HistoryAdapter.OnClickListener {
                override fun detail(item: DataItemHistory?) {

                    val intent = Intent(activity?.applicationContext, DetailHistoryActivity::class.java)
                    intent.putExtra("id_transaction", item?.idTransaction.toString())
                    startActivity(intent)

                }

            })
        }
    }

    private fun initView() {
        with(viewModel){
           historyTransaction(session.id_user,"", VOID)
        }
    }

    override fun onResume() {
        super.onResume()
        initView()
    }

}