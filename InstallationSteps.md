# Notes on installing on Linux #

<!-- Note to self 
I got this working from LovelySanta's branch, I think I should check the version on the Hazel main page too and consider trying to pull the changes from the master into this branch. I could also test if the branch is present on my clone with a view to being able to work on it on Linux or Windows. 
-->


Working from this commit on the linux-support-v2 branch - 83b6a6461425b72b39c8eb15c685720f728bf8ee

## Pulling and changing branches ##

I started with a clone of LovelySanta's repo and the master branch, then switched to the one with Linux support, this has not been merged into the main and is now a few commits behind.  I might have another look at this at some point and see if I can update it with the latest commits from the upstream master branch and submit a pull request. 

```bash
gh repo clone LovelySanta/Hazel -- --recurse-submodules
git checkout linux-support-v2
```

The readme here suggests some dependencies (for Ubuntu,) however, that has a different package structure so I was only able to use some of them. 

```bash
sudo dnf install libXcursor libXrandr libXinerama libXi zenity 
```

Two packages ```libvulkan-dev``` and  ```vulkan-sdk``` were not found. 

## Premake ##

From working with this on Windows I knew Hazel used premake, so I got that installed.  Hazel is works only with 5.0, which is in beta, this isn't in a repo anywhere so I had to pull a binary from their website. 

```bash 
mkdir premake5
cd premake5
wget https://github.com/premake/premake-core/releases/download/v5.0.0-beta2/premake-5.0.0-beta2-linux.tar.gz
tar xfz premake-5.0.0-beta2-linux.tar.gz
```

## Box2D not cloned? ##

When compiling it seemed not all the dependencies were there, I found this command was being run by one of the scripts.  While I'd compiled with recurse submodules I suspect the missing recursive flag was to blame for not all of these being installed correctly.  

```bash
git submodule update --init --recursive
```

## Vulkan SDK dependencies ##

I installed these planning to compile the Vulkan SDK, I suspect they were all dependencies anyway ...

```bash 
sudo dnf install @development-tools glm-devel cmake libpng-devel wayland-devel libpciaccess-devel libX11-devel libXpresent libxcb xcb-util libxcb-devel libXrandr-devel xcb-util-keysyms-devel xcb-util-wm-devel python3 git lz4-devel libzstd-devel python3-distutils-extra qt gcc-g++ wayland-protocols-devel ninja-build python3-jsonschema qt5-qtbase-devel
```

## Vulkan SDK ##

The Vulkan SDK is a known dependency and I was expecting to have to install it, this process was a little tricky on Windows with the installer being called up automatically from a script. 

```bash 
sudo dnf install vulkan-headers vulkan-loader vulkan-loader-devel vulkan-tools vulkan-validation-layers vulkan-validation-layers-devel
```

## Installed shaderc ##

Hazel had an include for this so I installed it from the package manager. 

```bash 
sudo dnf install libshaderc libshaderc-devel
```

## Installed anything SPIRV related ##

I don't know if I needed this after, as the following repo was compiled and eventually linked. 

```bash
sudo dnf install spirv-tools spirv-tools-libs spirv-tools-devel spirv-headers-devel
```

## Compiling SPIRV-Cross ##

Hazel requires this for some reason, I had to build it from the Github [repo](https://github.com/KhronosGroup/SPIRV-Cross)

```bash
gh repo clone KhronosGroup/SPIRV-Cross
cd SPIRV-Cross
mkdir build
cd build
cmake ../ -DSPIRV_CROSS_SHARED=ON
make -j32
sudo make install
```

## Add SPIRV-cross to the path ##

I think this should have worked at this stage, but the .so for SPIRV-cross-c (or something,) wasn't on the path.  I found the library and added it temporarily using

```bash
export LD_LIBRARY_PATH=/usr/local/lib64
```

## Local Directory? ##

Finally I had to hunt for the right location to run the binary from so the resources were in the right place, I kind of knew there was something wonky with this from the windows build.  Finally I had to ...

```bash
cd Hazelnut
../bin/Debug-linux-x86_64/Sandbox/Sandbox
```


