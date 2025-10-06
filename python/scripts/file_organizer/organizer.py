import os

source_dir = input("Directory to organize [current]: ") or "."

# Get a list of files in source folder
files = os.listdir(source_dir)

# Go through files, sorting them into their respective directory. Skips directories
for file in files:
    if(os.path.isfile(os.path.join(source_dir,file)) == True):
        file_extension = file.split(".")[-1]

        # If file extension directory hasn't been created yet, create it
        extension_dir = os.path.join(source_dir,file_extension)
        if os.path.isdir(extension_dir) == False:
            os.mkdir(extension_dir)
        
        # Move the file into it's extension's folder
        src = os.path.join(source_dir, file)
        dst = os.path.join(source_dir, file_extension, file)
        os.rename(src, dst)