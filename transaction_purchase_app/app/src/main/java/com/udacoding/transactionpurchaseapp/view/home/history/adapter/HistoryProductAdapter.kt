package com.udacoding.transactionpurchaseapp.view.home.history.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.ItemHistoryDetailBinding
import com.udacoding.transactionpurchaseapp.utils.Constant
import com.udacoding.transactionpurchaseapp.view.home.history.model.DetailTransaksiItem
import com.udacoding.transactionpurchaseapp.view.home.home.adapter.ProductAdapter
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataItemProduct

class HistoryProductAdapter(
    private val context: Context,
    private val data: List<DetailTransaksiItem?>?,
    private val itemClick: HistoryProductAdapter.OnClickListener
) : RecyclerView.Adapter<HistoryProductAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding =
            ItemHistoryDetailBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(context, binding, itemClick)
    }

    override fun getItemCount(): Int = data?.size ?: 0

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = data?.get(position)
        holder.bind(item)
    }

    class ViewHolder(val context: Context, val binding: ItemHistoryDetailBinding, val itemClick: HistoryProductAdapter.OnClickListener) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(item: DetailTransaksiItem?) {
            binding.textViewNameProduct.text = item?.product?.productName
            binding.textViewQtyProduct.text = item?.qty

            Glide.with(context)
                .load(Constant.Companion.url.BASE_URL_IMAGE_PRODUCT +item?.product?.productImage)
                .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
                .error(R.drawable.ex_product).into(binding.imageViewProduct)

            binding.imageViewProduct.setOnClickListener {
                itemClick.viewImage(item?.product?.productImage)
            }

        }
    }

    interface OnClickListener {
        fun viewImage(item: String?)
    }
}