package com.udacoding.transactionpurchaseapp.view.home.profile

import android.annotation.SuppressLint
import android.graphics.Color
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.bumptech.glide.Glide
import com.bumptech.glide.load.DataSource
import com.bumptech.glide.load.engine.GlideException
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.bumptech.glide.request.RequestListener
import com.bumptech.glide.request.target.Target
import com.udacoding.transactionpurchaseapp.BuildConfig
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.ProfileFragmentBinding
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_USER
import com.udacoding.transactionpurchaseapp.view.ViewFragment
import com.udacoding.transactionpurchaseapp.view.home.home.viewmodel.HomeViewModel
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseDataIncome
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseProfileUser
import com.udacoding.transactionpurchaseapp.view.login.LoginActivity
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class ProfileFragment : Fragment() {

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var viewFragment: ViewFragment

    @Inject
    lateinit var bundle: Bundle

    private lateinit var viewModel: ProfileViewModel
    private lateinit var viewModelHome: HomeViewModel

    private lateinit var binding: ProfileFragmentBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = ProfileFragmentBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(this).get(ProfileViewModel::class.java)
        viewModelHome = ViewModelProvider(this).get(HomeViewModel::class.java)

        initView()
        observeData()

    }

    private fun observeData() {
        with(viewModel) {
            profileUser.observe(viewLifecycleOwner, Observer { showData(it) })
            data_transfer.observe(viewLifecycleOwner, Observer {
                showDataTransfer(it)
            })
            data_unpaid.observe(viewLifecycleOwner, Observer { showDataUnpaid(it) })
            error.observe(viewLifecycleOwner, Observer { showError(activity?.applicationContext, it) })
        }
    }

    private fun showDataTransfer(it: Double?) {
        if (it != null){
            binding.textViewTransfer.text = toRinggit(it)

        }
    }

    private fun showDataUnpaid(it: Double?) {
        if (it != 0.0){
            binding.textViewUnpaid.setTextColor(resources.getColor(R.color.red))
        }

        binding.textViewUnpaid.text = toRinggit(it ?: 0.0)

    }

    private fun showData(it: ResponseProfileUser?) {

        Glide.with(binding.imageViewPhoto).load(BASE_URL_IMAGE_USER+it?.data?.userPhoto)
            .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
            .listener(object : RequestListener<Drawable> {
                override fun onLoadFailed(
                    e: GlideException?,
                    model: Any?,
                    target: Target<Drawable>?,
                    isFirstResource: Boolean
                ): Boolean {
                    binding.progressBarImage.hide()
                    return false
                }

                override fun onResourceReady(
                    resource: Drawable?,
                    model: Any?,
                    target: Target<Drawable>?,
                    dataSource: DataSource?,
                    isFirstResource: Boolean
                ): Boolean {
                    binding.progressBarImage.hide()
                    return false
                }

            })
            .error(R.drawable.ex_product).into(binding.imageViewPhoto)

        binding.textViewCustomer.text = it?.data?.userName
        binding.textViewTelp.text = it?.data?.userTelp.toString()
        binding.textViewCash.text = toRinggit(it?.data?.cashInHand?.toDouble())

    }

    private fun initView() {

        binding.versionApp.text = BuildConfig.VERSION_NAME

        binding.buttonLogout.setOnClickListener {

            viewModelHome.deleteCartAll()

            session.logout()

            activity?.moveActivity(LoginActivity::class.java)
        }

        with(viewModel){
            profileUser(session.id_user)
            dataTransferByIdUser(session.id_user)
        }


    }
}