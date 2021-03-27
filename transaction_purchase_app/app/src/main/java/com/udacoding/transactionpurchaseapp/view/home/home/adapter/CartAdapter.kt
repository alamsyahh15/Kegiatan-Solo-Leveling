package com.udacoding.transactionpurchaseapp.view.home.home.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.LayoutItemCartBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityCart
import com.udacoding.transactionpurchaseapp.utils.Constant
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_PRODUCT
import com.udacoding.transactionpurchaseapp.utils.toRinggit

class CartAdapter(
    private val context: Context,
    private val data: List<EntityCart?>?
) : RecyclerView.Adapter<CartAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding =
            LayoutItemCartBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(context, binding)
    }

    override fun getItemCount(): Int = data?.size ?: 0

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = data?.get(position)
        holder.bind(item)
    }

    class ViewHolder(val context: Context, val binding: LayoutItemCartBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(item: EntityCart?) {
            binding.textViewNameProduct.text = item?.name_product
            binding.textViewPriceProduct.text = toRinggit(item?.price_product?.toDouble())
            binding.textViewQty.text = context.getString(R.string.qty, item?.qty.toString())
            binding.textViewPay.text =
                context.getString(R.string.payment_item, toRinggit(item?.total_item_price ?: 0.0))
            Glide.with(context).load(BASE_URL_IMAGE_PRODUCT+item?.image_product)
                .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
                .error(R.drawable.ex_product).into(binding.imageViewProduct)
        }
    }
}