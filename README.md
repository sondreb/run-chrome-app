# Run Chrome App Package

Package that enables more rapid edit and run while developing
Chrome Apps with Atom.

The Package adds the ability to run a Chrome App using the Chrome Runtime
with simple shortcuts such as F5 or CTRL-R.

It additionally adds a command to quickly find and open the manifest.json file.

![A screenshot of your spankin' package](https://f.cloud.github.com/assets/69169/2290250/c35d867a-a017-11e3-86be-cd7c5bf3ff9b.gif)

* Developer Notes

The following instructions applies to Windows-users only.

If you want to setup this package from source yourself, first you need to
clone the repository from GitHub:

https://github.com/sondreb/run-chrome-app.git

Now navigate to the folder using Node Command Promt and run the "npm install"
command to get all the required packages.

The next step is to create a symbolic link
of the package folder, so that the Atom Text Editor will load it.

To create a symbolic link, you need to open the Command Promt and run the
mklink command.

Example:
mklink /d C:\Users\Sondre\.atom\packages\run-chrome-app C:\Users\Sondre\Documents\GitHub\run-chrome-app
