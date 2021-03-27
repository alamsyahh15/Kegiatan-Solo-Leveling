package com.udacoding.transactionpurchaseapp.dagger_hilt

import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.network.ApiService
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.url.BASE_URL
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import io.reactivex.rxjava3.disposables.CompositeDisposable
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava3.RxJava3CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
class NetworkModule {

    @Provides
    @Singleton
    fun provideOkhttpClient(session: SessionManager): OkHttpClient {
        val interceptor = HttpLoggingInterceptor()
        interceptor.level = HttpLoggingInterceptor.Level.BODY

//        val accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjNjOTQ3OTdlZDczNjNkMjVlZWExYTNlYzRlOWEwODk2YTFkMzMwMGY1NGQ1YzBiN2NmN2NjY2FlYjc3M2FhNmM2ODFhOGUyZTg5MDI0MjUiLCJpYXQiOjE1OTMwNjYzNzQsIm5iZiI6MTU5MzA2NjM3NCwiZXhwIjoxNjI0NjAyMzc0LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.ZHsk021XpoPZRVxbyq5PEF198MkmvVYQ3gzfPOUORRZ-NtK7C783xB-6-Vc3Wt0HcysFgObcrrpRZpdpDFPp3uGPbXift7P4ByxN-hmMCqO-c9k3V1rkAnwIuMWGXUQqsTNlXiZ-HkQAY6W7kjG6nD-u_AiWTtFkcvMkSljxe3uZtg8e7K9bW6HBYvk-6B9VlJzBkXAuELdan5QCADdnkdWRZyfQgyXIzO7JUoEReTnql9bwnUcewOviK6mwD52lsTe3R530gFkhdkfs1MlUcByBYky6Rec5yN0X3IbN7padah9chhDjQfWkvMh4H18-WGZi1mu4NX6tuPIFhegBaBzV2ictCPI2kyDZ0zp-f3gIe0cRfTn5WhEgQyZckob3btjmq0rr6hPT1N_4mjaCUDyo7lTkp-QMr48C9JA4YpVmM7fxddhtCewcHwoQSxfcJvHQUU0I0FqCzmZIJTpf-z_ei1AvcFoEy4v3y1BFmfQnjCvp_EO6S5wfVYzq8DRgcgM_VBfmlYyllWbd3Pdxye1YvlNOXLmhJtwyE9iiamd33Wo_66qE_4Bu1pzhzWOAPXhBgP5o26nQ6S40ujT2j4u3p8y4ZA5C4l_Y1cfbPzr1HlYObO2z5J4Hr4h_34DTL3wJGv-aCBurPLmviRkLGN3RJMoZlgvxGrgq-nteqZA"

        val builder = OkHttpClient.Builder().addInterceptor(interceptor).apply {
            readTimeout(10, TimeUnit.SECONDS)
            connectTimeout(5, TimeUnit.SECONDS)
            addInterceptor { chain ->
                val request = chain.request().newBuilder()
                    .addHeader(
                        "Authorization",
                        "Bearer ${session.get_token}"
                    ).build()
                chain.proceed(request)
            }
        }
        return builder.build()
    }


    @Provides
    @Singleton
    fun provideApiService(okHttpClient: OkHttpClient): ApiService {
        return Retrofit.Builder().baseUrl(BASE_URL)
            .client(okHttpClient)
            .addConverterFactory(GsonConverterFactory.create())
            .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
            .build()
            .create(ApiService::class.java)
    }

    @Provides
    @Singleton
    fun provideString(): String {
        return "inject String"
    }

    @Provides
    @Singleton
    fun provideCompositeDisposable(): CompositeDisposable = CompositeDisposable()
}


