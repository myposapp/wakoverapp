allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// gradle.properties sets android.builtInKotlin=false (Flutter template), so AGP
// 9 won't compile Kotlin by itself. These plugins only apply the Kotlin plugin
// below AGP 9, which leaves their Kotlin sources uncompiled and breaks
// GeneratedPluginRegistrant ("cannot find symbol ...Plugin"). Apply it for
// them. Keep this to plugins that need it: forcing it on a plugin that applies
// Kotlin itself clashes with that plugin's own Kotlin version.
val pluginsMissingKotlinOnAgp9 = setOf("file_picker")
val builtInKotlin =
    (findProperty("android.builtInKotlin")?.toString() ?: "true").toBoolean()
if (!builtInKotlin) {
    subprojects {
        if (name !in pluginsMissingKotlinOnAgp9) return@subprojects
        pluginManager.withPlugin("com.android.library") {
            pluginManager.apply("org.jetbrains.kotlin.android")
            // Match the plugin's Java target, or Kotlin's JVM target check fails.
            afterEvaluate {
                val javaTarget =
                    extensions
                        .getByType<com.android.build.api.dsl.LibraryExtension>()
                        .compileOptions
                        .targetCompatibility
                tasks
                    .withType<org.jetbrains.kotlin.gradle.tasks.KotlinJvmCompile>()
                    .configureEach {
                        compilerOptions.jvmTarget.set(
                            org.jetbrains.kotlin.gradle.dsl.JvmTarget.fromTarget(
                                javaTarget.toString(),
                            ),
                        )
                    }
            }
        }
    }
}
