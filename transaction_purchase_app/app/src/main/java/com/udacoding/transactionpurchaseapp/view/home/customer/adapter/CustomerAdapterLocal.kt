package com.udacoding.transactionpurchaseapp.view.home.customer.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.LayoutItemCustomerBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityCustomer
import com.udacoding.transactionpurchaseapp.utils.Constant
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_CUSTOMER
import com.udacoding.transactionpurchaseapp.view.home.customer.model.DataItemCustomer

class CustomerAdapterLocal(
    private val context: Context,
    private val data: List<EntityCustomer?>?,
    private val itemClick: OnClickListener
) : RecyclerView.Adapter<CustomerAdapterLocal.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding =
            LayoutItemCustomerBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(context, binding, itemClick)
    }

    override fun getItemCount(): Int = data?.size ?: 0

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = data?.get(position)
        holder.bind(item)
    }

    class ViewHolder(
        val context: Context,
        val binding: LayoutItemCustomerBinding,
        val itemClick: OnClickListener
    ) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(item: EntityCustomer?) {
            binding.textViewName.text = item?.customer_name
            binding.textViewPhone.text = item?.customer_telp
            Glide.with(context)
                .load(BASE_URL_IMAGE_CUSTOMER+item?.customer_image)
                .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
                .error(R.drawable.ex_product).into(binding.imageViewPhoto)

            binding.imageViewPhoto.setOnClickListener {
                itemClick.viewImage(item?.customer_image)
            }

            binding.root.setOnClickListener {
                itemClick.item(item)
            }
        }
    }

    interface OnClickListener {
        fun viewImage(item: String?)
        fun item(item: EntityCustomer?)
    }
}