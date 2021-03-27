package com.udacoding.transactionpurchaseapp.view

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.DialogFragment.STYLE_NORMAL
import com.bumptech.glide.Glide
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.FragmentViewBinding
import it.sephiroth.android.library.imagezoom.ImageViewTouchBase

class ViewFragment : DialogFragment() {

    lateinit var binding: FragmentViewBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NORMAL, R.style.FullscreenDialogTheme)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentViewBinding.inflate(layoutInflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val url = arguments?.getString("url")

        binding.btnClose.setOnClickListener { dismiss() }

        binding.imgDialog.displayType = ImageViewTouchBase.DisplayType.FIT_TO_SCREEN
        Glide.with(this).load(url).error(R.drawable.ex_product).into(binding.imgDialog)

    }
}