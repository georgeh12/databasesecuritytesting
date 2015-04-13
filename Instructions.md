# Introduction #

It was a real pain trying to install all the plug-ins for Eclipse, so this should simplify the process. Please add to this page if you install other plug-ins for your code.

All of the text that appears in _italics_ indicates that it is exactly how the interface describes a button, link, etc.


# Instructions #

  1. Download and install [Eclipse PHP](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/galileo/SR1/eclipse-php-galileo-SR1-win32.zip)
    * I recommend downloading using [BitTorrent](http://www.utorrent.com/). After downloading, unzip and place the eclipse folder wherever you choose.
  1. Install the javaw path.
    * Find the eclipse.ini, and append the following string to the first line of the file (there must be a line break after _-vm_):
> > > -vm
> > > > %javapath%\javaw.exe
    * _%javapath%_ could be something like _C:\jdk1.4.2\jre\bin_. I am running Windows Vista and it was installed to _C:\Windows\System32_. Just do a search if you can't find it.
    * Now Eclipse should open. Set up your workspace directory.
  1. Download and install the [ActivePerl](http://downloads.activestate.com/ActivePerl/) for your OS (be sure to download v5.8.x, because it has a working PPM):
    * It does not matter where you install to, but you need the location of the executable later.
    * Using a terminal (cmd), open the installation folder and go into the bin folder.
    * Enter the following commands:
      * ppm install DBI
      * ppm install http://theoryx5.uwinnipeg.ca/ppms/DBD-mysql.ppd
  1. Download and install [MySQL Community Server](http://dev.mysql.com/downloads/mysql/5.1.html#downloads) for your OS.
    * Remember the password you use for root access, you will need it to access the database.
    * Run the MySQL command line client.
    * Open a new database using the command _\u %databaseName%_
  1. Install the EPIC plug-in for Eclipse.
    * In Eclipse, open the _Help_ menu and click _Install New Software..._.
    * Click _Add_ at the top right of the window.
    * Give the plug-in a name and enter _http://e-p-i-c.sf.net/updates/testing_as the location.
    * Select the check box next to _EPIC Main Components_.
    * Install the plug-in. Restart Eclipse when you are prompted to do so.
  1. Install Perl into EPIC.
    * In Eclipse, open the _Window_ menu and click _Preferences_.
    * From the left menu, select _Perl EPIC_.
    * In the box labeled _Perl executable:_ enter the location of the Perl executable from Step 3.
    * For my installation it was _C:\Perl64\bin\perl.exe_.
    * Click OK to save these settings.
  1. Install the Subclipse plug-in for Eclipse.
    * Follow the same instructions in from Step 4, but use _http://subclipse.tigris.org/update\_1.6.x_as the _Location_
    * Select the check box next to _Subclipse_.
    * Install the plug-in. Restart Eclipse when you are prompted to do so.
  1. Checkout from the repository.
    * In Eclipse, click _File_ and select _Import_.
    * Click _SVN_ and select _Checkout Projects from SVN_, and click _Next_.
    * Select _Create a new repository location_ and click _Next_.
    * Enter _https://databasesecuritytesting.googlecode.com/svn/trunk/_and click _Next_.
    * Select the project you want to open and click _Finish_.
    * When you are prompted for your username and password, enter your gmail username and the _googlecode_ password. This can be found by clicking _Source_ on this page, then clicking _googlecode.com password_ on that page.
  1. Synchronize with repository.
    * Right-click your updated project.
    * Click _Team_ and select _Synchronize with Repository_.
  1. Revert changes back to the repository version.
    * Right-click your updated project/file.
    * Click _Team_ and select _Revert..._.
    * Select the files you wish to revert to saved.
    * Click _OK_ to revert changes.
  1. Commit a new project to the repository.
    * Right-click your new project
    * Click _Team_ and select _Share Project..._.
    * Select _SVN_ and click _Next_.
    * Select _Use existing repository location:_ and click _Next_.
    * Click _Finish_ to upload your new project.
  1. Commit an updated project/file to the repository.
    * Right-click your updated project/file.
    * Click _Team_ and select _Commit_.
    * Enter a comment describing what you have updated.
    * Click _OK_ to commit changes.