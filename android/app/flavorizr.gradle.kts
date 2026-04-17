import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "store.inoteapp.inoteapp.dev"
            resValue(type = "string", name = "app_name", value = "iNote DEV")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "store.inoteapp.inoteapp"
            resValue(type = "string", name = "app_name", value = "iNote App")
        }
    }
}