## init.pp for java + tomcat

class { 'java': }

tomcat::install { '/opt/tomcat':
  source_url => 'https://www.apache.org/dist/tomcat/tomcat-8/v8.0.39/bin/apache-tomcat-8.0.39.tar.gz'
}

tomcat::instance { 'default':
  catalina_home => '/opt/tomcat',
}

# Nexus configuration
class {'nexus':
    url      => "$repo_url",
    username => "$repo_user",
    password => "$repo_password"
}


# Checks that the file is present, downloads it if needed
nexus::artifact {'MyApp':
    gav        => "$app_group_id:$app_artifact_id:$app_version",
    repository => "$app_repository",
    packaging  => "war",
    output     => "/opt/tomcat/webapps/MyApp.war",
    ensure     => present
}

