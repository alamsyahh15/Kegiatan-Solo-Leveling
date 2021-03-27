package com.udacoding.transactionpurchaseapp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import com.udacoding.transactionpurchaseapp.utils.moveActivity
import com.udacoding.transactionpurchaseapp.view.home.HomeActivity
import com.udacoding.transactionpurchaseapp.view.login.LoginActivity
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {

    @Inject
    lateinit var session: SessionManager

    private val DELAY = 3000L

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        Handler().postDelayed({
            if (session.is_login)
                moveActivity(HomeActivity::class.java)
            else
                moveActivity(LoginActivity::class.java)
        }, DELAY)
    }
}