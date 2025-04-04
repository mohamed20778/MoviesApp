package com.example.movies_app 

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "app.channel/deeplink"
    private var initialLink: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent?) {
        if (intent?.action == Intent.ACTION_VIEW) {
            initialLink = intent.data?.toString()
            // Send to Flutter immediately if app is running
            flutterEngine?.let { engine ->
                MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
                    .invokeMethod("onNewLink", initialLink)
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getInitialLink" -> {
                    result.success(initialLink)
                    initialLink = null
                }
                else -> result.notImplemented()
            }
        }
    }
}
