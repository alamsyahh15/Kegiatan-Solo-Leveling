package com.udacoding.transactionpurchaseapp.view.login

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import com.google.android.material.snackbar.Snackbar
import com.udacoding.transactionpurchaseapp.BuildConfig
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.databinding.ActivityLoginBinding
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.view.FragmentProgress
import com.udacoding.transactionpurchaseapp.view.home.HomeActivity
import com.udacoding.transactionpurchaseapp.view.login.model.ResponseLogin
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class LoginActivity : AppCompatActivity() {

    private lateinit var binding: ActivityLoginBinding

    private val viewModel: LoginViewModel by viewModels()

    @Inject
    lateinit var str: String

    @Inject
    lateinit var session: SessionManager

    @Inject
    lateinit var dialogProgress: FragmentProgress

    @Inject
    lateinit var view: View

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityLoginBinding.inflate(layoutInflater)
        view = binding.root
        setContentView(view)

        initView()
        observeData()

    }

    private fun initView() {

        binding.textVersion?.text = "Version ${BuildConfig.VERSION_NAME}"

        binding.textRegister?.setOnClickListener {
            val intent = Intent(Intent.ACTION_VIEW)
            intent.data = Uri.parse("http://www.rikod.my/tutorial")
            startActivity(intent)
        }

        dialogProgress.isCancelable = false

        binding.buttonLogin.setOnClickListener {
            viewModel.loginUser("${binding.editTextEmail.text}", "${binding.editTextPassword.text}")
        }
    }

    private fun observeData() {
        with(viewModel) {
            login.observe(this@LoginActivity, Observer { actionLogin(it) })
            status_code.observe(this@LoginActivity, Observer { handleStatusCode(it) })
            empty.observe(this@LoginActivity, Observer { actionEmpty(it) })
            empty_user.observe(
                this@LoginActivity,
                Observer {
                    requiredEditText(
                        it,
                        binding.editTextEmail,
                        getString(R.string.email_required)
                    )
                })
            email_invalid.observe(
                this@LoginActivity,
                Observer {
                    requiredEditText(
                        it,
                        binding.editTextEmail,
                        getString(R.string.invalid_email)
                    )
                })
            empty_pass.observe(
                this@LoginActivity,
                Observer {
                    requiredEditText(
                        it,
                        binding.editTextPassword,
                        getString(R.string.password_required)
                    )
                })
            error.observe(
                this@LoginActivity,
                Observer {
                    showError(
                        applicationContext,
                        it
                    )
                })

            loading.observe(
                this@LoginActivity,
                Observer {
                    showLoading(
                        it,
                        supportFragmentManager,
                        dialogProgress)
                })
        }
    }

    private fun handleStatusCode(it: Int?) {
        when (it) {
            401 -> showAlert("Message", getString(R.string.no_auth), true)
        }
    }

    private fun actionEmpty(it: Boolean?) {
        if (it == true) {
            binding.editTextEmail.error = getString(R.string.email_required)
            binding.editTextPassword.error = getString(R.string.password_required)
        }
    }

    private fun actionLogin(it: ResponseLogin?) {
        if (it?.isSuccess == true) {
            session.apply {
                createLoginSession(it.data?.token ?: "")
                id_user = it.data?.user?.idUser ?: 0
                id_company = it.data?.user?.companyId?.toInt() ?: 0
                company_name = it.data?.company.toString()
                name_user = it.data?.user?.userName ?: ""
            }
            moveActivity(HomeActivity::class.java)
        } else {
            view.showSnackbar(it?.message.toString(), Snackbar.LENGTH_LONG)
        }

    }

}