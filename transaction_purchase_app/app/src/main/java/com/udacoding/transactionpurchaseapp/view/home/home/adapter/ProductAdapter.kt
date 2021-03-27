package com.udacoding.transactionpurchaseapp.view.home.home.adapter

import android.content.Context
import android.content.Entity
import android.database.DefaultDatabaseErrorHandler
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.LayoutItemProductBinding
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_PRODUCT
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.value.ROUND_IMAGE
import com.udacoding.transactionpurchaseapp.utils.toRinggit
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataItemProduct

class ProductAdapter(
    private val context: Context,
    private val data: List<DataItemProduct?>?,
    private val itemClick: OnClickListener
) : RecyclerView.Adapter<ProductAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding =
            LayoutItemProductBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(context, binding, itemClick)
    }

    override fun getItemCount(): Int = data?.size ?: 0

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = data?.get(position)

        holder.bind(item)

    }

    class ViewHolder(
        val context: Context,
        val binding: LayoutItemProductBinding,
        val itemClick: OnClickListener
    ) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(item: DataItemProduct?) {
            binding.textViewNameProduct.text = item?.productName
            binding.textViewDescProduct.text = item?.productDesc
            binding.textViewPriceProduct.text = toRinggit(item?.productPrice?.toDouble() ?: 0.0)
            binding.textViewStockProduct.text =
                context.getString(R.string.stock, item?.productStock)
            Glide.with(context)
                .load(BASE_URL_IMAGE_PRODUCT+item?.productImage)
                .transform(CenterCrop(), RoundedCorners(ROUND_IMAGE))
                .error(R.drawable.ex_product).into(binding.imageViewProduct)

            binding.imageViewProduct.setOnClickListener {
                itemClick.viewImage(item?.productImage)
            }

            binding.root.setOnClickListener {
                itemClick.addCart(item)
            }

        }

    }

    interface OnClickListener {
        fun viewImage(item: String?)
        fun addCart(item: DataItemProduct?)
    }
}