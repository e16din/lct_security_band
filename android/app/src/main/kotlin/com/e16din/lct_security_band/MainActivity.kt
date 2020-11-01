package com.e16din.lct_security_band

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {

//  val TAG = "Main Activity....."
//  val CHANNEL = "com.example.services_demo/service"
//  var myReceiver: MyReceiver? = null
//  var keepResult: MethodChannel.Result? = null
//
//  var serviceConnected = false
//
//  protected fun onCreate(savedInstanceState: Bundle?) {
//    super.onCreate(savedInstanceState)
//    AlarmService.setPluginRegistrant(this)
//    GeneratedPluginRegistrant.registerWith(this)
//    MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result -> onMethodCall(call, result) }
//  }
//
//  protected fun onStart() {
//    myReceiver = MyReceiver()
//    val intentFilter = IntentFilter()
//    intentFilter.addAction(SimpleService.MY_ACTION)
//    registerReceiver(myReceiver, intentFilter)
//    super.onStart()
//  }
//
//  protected fun onStop() {
//    // TODO Auto-generated method stub
//    if (myReceiver != null) {
//      unregisterReceiver(myReceiver)
//    }
//    serviceConnected = false
//    super.onStop()
//  }
//
//  fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//    try {
//      if (call.method.equals("connect")) {
//        connectToService()
//        keepResult = result
//      } else if (serviceConnected) {
//
//        //
//        if (call.method.equals("start")) {
//          val _data: String = SimpleService.helloFromService()
//          result.success(_data)
//        } else if (call.method.equals("latestValue")) {
//          val _data: Int = SimpleService().getValue()
//          result.success(_data)
//
////                    Log.i(TAG, "Value received : "+String.valueOf(_data));
//        }
//      } else {
//        result.error(null, "App not connected to service", null)
//      }
//    } catch (e: Exception) {
//      result.error(null, e.message, null)
//    }
//  }
//
//  private fun connectToService() {
//    //
//    if (!serviceConnected) {
//      val service = Intent(this, SimpleService::class.java)
//      startService(service)
//      Log.i(TAG, "Service connected")
//      serviceConnected = true
//    } else {
//      Log.i(TAG, "Service already connected")
//      if (keepResult != null) {
//        keepResult.success(null)
//        keepResult = null
//      }
//    }
//
//    //
//  }
//
//  fun registerWith(registry: PluginRegistry?) {
//    GeneratedPluginRegistrant.registerWith(registry)
//  }
//
//  class MyReceiver() : BroadcastReceiver() {
//    override fun onReceive(arg0: Context, arg1: Intent) {
//      // TODO Auto-generated method stub
//      val datapassed = arg1.getIntExtra("DATAPASSED", 0)
//      Toast.makeText(this@MainActivity,
//          "Value from service !!\n"
//              + "Data passed: " + datapassed.toString(),
//          Toast.LENGTH_LONG).show()
//    }
//  }
}
