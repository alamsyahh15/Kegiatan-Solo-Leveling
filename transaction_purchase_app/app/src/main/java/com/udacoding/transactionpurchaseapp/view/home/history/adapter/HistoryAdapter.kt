package com.udacoding.transactionpurchaseapp.view.home.history.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.ItemHistoryBinding
import com.udacoding.transactionpurchaseapp.utils.Constant
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.UNPAID
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.INVOICE
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_CUSTOMER
import com.udacoding.transactionpurchaseapp.utils.formatDate
import com.udacoding.transactionpurchaseapp.utils.toRinggit
import com.udacoding.transactionpurchaseapp.view.home.history.model.DataItemHistory

class HistoryAdapter(
    private val context: Context,
    private val data: List<DataItemHistory?>?,
    private val itemClick: OnClickListener?
) : RecyclerView.Adapter<HistoryAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding =
            ItemHistoryBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(context, binding, itemClick)
    }

    override fun getItemCount(): Int = data?.size ?: 0

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = data?.get(position)
        holder.bind(item)
    }

    class ViewHolder(
        val context: Context,
        val binding: ItemHistoryBinding,
        val itemClick: OnClickListener?
    ) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(item: DataItemHistory?) {
            binding.textViewCode.text = context.getString(R.string.code, item?.transactionCode)
            binding.textViewCustomer.text = item?.customer?.customerName
            binding.textViewDate.text = formatDate(item?.createdAt)
            if (item?.transactionStatus == INVOICE){
                binding.textViewPayment.text = item.transactionStatus
            } else if (item?.paymentMethod == UNPAID) {
                binding.textViewPayment.text = context.getString(R.string.cod)
            } else {
                binding.textViewPayment.text    = item?.paymentMethod
            }
            binding.textViewPrice.text = toRinggit(item?.totalPrice?.toDouble())
            Glide.with(context)
                .load(BASE_URL_IMAGE_CUSTOMER+item?.customer?.customerImage)
                .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
                .error(R.drawable.ic_person).into(binding.imageView)

            binding.root.setOnClickListener {
                itemClick?.detail(item)
            }
        }
    }

    interface OnClickListener {
        fun detail(item: DataItemHistory?)
    }
}