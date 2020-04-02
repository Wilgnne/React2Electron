const { app, BrowserWindow } = require("electron");
const isDev = require("electron-is-dev");
const serve = require('electron-serve');

const loadURL = serve({directory: 'build'});

let mainWindow;

function createWindow() {
  mainWindow = new BrowserWindow({ 
    width: 1024, 
    height: 768,
    minWidth: 1024,
    minHeight: 768,
  });

  mainWindow.setMenuBarVisibility(false);

  if (isDev)
    mainWindow.loadURL("http://localhost:3000");
  else
    (async () => await loadURL(mainWindow))();

  mainWindow.on("closed", () => (mainWindow = null));
}
app.on("ready", createWindow);

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});

app.on("activate", () => {
  if (mainWindow === null) {
    createWindow();
  }
});