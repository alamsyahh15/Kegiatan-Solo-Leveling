package com.udacoding.transactionpurchaseapp.dagger_hilt

import android.app.Application
import androidx.room.Room
import com.udacoding.transactionpurchaseapp.room.Database
import com.udacoding.transactionpurchaseapp.room.dao.DaoCart
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.database.NAME
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
class DatabaseModule {

    @Provides
    @Singleton
    fun provideDatabase(application: Application): Database {
        return Room.databaseBuilder(application, Database::class.java, NAME)
            .fallbackToDestructiveMigration()
            .build()
    }

    @Provides
    @Singleton
    fun provideDaoCart(database: Database): DaoCart {
        return database.daoCart()
    }

}