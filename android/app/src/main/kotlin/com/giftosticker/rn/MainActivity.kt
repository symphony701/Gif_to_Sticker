package com.giftosticker.rn

import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.arthenica.mobileffmpeg.Config.RETURN_CODE_CANCEL
import com.arthenica.mobileffmpeg.Config.RETURN_CODE_SUCCESS
import com.arthenica.mobileffmpeg.FFmpeg
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDateTime

class MainActivity: FlutterActivity() {
    private val CONVERTER_CHANNEL = "com.giftosticker.rn/converter";
    private lateinit var channel : MethodChannel
    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CONVERTER_CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "gifConverter") {
                val arguments = call.arguments as Map<String, String>
                val internetPath = arguments["urlGif"].toString();
                val localPath = arguments["pathDownload"].toString();
                val nameFile = arguments["nameFile"].toString();
                val finalPath = converterEngine(internetPath, localPath, nameFile);
                result.success(finalPath);
            } else {
                result.notImplemented()
            }
        }
    }
    @RequiresApi(Build.VERSION_CODES.O)
    fun converterEngine(internetPath : String, localPath: String, nameFile: String): String {
        val c = arrayOf(
            "-i",
            internetPath,
            "-vcodec",
            "webp",
            "-loop",
            "0",
            "-pix_fmt",
            "yuv420p",
            "-vf",
            "scale=520:520,crop=512:512",
            "-vsync",
            "vfr",
            "-quality",
            "10",
            (
                    localPath
                            +"/"+nameFile)
        );
        var endPath :String ;
        val session = FFmpeg.execute(c);
        endPath = if (session == RETURN_CODE_SUCCESS) {
            println("Command execution completed successfully.")
            val timenow :String  = LocalDateTime.now().toString();
            val pathReturnet : String = "$localPath/$nameFile";
            pathReturnet;
        } else if (session == RETURN_CODE_CANCEL) {
            "canceled";
        } else {
            "failed";
        }
        return endPath;
    }
}
