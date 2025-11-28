plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")

    // 🔥 Plugin necesario para Firebase
    id("com.google.gms.google-services")

    // Flutter plugin (debe ir al final siempre)
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tech_inventory"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.tech_inventory"
        minSdk = flutter.minSdkVersion    // 🔥⚠ IMPORTANTE: Firebase requiere minSdk 21 o superior
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.1.2"))
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-analytics")
}

