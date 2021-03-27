package com.udacoding.transactionpurchaseapp.dagger_hilt

import android.app.AlertDialog
import android.app.Application
import android.app.Dialog
import android.content.Context
import android.os.Bundle
import android.view.View
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.room.dao.DaoProduct
import com.udacoding.transactionpurchaseapp.view.FragmentProgress
import com.udacoding.transactionpurchaseapp.view.ViewFragment
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
class AppModule {

    @Provides
    @Singleton
    fun provideContext(application: Application): Context {
        return application.applicationContext
    }

    @Provides
    @Singleton
    fun provideSession(context: Context): SessionManager {
        return SessionManager(context)
    }

    @Provides
    @Singleton
    fun provideDialogProgress(): FragmentProgress = FragmentProgress()

    @Provides
    @Singleton
    fun provideViewFragment(): ViewFragment = ViewFragment()

    @Provides
    @Singleton
    fun provideBundle(): Bundle = Bundle()

    @Provides
    @Singleton
    fun provideView(context: Context): View {
        return View(context)
    }



}