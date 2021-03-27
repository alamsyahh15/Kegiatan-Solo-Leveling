package com.ojekamanah.app.utils

import android.Manifest
import android.app.AlertDialog
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.provider.Settings
import android.util.Log
import androidx.core.app.ActivityCompat


class GPSTracker(c: Context) : Service(), LocationListener {

    private var context: Context? = null
    internal var isGPSEnabled = false
    internal var isNetworkEnabled = false
    internal var canGetLocation = false
    internal var location: Location? = null
    internal var latitude: Double = 0.toDouble()
    internal var longitude: Double = 0.toDouble()

    private val TAG = "GPSTracker"

    protected var locationManager: LocationManager? = null

    val locations: Location?
        get() = if (location != null) {
            location
        } else null

    init {
        this.context = c
        getLocation()
    }

    private fun getLocation(): Location? {
        try {
            locationManager = context?.getSystemService(Context.LOCATION_SERVICE) as LocationManager

            // getting gps status
            isGPSEnabled = locationManager?.isProviderEnabled(LocationManager.GPS_PROVIDER) ?: false
            Log.d(TAG, "getLocation: Status GPS $isGPSEnabled")
            // getting network status
            isNetworkEnabled = locationManager?.isProviderEnabled(LocationManager.NETWORK_PROVIDER) ?: false
            Log.d(TAG, "getLocation: Status Network $isNetworkEnabled")

            //if (!isGPSEnabled && !isNetworkEnabled) {
            if (!isGPSEnabled && !isNetworkEnabled) {
                showSettingGps()
            } else {
                canGetLocation = true
                // get lat/lng by network
                if (isNetworkEnabled) {

                    try {
                        if (checkPermission(context)) {
                            locationManager?.requestLocationUpdates(
                                LocationManager.NETWORK_PROVIDER, MIN_TIME,
                                MIN_DISTANCE.toFloat(), this
                            )
                            Log.d("network", "network enabled")
                            if (locationManager != null) {
                                location = locationManager?.getLastKnownLocation(LocationManager.NETWORK_PROVIDER)
                                if (location != null) {
                                    latitude = location?.latitude ?: 0.0
                                    longitude = location?.longitude ?: 0.0
                                }
                            }
                        } else {
                            Log.d("network", "network disable ${checkPermission(context)}")
                        }


                    } catch (e: Exception){
                        Log.d(TAG, "getLocation: Network Provider : $e")
                    } catch (e: NullPointerException){
                        Log.d(TAG, "getLocation: $e")
                    }
                }

                try {
                    // get lat/lng by gps
                    if (isGPSEnabled) {
                        if (location == null) {
                            if (checkPermission(context)) {
                                locationManager?.requestLocationUpdates(
                                    LocationManager.GPS_PROVIDER, MIN_TIME,
                                    MIN_DISTANCE.toFloat(), this
                                )
                                Log.d("GPS", "GPS enabled")
                                if (locationManager != null) {
                                    location = locationManager?.getLastKnownLocation(LocationManager.GPS_PROVIDER)
                                    if (location != null) {
                                        latitude = location?.latitude ?: 0.0
                                        longitude = location?.longitude ?: 0.0
                                    }

                                }
                            }
                        }

                    }
                } catch (e: Exception){
                    Log.d(TAG, "getLocation: GPS Provider : $e")
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return location

    }

    fun getLatitude(): Double {
        if (location != null) {
            latitude = location?.latitude ?: 0.0
        }

        return latitude
    }

    fun getLongitude(): Double {
        if (location != null) {
            longitude = location?.longitude ?: 0.0
        }

        return longitude
    }

    /**
     * Function to check GPS/wifi enabled
     *
     * @return boolean
     */
    fun canGetLocation(): Boolean {
        return canGetLocation
    }

    /**
     * Function to show settings alert dialog On pressing Settings button will
     * lauch Settings Options
     */
    fun showSettingGps() {
        val alertBuilder = AlertDialog.Builder(context)

        alertBuilder.setTitle("GPS Setting")
        alertBuilder.setMessage("GPS is not enabled. Do you want to go to settings menu?")

        alertBuilder.setPositiveButton("Setting") { dialog, which ->
            val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            startActivity(intent)
        }
        alertBuilder.setNegativeButton("Cancel") { dialog, which -> dialog.cancel() }

        alertBuilder.show()
    }

    override fun onLocationChanged(location: Location?) {
        if (location != null) {
            if (this.location !== location) {
                this.location = location
            }
        }
    }

    override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) {
        TODO("Not yet implemented")
    }

    override fun onProviderEnabled(provider: String?) {
        TODO("Not yet implemented")
    }

    override fun onProviderDisabled(provider: String?) {
        TODO("Not yet implemented")
    }


    companion object {

        private val MIN_DISTANCE = 1.toLong() // 10 meter
        private val MIN_TIME = (1000 * 1 * 1).toLong() // 1minute

        fun checkPermission(context: Context?): Boolean {
            return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    ActivityCompat.checkSelfPermission(
                        context!!,
                        Manifest.permission.ACCESS_FINE_LOCATION
                    ) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                        context,
                        Manifest.permission.ACCESS_COARSE_LOCATION
                    ) == PackageManager.PERMISSION_GRANTED
            } else {
                true
            }
        }
    }

    override fun onBind(intent: Intent?): IBinder? {
        TODO("Not yet implemented")
    }


}
