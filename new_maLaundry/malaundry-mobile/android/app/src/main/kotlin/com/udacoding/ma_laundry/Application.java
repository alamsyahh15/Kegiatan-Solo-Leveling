
package com.udacoding.ma_laundry;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin;
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;

public class Application extends FlutterApplication implements PluginRegistrantCallback {

    @Override
    public void onCreate() {
        super.onCreate();
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    @Override
    public void registerWith(PluginRegistry pluginRegistry) {
        FirebaseMessagingPlugin.registerWith(pluginRegistry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
        FlutterLocalNotificationsPlugin.registerWith(pluginRegistry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
    }
}

// import io.flutter.app.FlutterApplication
// import io.flutter.plugin.common.PluginRegistry
// import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
// import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
// import io.flutter.view.FlutterMain
// import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
// import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin
// import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;
// import android.os.Build
// import android.app.NotificationManager
// import android.app.NotificationChannel

// public class Application: FlutterApplication(), PluginRegistrantCallback {

//     override fun onCreate() {
//         super.onCreate();
//         FlutterFirebaseMessagingService.setPluginRegistrant(this);
//         FlutterMain.startInitialization(this);
//     }

//     override fun registerWith(registry: PluginRegistry?) {
//         FirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin")!!);
//         FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
//         //SharedPreferencesPlugin.registerWith(registry.registrarFor("plugins.flutter.io.shared_preferences"));
//     }


   
// }
