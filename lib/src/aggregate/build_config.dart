class BuildConfig {
  final String specialSyntheticAssets;

   const BuildConfig(
    this.specialSyntheticAssets,
);

  // build BuildConfig from build.yaml
  factory BuildConfig.fromJson(Map<String, dynamic> config){
    return BuildConfig(config['special_synthetic_assets']??"lib");
  }

}
