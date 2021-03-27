package com.udacoding.transactionpurchaseapp.view.home.home.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.LayoutItemKategoriBinding
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataItemKategori

class KategoriAdapter(
    private val context: Context,
    private val data: List<DataItemKategori?>?,
    private val itemClick: OnClickListener
) : RecyclerView.Adapter<KategoriAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding =
            LayoutItemKategoriBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(context, binding, itemClick)
    }

    override fun getItemCount(): Int = data?.size ?: 0

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = data?.get(position)

        holder.bind(item)

    }

    class ViewHolder(
        val context: Context,
        val binding: LayoutItemKategoriBinding,
        val itemClick: OnClickListener
    ) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(item: DataItemKategori?) {
            binding.textViewNameKategori.text = item?.kategoriName

            binding.textViewNameKategori.background = context.getDrawable(R.drawable.border_light_gray)

            binding.root.setOnClickListener {
                itemClick.choose(item)
                binding.textViewNameKategori.background = context.getDrawable(R.drawable.border_smooth_blue)
            }


        }

    }

    interface OnClickListener {
        fun choose(item: DataItemKategori?)
    }
}