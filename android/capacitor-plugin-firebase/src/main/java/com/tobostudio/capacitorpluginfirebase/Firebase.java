package com.tobostudio.capacitorpluginfirebase;

import android.content.Context;
import android.os.Bundle;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

import com.google.firebase.FirebaseApp;
import com.google.firebase.analytics.FirebaseAnalytics;

import org.json.JSONException;

import java.util.Iterator;

@NativePlugin()
public class Firebase extends Plugin {

    private FirebaseAnalytics mFirebaseAnalytics;

    public void load() {
        Context context = getContext();
        FirebaseApp.initializeApp(context);
        mFirebaseAnalytics = FirebaseAnalytics.getInstance(context);
        mFirebaseAnalytics.setAnalyticsCollectionEnabled(true);
    }

    @PluginMethod()
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", value);
        call.success(ret);
    }

    @PluginMethod()
    public void logEvent(PluginCall call) {
        String name = call.getString("name");
        JSObject params = call.getObject("parameters");

        final Bundle bundle = new Bundle();
        Iterator iter = params.keys();
        while (iter.hasNext()) {
            String key = (String) iter.next();
            double doubleValue = params.optDouble(key);
            if (doubleValue != Double.NaN) {
                bundle.putDouble(key, doubleValue);
            }
            else {
                String stringValue = params.optString(key);
                if (stringValue != null) {
                    bundle.putString(key, stringValue);
                }
            }
        }

        mFirebaseAnalytics.logEvent(name, bundle);
    }

}
