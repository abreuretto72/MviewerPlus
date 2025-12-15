package com.multiversodigital.mviewerplus

import android.content.Context
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.multiversodigital.mviewerplus/security"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkRootJailbreak" -> {
                    result.success(isDeviceRooted())
                }
                "checkDebugger" -> {
                    result.success(isDebuggerAttached())
                }
                "checkHooking" -> {
                    result.success(isHookingDetected())
                }
                "checkEmulator" -> {
                    result.success(isEmulator())
                }
                "checkAppIntegrity" -> {
                    result.success(checkAppIntegrity())
                }
                "checkOSVersion" -> {
                    result.success(isOSUpdated())
                }
                "checkScreenLock" -> {
                    result.success(hasScreenLock())
                }
                "checkUnknownSources" -> {
                    result.success(isUnknownSourcesEnabled())
                }
                "checkAlwaysLocationApps" -> {
                    result.success(countAlwaysLocationApps())
                }
                "checkLockScreenNotifications" -> {
                    result.success(showsSensitiveNotificationsOnLockScreen())
                }
                "checkSecurityPatchAge" -> {
                    result.success(isSecurityPatchOld())
                }
                "checkUSBDebugging" -> {
                    result.success(isUSBDebuggingEnabled())
                }
                "checkProxy" -> {
                    result.success(isProxyConfigured())
                }
                "checkWifiSecurity" -> {
                    result.success(checkWifiSecurity())
                }
                "checkSideloadedApps" -> {
                    result.success(checkSideloadedApps())
                }
                "checkThirdPartyKeyboards" -> {
                    result.success(checkThirdPartyKeyboards())
                }
                "checkAccessibilityAbuse" -> {
                    result.success(checkAccessibilityAbuse())
                }
                "checkAppSignature" -> {
                    val packageName = call.argument<String>("packageName")
                    val expectedHash = call.argument<String>("expectedHash")
                    if (packageName != null && expectedHash != null) {
                        result.success(checkAppSignature(packageName, expectedHash))
                    } else {
                        result.error("INVALID_ARGS", "Missing packageName or expectedHash", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    /**
     * Detecta se o dispositivo está com Root
     * Verifica múltiplos indicadores de root
     */
    private fun isDeviceRooted(): Boolean {
        // Verificar binários de root comuns
        val rootBinaries = arrayOf(
            "/system/app/Superuser.apk",
            "/sbin/su",
            "/system/bin/su",
            "/system/xbin/su",
            "/data/local/xbin/su",
            "/data/local/bin/su",
            "/system/sd/xbin/su",
            "/system/bin/failsafe/su",
            "/data/local/su",
            "/su/bin/su"
        )

        for (path in rootBinaries) {
            if (File(path).exists()) {
                return true
            }
        }

        // Verificar tags de build suspeitas
        val buildTags = Build.TAGS
        if (buildTags != null && buildTags.contains("test-keys")) {
            return true
        }

        // Verificar apps de root comuns
        val rootApps = arrayOf(
            "com.noshufou.android.su",
            "com.noshufou.android.su.elite",
            "eu.chainfire.supersu",
            "com.koushikdutta.superuser",
            "com.thirdparty.superuser",
            "com.yellowes.su",
            "com.topjohnwu.magisk"
        )

        for (packageName in rootApps) {
            try {
                context.packageManager.getPackageInfo(packageName, 0)
                return true
            } catch (e: Exception) {
                // App não instalado
            }
        }

        return false
    }

    /**
     * Detecta se um debugger está anexado
     */
    private fun isDebuggerAttached(): Boolean {
        return android.os.Debug.isDebuggerConnected() || 
               android.os.Debug.waitingForDebugger()
    }

    /**
     * Detecta frameworks de hooking (Frida, Xposed, etc.)
     */
    private fun isHookingDetected(): Boolean {
        // Verificar Frida
        val fridaPaths = arrayOf(
            "/data/local/tmp/frida-server",
            "/data/local/tmp/re.frida.server"
        )

        for (path in fridaPaths) {
            if (File(path).exists()) {
                return true
            }
        }

        // Verificar Xposed
        try {
            throw Exception("Xposed check")
        } catch (e: Exception) {
            for (stackTraceElement in e.stackTrace) {
                if (stackTraceElement.className.contains("de.robv.android.xposed")) {
                    return true
                }
            }
        }

        // Verificar portas Frida
        try {
            val process = Runtime.getRuntime().exec("netstat")
            val reader = process.inputStream.bufferedReader()
            var line: String?
            while (reader.readLine().also { line = it } != null) {
                if (line!!.contains("27042") || line!!.contains("27043")) {
                    return true // Portas padrão do Frida
                }
            }
        } catch (e: Exception) {
            // Ignore
        }

        return false
    }

    /**
     * Detecta se está rodando em emulador
     */
    private fun isEmulator(): Boolean {
        return (Build.FINGERPRINT.startsWith("generic") ||
                Build.FINGERPRINT.startsWith("unknown") ||
                Build.MODEL.contains("google_sdk") ||
                Build.MODEL.contains("Emulator") ||
                Build.MODEL.contains("Android SDK built for x86") ||
                Build.MANUFACTURER.contains("Genymotion") ||
                Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic") ||
                "google_sdk" == Build.PRODUCT ||
                Build.HARDWARE.contains("goldfish") ||
                Build.HARDWARE.contains("ranchu"))
    }

    /**
     * Verifica a integridade do APK (assinatura)
     */
    private fun checkAppIntegrity(): Boolean {
        try {
            val packageInfo = context.packageManager.getPackageInfo(
                context.packageName,
                android.content.pm.PackageManager.GET_SIGNATURES
            )
            
            // Aqui você deve comparar com a assinatura esperada
            // Por enquanto, apenas verifica se existe assinatura
            return packageInfo.signatures != null && packageInfo.signatures.isNotEmpty()
        } catch (e: Exception) {
            return false
        }
    }

    /**
     * Verifica se o sistema operacional está atualizado
     * Considera desatualizado se Android < 10 (API 29)
     */
    private fun isOSUpdated(): Boolean {
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q // Android 10+
    }

    /**
     * Verifica se o bloqueio de tela está configurado
     */
    private fun hasScreenLock(): Boolean {
        val keyguardManager = context.getSystemService(Context.KEYGUARD_SERVICE) as android.app.KeyguardManager
        return keyguardManager.isDeviceSecure
    }

    /**
     * P-3: Verifica se "Fontes Desconhecidas" está habilitada
     * Android 8.0+ verifica por app, versões anteriores verificam configuração global
     */
    private fun isUnknownSourcesEnabled(): Boolean {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                // Android 8.0+: Verificar se o app pode instalar pacotes
                context.packageManager.canRequestPackageInstalls()
            } else {
                // Android < 8.0: Verificar configuração global
                @Suppress("DEPRECATION")
                Settings.Secure.getInt(
                    context.contentResolver,
                    Settings.Secure.INSTALL_NON_MARKET_APPS,
                    0
                ) == 1
            }
        } catch (e: Exception) {
            false
        }
    }

    /**
     * P-4: Conta quantos apps têm permissão de localização "Sempre"
     */
    private fun countAlwaysLocationApps(): Int {
        return try {
            val pm = context.packageManager
            val packages = pm.getInstalledPackages(android.content.pm.PackageManager.GET_PERMISSIONS)
            var count = 0

            for (packageInfo in packages) {
                val permissions = packageInfo.requestedPermissions ?: continue
                
                // Verificar se tem permissão de localização em segundo plano
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    if (permissions.contains(android.Manifest.permission.ACCESS_BACKGROUND_LOCATION)) {
                        // Verificar se a permissão foi concedida
                        if (context.checkPermission(
                                android.Manifest.permission.ACCESS_BACKGROUND_LOCATION,
                                android.os.Process.myPid(),
                                packageInfo.applicationInfo.uid
                            ) == android.content.pm.PackageManager.PERMISSION_GRANTED
                        ) {
                            count++
                        }
                    }
                }
            }

            count
        } catch (e: Exception) {
            0
        }
    }

    /**
     * P-5: Verifica se notificações sensíveis aparecem na tela de bloqueio
     */
    private fun showsSensitiveNotificationsOnLockScreen(): Boolean {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                val lockscreenVisibility = Settings.Secure.getInt(
                    context.contentResolver,
                    "lock_screen_show_notifications",
                    1
                )
                
                // Se mostra notificações (1) e não oculta conteúdo sensível
                lockscreenVisibility == 1
            } else {
                false
            }
        } catch (e: Exception) {
            false
        }
    }

    /**
     * P-2 (complemento): Verifica se o patch de segurança tem mais de 60 dias
     */
    private fun isSecurityPatchOld(): Boolean {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val securityPatch = Build.VERSION.SECURITY_PATCH
                
                // Formato: YYYY-MM-DD
                val parts = securityPatch.split("-")
                if (parts.size == 3) {
                    val year = parts[0].toInt()
                    val month = parts[1].toInt()
                    val day = parts[2].toInt()
                    
                    val patchDate = java.util.Calendar.getInstance().apply {
                        set(year, month - 1, day)
                    }
                    
                    val now = java.util.Calendar.getInstance()
                    val diffInMillis = now.timeInMillis - patchDate.timeInMillis
                    val diffInDays = diffInMillis / (1000 * 60 * 60 * 24)
                    
                    // Mais de 60 dias
                    diffInDays > 60
                } else {
                    false
                }
            } else {
                // Versões antigas não têm patch de segurança
                true
            }
        } catch (e: Exception) {
            false
        }
    }

    /**
     * Verifica se USB Debugging está ativo
     */
    private fun isUSBDebuggingEnabled(): Boolean {
        return try {
            Settings.Global.getInt(
                context.contentResolver,
                Settings.Global.ADB_ENABLED, 0
            ) == 1
        } catch (e: Exception) {
            false
        }
    }

    /**
     * Verifica se há proxy configurado
     */
    private fun isProxyConfigured(): Boolean {
        return try {
            // Verificar proxy do sistema
            val proxyHost = System.getProperty("http.proxyHost")
            if (proxyHost != null && proxyHost.isNotEmpty()) return true
            
            // Verificar proxy Wi-Fi (Android 5.0+)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as android.net.ConnectivityManager
                val network = connectivityManager.activeNetwork
                val linkProperties = connectivityManager.getLinkProperties(network)
                
                if (linkProperties != null && linkProperties.httpProxy != null) {
                    return true
                }
            }
            
            false
        } catch (e: Exception) {
            false
        }
    }

    /**
     * Verifica segurança do Wi-Fi
     */
    private fun checkWifiSecurity(): Map<String, Any> {
        return try {
            val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as android.net.wifi.WifiManager
            val wifiInfo = wifiManager.connectionInfo
            
            if (wifiInfo == null || wifiInfo.networkId == -1) {
                return mapOf(
                    "isSecure" to true,
                    "securityType" to "not_connected"
                )
            }
            
            // Obter configuração da rede
            val configurations = wifiManager.configuredNetworks
            val currentConfig = configurations?.find { it.networkId == wifiInfo.networkId }
            
            if (currentConfig != null) {
                val capabilities = currentConfig.allowedKeyManagement.toString()
                
                val securityType = when {
                    capabilities.contains("WPA3") -> "WPA3"
                    capabilities.contains("WPA2") -> "WPA2"
                    capabilities.contains("WPA") -> "WPA"
                    capabilities.contains("WEP") -> "WEP"
                    else -> "OPEN"
                }
                
                val isSecure = securityType in listOf("WPA2", "WPA3")
                
                mapOf(
                    "isSecure" to isSecure,
                    "securityType" to securityType
                )
            } else {
                mapOf(
                    "isSecure" to true,
                    "securityType" to "unknown"
                )
            }
        } catch (e: Exception) {
            mapOf(
                "isSecure" to true,
                "securityType" to "error"
            )
        }
    }

    /**
     * Verifica apps instalados de fontes desconhecidas (sideloading)
     */
    private fun checkSideloadedApps(): List<Map<String, String>> {
        return try {
            val sensitivePackages = listOf(
                "com.whatsapp",
                "com.instagram.android",
                "com.facebook.katana",
                "com.nubank",
                "com.bradesco",
                "com.itau",
                "com.santander.app",
                "com.bb.android"
            )
            
            val sideloaded = mutableListOf<Map<String, String>>()
            val pm = context.packageManager
            
            for (pkg in sensitivePackages) {
                try {
                    pm.getPackageInfo(pkg, 0)
                    val installer = pm.getInstallerPackageName(pkg)
                    
                    if (installer != "com.android.vending") {
                        sideloaded.add(mapOf(
                            "package" to pkg,
                            "installer" to (installer ?: "unknown")
                        ))
                    }
                } catch (e: Exception) {
                    // App não instalado
                }
            }
            
            sideloaded
        } catch (e: Exception) {
            emptyList()
        }
    }

    /**
     * Verifica teclados de terceiros
     */
    private fun checkThirdPartyKeyboards(): List<String> {
        return try {
            val imm = context.getSystemService(Context.INPUT_METHOD_SERVICE) as android.view.inputmethod.InputMethodManager
            val enabledKeyboards = imm.enabledInputMethodList
            
            val trustedKeyboards = listOf(
                "com.google.android.inputmethod.latin",  // Gboard
                "com.samsung.android.honeyboard",        // Samsung
                "com.sec.android.inputmethod",           // Samsung
                "com.touchtype.swiftkey",                // SwiftKey
                "com.android.inputmethod.latin"          // AOSP
            )
            
            enabledKeyboards
                .map { it.packageName }
                .filter { !trustedKeyboards.contains(it) }
        } catch (e: Exception) {
            emptyList()
        }
    }

    /**
     * Verifica apps com permissões de acessibilidade suspeitas
     */
    private fun checkAccessibilityAbuse(): List<Map<String, String>> {
        return try {
            val am = context.getSystemService(Context.ACCESSIBILITY_SERVICE) as android.view.accessibility.AccessibilityManager
            val enabledServices = am.getEnabledAccessibilityServiceList(
                android.accessibilityservice.AccessibilityServiceInfo.FEEDBACK_ALL_MASK
            )
            
            val systemPackages = listOf(
                "com.google.android",
                "com.samsung.android",
                "com.android",
                "com.sec.android"
            )
            
            enabledServices
                .filter { service ->
                    val pkg = service.resolveInfo.serviceInfo.packageName
                    !systemPackages.any { pkg.startsWith(it) }
                }
                .map { service ->
                    mapOf(
                        "package" to service.resolveInfo.serviceInfo.packageName,
                        "name" to service.resolveInfo.loadLabel(context.packageManager).toString()
                    )
                }
        } catch (e: Exception) {
            emptyList()
        }
    }

    /**
     * Verifica assinatura SHA-256 de um app
     */
    private fun checkAppSignature(packageName: String, expectedHash: String): Map<String, Any> {
        return try {
            val pm = context.packageManager
            
            // Verificar se o app está instalado
            val packageInfo = try {
                pm.getPackageInfo(packageName, android.content.pm.PackageManager.GET_SIGNATURES)
            } catch (e: Exception) {
                return mapOf(
                    "isInstalled" to false,
                    "isValid" to null,
                    "actualHash" to null
                )
            }
            
            // Calcular hash SHA-256 da assinatura
            val signatures = packageInfo.signatures
            if (signatures == null || signatures.isEmpty()) {
                return mapOf(
                    "isInstalled" to true,
                    "isValid" to false,
                    "actualHash" to null,
                    "error" to "no_signature"
                )
            }
            
            // Pegar primeira assinatura e calcular hash
            val signature = signatures[0]
            val md = java.security.MessageDigest.getInstance("SHA-256")
            md.update(signature.toByteArray())
            val digest = md.digest()
            
            // Converter para Base64
            val actualHash = android.util.Base64.encodeToString(digest, android.util.Base64.NO_WRAP)
            
            // Comparar com hash esperado
            val isValid = actualHash == expectedHash
            
            mapOf(
                "isInstalled" to true,
                "isValid" to isValid,
                "actualHash" to actualHash,
                "expectedHash" to expectedHash
            )
        } catch (e: Exception) {
            mapOf(
                "isInstalled" to false,
                "isValid" to null,
                "actualHash" to null,
                "error" to e.message
            )
        }
    }
}
