package com.udacoding.transactionpurchaseapp.view.home.history.adapter

import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.viewpager2.adapter.FragmentStateAdapter
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.CASH
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.TRANSFER
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.UNPAID
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.QUOTATION
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.VOID
import com.udacoding.transactionpurchaseapp.view.home.customer.CustomerFragment
import com.udacoding.transactionpurchaseapp.view.home.history.*
import com.udacoding.transactionpurchaseapp.view.home.profile.ProfileFragment

class PagerAdapter(fragment: Fragment) : FragmentStateAdapter(fragment) {

    private val ARG_OBJECT = "object"

    private val tab_name = arrayListOf(CASH, TRANSFER, QUOTATION, UNPAID, VOID)

    override fun getItemCount(): Int = 5

    override fun createFragment(position: Int): Fragment {

        var fragment = Fragment()

        when(position){
            0 -> {
                fragment = CashFragment()
                fragment.arguments = Bundle().apply {
                    putStringArrayList(ARG_OBJECT, tab_name)
                }
                return fragment
            }
            1 -> {
                fragment = TransferFragment()
                fragment.arguments = Bundle().apply {
                    putStringArrayList(ARG_OBJECT, tab_name)
                }
                return fragment
            }
            2 -> {
                fragment = QuotationFragment()
                fragment.arguments = Bundle().apply {
                    putStringArrayList(ARG_OBJECT, tab_name)
                }
                return fragment
            }
            3 -> {
                fragment = UnpaidFragment()
                fragment.arguments = Bundle().apply {
                    putStringArrayList(ARG_OBJECT, tab_name)
                }
                return fragment
            }
            4 -> {
                fragment = VoidFragment()
                fragment.arguments = Bundle().apply {
                    putStringArrayList(ARG_OBJECT, tab_name)
                }
                return fragment
            }
        }

//        val fragment = FinanceFragment()
//        fragment.arguments = Bundle().apply {
//            // Our object is just an integer :-P
//            putInt(ARG_OBJECT, position + 1)
//        }
        return fragment
    }

}