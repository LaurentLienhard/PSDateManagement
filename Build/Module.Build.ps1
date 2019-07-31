properties {
    $DeployType
    . ..\Build.Settings.ps1
}

Task default -description "Task default do nothing"

Task Init {
    ./BuildFiles/Init.ps1
} -description "Initialize the runtime environment"

Task Clean -depends Init {
    ./BuildFiles/Clean.ps1
} -description "Prepare OutputFolder by cleaning it"

Task BuildModule -depends Clean {
    ./BuildFiles/BuildModule.ps1
} -description "Compile all ps1 files in one psm1 file"

Task BuildManifest -depends BuildModule {
    ./BuildFiles/BuildManifest.ps1
} -description "Update psd1 file"

task ImportModule -depends BuildManifest {
    ./BuildFiles/ImportModule.ps1
} -description "Import compiled module for test"

task Testing -depends ImportModule {
    ./BuildFiles/Testing.ps1
} -description "Run all test on imported module"

task deploy -depends Testing {
    ./BuildFiles/deploy.ps1 -DeployType $DeployType
} -description "Deploy tested module : PSGAllery or local"