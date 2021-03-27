package com.udacoding.transactionpurchaseapp.view.login

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.udacoding.transactionpurchaseapp.repository.RepositoryUser
import com.udacoding.transactionpurchaseapp.utils.validationEmail
import com.udacoding.transactionpurchaseapp.view.login.model.ResponseLogin
import retrofit2.HttpException

class LoginViewModel @ViewModelInject constructor(val repository: RepositoryUser) : ViewModel() {

    private val _login = MutableLiveData<ResponseLogin>()
    val login: LiveData<ResponseLogin> = _login

    private val _error = MutableLiveData<Throwable>()
    val error: LiveData<Throwable> = _error

    private val _status_code = MutableLiveData<Int>()
    val status_code: LiveData<Int> = _status_code

    private val _loading = MutableLiveData<Boolean>()
    val loading: LiveData<Boolean> = _loading

    private val _empty_user = MutableLiveData<Boolean>()
    val empty_user: LiveData<Boolean> = _empty_user

    private val _email_invalid = MutableLiveData<Boolean>()
    val email_invalid: LiveData<Boolean> = _email_invalid

    private val _empty_pass = MutableLiveData<Boolean>()
    val empty_pass: LiveData<Boolean> = _empty_pass

    private val _empty = MutableLiveData<Boolean>()
    val empty: LiveData<Boolean> = _empty

    fun loginUser(
        username: String?,
        password: String?
    ) {
        _loading.value = true
        if (username?.equals("") == true) {
            _empty_user.value = true
            _loading.value = false
        } else if (!validationEmail(username)) {
            _email_invalid.value = true
            _loading.value = false
        } else if (password?.equals("") == true) {
            _empty_pass.value = true
            _loading.value = false
        } else if (username?.equals("") == true && password?.equals("") == true) {
            _empty.value = true
            _loading.value = false
        } else {
            repository.apiLogin(username, password, {
                _login.value = it
                _loading.value = false
            }, {
                if (it is HttpException){
                    _status_code.value = it.code()
                } else {
                    _error.value = it
                }
                _loading.value = false
            })
        }
    }
}