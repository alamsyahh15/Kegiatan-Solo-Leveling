package com.udacoding.transactionpurchaseapp.view.home.home

import android.content.Intent
import android.graphics.Color
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.Fragment
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
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.udacoding.transactionpurchaseapp.BuildConfig
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.DialogAddCartBinding
import com.udacoding.transactionpurchaseapp.databinding.FragmentHomeBinding
import com.udacoding.transactionpurchaseapp.room.model.EntityCart
import com.udacoding.transactionpurchaseapp.room.model.EntityProduct
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_PRODUCT
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL_IMAGE_USER
import com.udacoding.transactionpurchaseapp.view.ViewFragment
import com.udacoding.transactionpurchaseapp.view.home.home.adapter.KategoriAdapter
import com.udacoding.transactionpurchaseapp.view.home.home.adapter.ProductAdapter
import com.udacoding.transactionpurchaseapp.view.home.home.adapter.ProductAdapterLocal
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataItemKategori
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataItemProduct
import com.udacoding.transactionpurchaseapp.view.home.home.model.ResponseListKategori
import com.udacoding.transactionpurchaseapp.view.home.home.model.ResponseListProduct
import com.udacoding.transactionpurchaseapp.view.home.home.viewmodel.HomeViewModel
import com.udacoding.transactionpurchaseapp.view.home.profile.ProfileViewModel
import com.udacoding.transactionpurchaseapp.view.home.profile.model.ResponseProfileUser
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class HomeFragment : Fragment() {

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var viewFragment: ViewFragment

    @Inject
    lateinit var bundle: Bundle

    lateinit var dialogBottom: BottomSheetDialog

    lateinit var dialogAddCartImageBinding: DialogAddCartBinding

    private lateinit var viewModel: HomeViewModel

    private lateinit var viewModelProfile: ProfileViewModel

    private lateinit var binding: FragmentHomeBinding

    private var last_count: Int? = null

    private var pay_total_item: Double? = null

    private var item_product: DataItemProduct? = null

    private var flag_update: Boolean? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentHomeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(this).get(HomeViewModel::class.java)
        viewModelProfile = ViewModelProvider(this).get(ProfileViewModel::class.java)

        initView()
        observeData()

    }

    private fun initView() {

        viewModel.versionApp()

        binding.textViewNameCompany.text = session.company_name

        viewModelProfile.profileUser(session.id_user)

        binding.textViewSearch.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {
                viewModel.searchProduct(session.id_company, s.toString())
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
            }

        })

        dialogAddCartImageBinding =
            DialogAddCartBinding.bind(View.inflate(context, R.layout.dialog_add_cart, null))

        with(viewModel) {
            getProductByCompany(session.id_company)
            getKategoriByCompany(session.id_company)
            getCartLocal()

            binding.btnAllProduct.setOnClickListener {
                getProductByCompany(session.id_company)
            }
        }

        binding.cardViewTotalPay.setOnClickListener {
            activity?.openActivity(CartActivity::class.java)
        }

    }

    private fun observeData() {

        viewModelProfile.profileUser.observe(viewLifecycleOwner, Observer { showProfile(it) })

        with(viewModel) {
            productByCompany.observe(viewLifecycleOwner, Observer { showData(it) })
            kategoriByCompany.observe(viewLifecycleOwner, Observer { showKategori(it) })

            loading.observe(
                viewLifecycleOwner,
                Observer { loadingFragment(it, binding.progressBar) })

            error.observe(
                viewLifecycleOwner,
                Observer { showError(activity?.applicationContext, it) })

            data_product_local.observe(viewLifecycleOwner, Observer { showDataLocal(it) })

            count.observe(viewLifecycleOwner, Observer {
                last_count = it
                dialogAddCartImageBinding.textViewCount.text = last_count.toString()

                changeButtonAdd(it)
            })

            total_item_pay.observe(
                viewLifecycleOwner,
                Observer {
                    pay_total_item = it
                    dialogAddCartImageBinding.textViewTotal.text = toRinggit(it)
                })

            button_plus.observe(viewLifecycleOwner, Observer { buttonPlus(it) })

            button_minus.observe(viewLifecycleOwner, Observer { buttonMinus(it) })

            add_to_cart.observe(viewLifecycleOwner, Observer {
                dialogBottom.dismiss()
                getCartLocal()
                activity?.applicationContext?.let {
                    showToast(
                        it,
                        getString(R.string.success_add_to_cart)
                    )
                }
            })

            total_pay.observe(
                viewLifecycleOwner,
                Observer { binding.textViewTotalPay.text = toRinggit(it ?: 0.0) })

            text_total_pay.observe(viewLifecycleOwner, Observer {
                if (it == true)
                    binding.cardViewTotalPay.show()
                else
                    binding.cardViewTotalPay.hide()
            })

            available_on_cart.observe(viewLifecycleOwner, Observer {
                actionAvailableCart(it)
            })

            update_qty_cart.observe(viewLifecycleOwner, Observer {
                if (it) {
                    dialogBottom.dismiss()
                    getCartLocal()
                    activity?.applicationContext?.let {
                        showToast(
                            it,
                            getString(R.string.success_update_cart)
                        )
                    }
                }
            })

            delete_cart.observe(viewLifecycleOwner, Observer {
                if (it) {
                    dialogBottom.dismiss()
                    getCartLocal()
                    activity?.applicationContext?.let {
                        showToast(
                            it,
                            getString(R.string.success_delete_cart)
                        )
                    }
                }

            })

            is_empty.observe(viewLifecycleOwner, Observer {
                if (it == true){
                    binding.imageEmpty.show()
                    binding.recyclerView.hide()
                } else {
                    binding.imageEmpty.hide()
                    binding.recyclerView.show()
                }
            })

            version_app.observe(viewLifecycleOwner, Observer {

                if (it?.data?.version != BuildConfig.VERSION_NAME){

                    try {

                        context?.let { it1 ->
                            AlertDialog.Builder(it1).apply {
                                setTitle(getString(R.string.message))
                                setCancelable(false)
                                setMessage("New Update Version, open playstore to update your application version")
                                setPositiveButton("Ok") { dialog, which ->
                                    val intent = Intent(Intent.ACTION_VIEW).apply {
                                        data = Uri.parse(
                                            "https://play.google.com/store/apps/details?id=my.riderunner.app_client1")
                                        setPackage("com.android.vending")
                                        //                        data = Uri.parse(
                                        //                            "https://play.google.com/store/apps/details?id=com.udacoding.transactionpurchaseapp")
                                        //                        setPackage("com.android.vending")
                                    }
                                    startActivity(intent)
                                }
                            }.show()
                        }

                    } catch (e: Exception){
                        Toast.makeText(context, e.message.toString(), Toast.LENGTH_SHORT).show()
                    }


                }

            })


        }

    }

    override fun onResume() {
        super.onResume()
        viewModel.getCartLocal()
        viewModel.versionApp()
    }

    private fun showProfile(it: ResponseProfileUser?) {

//        binding.textViewNameCompany.text = "${BASE_URL_IMAGE_USER+it?.data?.userPhoto}"

        Glide.with(binding.imageViewPhotoProfile).load(BASE_URL_IMAGE_USER+it?.data?.userPhoto)
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
            .error(R.drawable.ex_product).into(binding.imageViewPhotoProfile)
    }


    private fun actionAvailableCart(it: List<EntityCart>?) {
        if (it?.isNotEmpty() == true)
            showAddToCart(
                item_product,
                it.get(0).id_cart ?: 0,
                it.get(0).qty ?: 0,
                it.get(0).total_item_price ?: 0.0
            )
        else
            showAddToCart(
                item_product,
                0,
                0,
                0.0
            )
    }

    private fun changeButtonAdd(it: Int?) {
        when (it){
            0 -> {
                if (flag_update == true){
                    with(dialogAddCartImageBinding) {
                        buttonAdd.text = getString(R.string.delete_from_cart)
                        buttonAdd.setBackgroundResource(R.drawable.border_maroon)
                        buttonAdd.setTextColor(Color.BLACK)
                        buttonAdd.setOnClickListener {
                            viewModel.deleteCart(
                                item_product?.idProduct ?: 0
                            )
                        }
                    }
                } else {
                    with(dialogAddCartImageBinding) {
                        buttonAdd.text = getString(R.string.back_to_list)
                        buttonAdd.setOnClickListener {
                            dialogBottom.dismiss()
                        }
                    }
                }
            }
            else -> {
                if (flag_update == true){
                    with(dialogAddCartImageBinding) {
                        buttonAdd.text = getString(R.string.update_cart)
                        buttonAdd.setBackgroundResource(R.drawable.button_smooth_blue)
                        buttonAdd.setTextColor(Color.WHITE)
                        buttonAdd.setOnClickListener {
                            viewModel.updateQtyCart(
                                item_product?.idProduct ?: 0,
                                last_count ?: 0,
                                pay_total_item ?: 0.0
                            )
                        }
                    }
                } else {
                    with(dialogAddCartImageBinding) {
                        buttonAdd.text = getString(R.string.add_to_cart)
                        buttonAdd.setBackgroundResource(R.drawable.button_smooth_blue)
                        buttonAdd.setTextColor(Color.WHITE)
                        buttonAdd.setOnClickListener {
                            viewModel.addToCart(
                                EntityCart(
                                    null,
                                    session.id_user,
                                    null,
                                    item_product?.idProduct,
                                    item_product?.productName,
                                    item_product?.productPrice,
                                    item_product?.productImage,
                                    last_count,
                                    pay_total_item
                                )
                            )

                        }
                    }
                }

            }
        }

    }

    private fun buttonPlus(it: Boolean?) {
        if (it == true)
            dialogAddCartImageBinding.imageViewPlus.show()
        else
            dialogAddCartImageBinding.imageViewPlus.hide()
    }

    private fun buttonMinus(it: Boolean?) {
        if (it == true)
            dialogAddCartImageBinding.imageViewMinus.show()
        else
            dialogAddCartImageBinding.imageViewMinus.hide()
    }

    private fun showData(it: ResponseListProduct?) {
        binding.recyclerView.adapter =
            activity?.applicationContext?.let { it1 ->
                ProductAdapter(it1, it?.data, object : ProductAdapter.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", BASE_URL_IMAGE_PRODUCT+item)
                        viewFragment.arguments = bundle
                        viewFragment.show(activity?.supportFragmentManager!!, "")
                    }

                    override fun addCart(item: DataItemProduct?) {
                        item_product = item
                        viewModel.checkAvailableOnCart(item?.idProduct ?: 0)
                    }

                })
            }
    }

    private fun showKategori(it: ResponseListKategori?) {
        binding.recyclerViewKategori.adapter =
            activity?.applicationContext?.let { it1 ->
                KategoriAdapter(it1, it?.data, object : KategoriAdapter.OnClickListener {
                    override fun choose(item: DataItemKategori?) {
                        viewModel.getProductByCategory(session.id_company, item?.idKategori)
                    }
                })
            }
    }

    private fun showDataLocal(it: List<EntityProduct>?) {
        binding.recyclerView.adapter =
            activity?.applicationContext?.let { it1 ->
                ProductAdapterLocal(it1, it, object : ProductAdapterLocal.OnClickListener {
                    override fun viewImage(item: String?) {
                        bundle.putString("url", BASE_URL_IMAGE_PRODUCT+item)
                        viewFragment.arguments = bundle
                        viewFragment.show(activity?.supportFragmentManager!!, "")
                    }

                    override fun addCartLocal(item: EntityProduct?) {
                        showAddToCartLocal(item)
                    }
                })
            }
    }

    private fun showAddToCart(
        item: DataItemProduct?,
        id_cart: Int,
        qty: Int,
        total: Double
    ) {

        dialogAddCartImageBinding =
            DialogAddCartBinding.bind(View.inflate(context, R.layout.dialog_add_cart, null))
        dialogBottom = context?.let {
            BottomSheetDialog(it).apply {
                setContentView(dialogAddCartImageBinding.root)
                show()
            }
        } ?: return

        with(dialogAddCartImageBinding) {

            Glide.with(root)
                .load(BASE_URL_IMAGE_PRODUCT+item?.productImage)
                .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
                .error(R.drawable.ex_product).into(dialogAddCartImageBinding.imageViewProduct)

            if (item?.productStock?.toInt() == 0){

                textViewCount.text = getString(R.string.stock_empty)
                imageViewPlus.hide()
                imageViewMinus.hide()
                textViewTotal.text = toRinggit(item.productPrice?.toDouble() ?: 0.0)
                buttonAdd.text = getString(R.string.back_to_list)
                buttonAdd.setOnClickListener {
                    dialogBottom.dismiss()
                }

            } else if (id_cart > 0) {

                flag_update = true
                last_count = qty
                textViewCount.text = qty.toString()
                textViewTotal.text = toRinggit(total)

                buttonAdd.text = getString(R.string.update_cart)
                buttonAdd.setOnClickListener {
                    viewModel.updateQtyCart(
                        item?.idProduct ?: 0,
                        last_count ?: 0,
                        pay_total_item ?: 0.0
                    )
                }

            } else {

                flag_update = false
                last_count = 1
                textViewTotal.text =
                    toRinggit(item?.productPrice?.toDouble() ?: 0.0)

                pay_total_item = item?.productPrice?.toDouble() ?: 0.0

                imageViewMinus.hide()

                buttonAdd.setOnClickListener {
                    viewModel.addToCart(
                        EntityCart(
                            null,
                            session.id_user,
                            null,
                            item?.idProduct,
                            item?.productName,
                            item?.productPrice,
                            item?.productImage,
                            last_count,
                            pay_total_item
                        )
                    )
                }

            }

            textViewNameProduct.text = item?.productName
            textViewDescProduct.text = item?.productDesc
            textViewPriceProduct.text =
                toRinggit(item?.productPrice?.toDouble() ?: 0.0)
            textViewStockProduct.text =
                getString(R.string.stock, item?.productStock)

            imageViewPlus.setOnClickListener {
                viewModel.actionCount(
                    1,
                    last_count ?: 0,
                    item?.productStock?.toInt() ?: 0,
                    item?.productPrice?.toDouble() ?: 0.0
                )
            }

            imageViewMinus.setOnClickListener {
                viewModel.actionCount(
                    0,
                    last_count ?: 0,
                    item?.productStock?.toInt() ?: 0,
                    item?.productPrice?.toDouble() ?: 0.0
                )
            }

        }
    }

    private fun showAddToCartLocal(item: EntityProduct?) {
        dialogBottom = context?.let {
            BottomSheetDialog(it).apply {
                setContentView(dialogAddCartImageBinding.root)
                show()
            }
        } ?: return

        Glide.with(dialogAddCartImageBinding.root)
            .load(BASE_URL_IMAGE_PRODUCT+item?.productImage)
            .transform(CenterCrop(), RoundedCorners(Constant.Companion.value.ROUND_IMAGE))
            .error(R.drawable.ex_product).into(dialogAddCartImageBinding.imageViewProduct)

        dialogAddCartImageBinding.textViewNameProduct.text = item?.productName
        dialogAddCartImageBinding.textViewDescProduct.text = item?.productDesc
        dialogAddCartImageBinding.textViewPriceProduct.text =
            toRinggit(item?.productPrice?.toDouble() ?: 0.0)
        dialogAddCartImageBinding.textViewStockProduct.text =
            getString(R.string.stock, item?.productStock.toString())

    }

}