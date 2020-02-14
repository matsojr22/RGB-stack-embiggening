Dialog.create("File type");
Dialog.addString("File suffix: (currently only works with .tif)", ".tif", 5);
Dialog.show();
suffix = Dialog.getString();

inDir = getDirectory("Choose Directory Containing " + suffix + " Files ");
outDir = getDirectory("Choose Output Directory" + suffix + " Files ");
setBatchMode(true);
processFiles(inDir, outDir, "");
print("paths set");
		print("images to stack");
		run("Images to Stack", "method=[Copy (center)] name=Stack title=[] use");
		print("canvas embiggening sequence initiated!");
		run("Canvas Size...", "width=14000 height=14000 position=Center zero");
		print("saving tiff series");
		run("Image Sequence... ", "format=TIFF name=Stack start=0 digits=2 use save=outDir");
		print("cleaning up the mess...");
		run("Collect Garbage");
		print("Completed!");
function processFiles(inBase, outBase, sub) {
  flattenFolders = true; // this flag controls output directory structure
  print("Processing folder: " + sub);
  list = getFileList(inBase + sub);
  if (!flattenFolders) File.makeDirectory(outBase + sub);
  for (i=0; i<list.length; i++) {
    path = sub + list[i];
    //upath = toUpperCase(path); Leave this line commented out, you only need it if the file extension is case sensitive. Again, this is future proofing against olympus altering the file extension.
    upath = path; //This code was easier to write, and might be replaced by the the previous line (some day) which someone suggested to me.
    if (File.isDirectory(inBase + path)) {
      processFiles(inBase, outBase, path);
      
    }
    else if (endsWith(upath, suffix)) {

		open(inBase + path);
		
		print("importing files");
    }
  }
}
