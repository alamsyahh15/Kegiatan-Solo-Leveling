package com.udacoding.transactionpurchaseapp.view.home.finance.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.LayoutItemPurchaseBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityPurchase
import com.udacoding.transactionpurchaseapp.utils.Constant
import com.udacoding.transactionpurchaseapp.utils.formatDate
import com.udacoding.transactionpurchaseapp.utils.toRinggit

class PurchaseAdapterLocal(
    private val context: Context,
    private val data: List<EntityPurchase?>?,
    private val itemClick: OnClickListener
) : RecyclerView.Adapter<PurchaseAdapterLocal.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding =
            LayoutItemPurchaseBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(context, binding, itemClick)
    }

    override fun getItemCount(): Int = data?.size ?: 0

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = data?.get(position)
        holder.bind(item)
    }

    class ViewHolder(
        val context: Context,
        val binding: LayoutItemPurchaseBinding,
        val itemClick: OnClickListener
    ) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(item: EntityPurchase?) {
            binding.textViewPurchase.text = toRinggit(item?.purchase?.toDouble() ?: 0.0)
            binding.textViewNote.text = item?.note
            binding.textViewDate.text = formatDate(item?.created_at)

            Glide.with(context)
                .load(Constant.Companion.url.BASE_URL_IMAGE_PURCHASE + item?.image)
                .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
                .error(R.drawable.ex_product).into(binding.imageViewPurchase)

            binding.imageViewPurchase.setOnClickListener {
                itemClick.viewImage(Constant.Companion.url.BASE_URL_IMAGE_PURCHASE + item?.image)
            }
        }
    }

    interface OnClickListener {
        fun viewImage(item: String?)
    }
}