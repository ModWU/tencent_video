package com.example.tencent_video

import io.flutter.embedding.android.FlutterActivity
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import com.foroo.utils.SimpleUtils

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SimpleUtils.setSteepStatusBar(this)
    }
}
