# TODO: Update mAlpha Below:
MALPHA="mXXXXXX"
#
# Script Globals/Software Versions (students should NOT update):
MYSQL_VERSION=5.7
PHP_VERSION=7.2
#
# NOTE: This script is taken from Jeff Kenney's installation instructions on http://apt.cs.usna.edu/notes for Ubuntu - Apache and MySQL Installation Guide.  When on the yard you can check that page for updates if something breaks with the script in the future!
#
# Install Required Ubuntu Packages for Apache - Mirroring CS Dept Configuration
sudo apt-get install -y php$PHP_VERSION apache2 php libapache2-mod-php$PHP_VERSION php$PHP_VERSION-mysql php$PHP_VERSION-curl php$PHP_VERSION-json php$PHP_VERSION-mysqlnd php$PHP_VERSION-gd libapache2-mod-perl2 php$PHP_VERSION-mbstring php$PHP_VERSION-xml libapache2-mod-php$PHP_VERSION php$PHP_VERSION-mysql php$PHP_VERSION-curl php$PHP_VERSION-json php$PHP_VERSION-mysqlnd php$PHP_VERSION-gd php$PHP_VERSION-xml libmysql-java graphviz libgraphviz-dev libmysql-java libapache-dbi-perl libmysql-java libapache2-mod-php$PHP_VERSION php$PHP_VERSION-mysql php$PHP_VERSION-curl php$PHP_VERSION-json php$PHP_VERSION-mysqlnd php$PHP_VERSION-gd libapache2-mod-perl2 php$PHP_VERSION-mbstring php$PHP_VERSION-xml php$PHP_VERSION-zip php$PHP_VERSION-json php$PHP_VERSION-sqlite3 libcgi-session-perl php-gd php-ssh2 php-xml
# NOTE: If/When prompted enter the machine sudo password
#
#
# Enable important Apache Modules
sudo a2enmod userdir
sudo a2enmod rewrite
sudo a2enmod cgi
sudo a2enmod ssl
sudo a2enmod perl
sudo a2enmod expires
sudo a2enmod headers
sudo a2enmod include
# NOTE: If/When prompted enter the machine sudo password
#
#
# Edit configuration to allow running PHP and CGI Scripts
sudo sed -i 's_FileInfo AuthConfig Limit Indexes_All_g' /etc/apache2/mods-enabled/userdir.conf
sudo sed -i 's_IncludesNoExec_ExecCGI\n\t\tAddhandler cgi-script .py .cgi_g' /etc/apache2/mods-enabled/userdir.conf
sudo sed -i 's=php_admin_flag engine Off=#php_admin_flag engine Off=g' /etc/apache2/mods-enabled/php$PHP_VERSION.conf
sudo sed -i 's|post_max_size = 8M|post_max_size = 24M|g' /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i 's|upload_max_filesize = 2M|upload_max_filesize = 24M|g' /etc/php/$PHP_VERSION/apache2/php.ini
#
#NOTE: for compatability with non-GNU version of sed, save output to a tmp file and then mv to original file
sudo sed -e '/Options Indexes FollowSymLinks/{s//Options Indexes FollowSymLinks ExecCGI\n\tAddhandler cgi-script .py .cgi/;:a' -e '$!N;$!ba' -e '}' /etc/apache2/apache2.conf > apache2.conf.tmp
sudo mv apache2.conf.tmp /etc/apache2/apache2.conf
# If/When prompted enter the machine sudo password

# # TODO: Stopped HERE!!!
