## init.pp for java + tomcat

class { 'java': }

tomcat::install { '/opt/tomcat':
  source_url => 'https://www.apache.org/dist/tomcat/tomcat-8/v8.0.41/bin/apache-tomcat-8.0.41.tar.gz'
}

tomcat::instance { 'default':
  catalina_home => '/opt/tomcat',
}

# Nexus configuration
class {'nexus':
    url      => "$repo_site",
    username => "$repo_user",
    password => "$repo_password"
}

case $app_version {
  /-SNAPSHOT$/: { $app_repository = "snapshots" }
  default: { $app_repository = "releases" }
}

# Checks that the file is present, downloads it if needed
nexus::artifact {'MyApp':
    gav        => "$app_group_id:$app_artifact_id:$app_version",
    repository => "$app_repository",
    packaging  => "war",
    output     => "/opt/tomcat/webapps/MyApp.war",
    ensure     => present
}

