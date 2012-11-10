#! /bin/bash
# serverBuildScript.sh
# Ryan Dempsey 121024
# This script stops services, moves the latest repository files into the correct locations, and starts the services again. It is the 2nd script in a 2 script process.
# ATTENTION: This script is not for use on student LAMP stacks...

# DO NOT EDIT THIS FILE - If you need changes made, please contact either Ryan, Jeremy, or Nordquist.

# Delete the backup repository
rm -rf /var/git/sousms-backup

# Generate new repository version file
# TODO format the output
cd /var/git/sousms
git log -1 >  /var/git/sousms-new/src/web/version.xml

# TODO Run smoke tests, log results, and exit if smoke tests failed here

# Stop running services
service httpd stop
service mysqld stop

# TODO Backup MySQL database -- copy database, and run sql data preservation scripts

# Move outdated repository to backup directory
mv /var/git/sousms /var/git/sousms-backup

# Delete outdated web files from the server
rm /var/www/html/* -r

# Move previously downloaded repository to official location
mv /var/git/sousms-new /var/git/sousms

# Copy web files to root apache folder
cp -R /var/git/sousms/src/web/* /var/www/html/
# Copy team src directories to the web folder
cp -R /var/git/sousms/src/build /var/www/html/mobile/html/
cp -R /var/git/sousms/src/database /var/www/html/mobile/html/
cp -R /var/git/sousms/src/DataFeed /var/www/html/mobile/html/
cp -R /var/git/sousms/src/mobile /var/www/html/mobile/html/
cp -R /var/git/sousms/src/shared /var/www/html/mobile/html/
cp -R /var/git/sousms/src/te /var/www/html/mobile/html/
cp -R /var/git/sousms/src/teTest /var/www/html/mobile/html/

# TODO Run build/SQL scripts here, if we run any.

# Restart services
service httpd start
service mysqld start