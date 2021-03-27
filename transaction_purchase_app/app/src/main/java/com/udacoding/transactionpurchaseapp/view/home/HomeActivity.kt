package com.udacoding.transactionpurchaseapp.view.home

import android.content.Intent
import android.content.res.Configuration
import android.net.Uri
import android.os.Bundle
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.udacoding.transactionpurchaseapp.BuildConfig
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.databinding.ActivityHomeBinding
import com.udacoding.transactionpurchaseapp.view.home.customer.CustomerFragment
import com.udacoding.transactionpurchaseapp.view.home.finance.FinanceFragment
import com.udacoding.transactionpurchaseapp.view.home.history.HistoryFragment
import com.udacoding.transactionpurchaseapp.view.home.home.HomeFragment
import com.udacoding.transactionpurchaseapp.view.home.home.viewmodel.HomeViewModel
import com.udacoding.transactionpurchaseapp.view.home.profile.ProfileFragment
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.profile_fragment.*

@AndroidEntryPoint
class HomeActivity : AppCompatActivity() {

    private lateinit var binding: ActivityHomeBinding

    private lateinit var viewModel: HomeViewModel
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityHomeBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        initView()

//        observer()



    }

    private fun observer() {
//        viewModel.version_app.observe(this, Observer {
//
//            if (it?.data?.version != BuildConfig.VERSION_NAME){
//                AlertDialog.Builder(this).apply {
//                    title = getString(R.string.message)
//                    setCancelable(false)
//                    setMessage("New Update Version, open playstore to update your application version")
//                    setPositiveButton("Ok") { dialog, which ->
//                        val intent = Intent(Intent.ACTION_VIEW).apply {
//                            data = Uri.parse(
//                                "https://play.google.com/store/apps/details?id=my.riderunner.app_client1")
//                            setPackage("com.android.vending")
////                        data = Uri.parse(
////                            "https://play.google.com/store/apps/details?id=com.udacoding.transactionpurchaseapp")
////                        setPackage("com.android.vending")
//                        }
//                        startActivity(intent)
//                    }
//                }.show()
//
//            }
//
//        })
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
    }

    private fun initView() {

//        viewModel.versionApp()

        showFragment(HomeFragment())

        bottomNavigation()


    }

    private fun bottomNavigation(){
        binding.navView.setOnNavigationItemSelectedListener {
            when(it.itemId){
                R.id.navigation_home -> {
                    showFragment(HomeFragment())
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.navigation_finance -> {
                    showFragment(FinanceFragment())
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.navigation_history -> {
                    showFragment(HistoryFragment())
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.navigation_customer -> {
                    showFragment(CustomerFragment())
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.navigation_profile -> {
                    showFragment(ProfileFragment())
                    return@setOnNavigationItemSelectedListener true
                }
            }
            false
        }
    }

    private fun showFragment(fragmentDestination: Fragment){
        supportFragmentManager.beginTransaction().replace(R.id.container, fragmentDestination, fragmentDestination.javaClass.simpleName).commit()
    }
}

