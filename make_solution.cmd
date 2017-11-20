set SRC_DIR=%~dp0
set BASE_DIR=%SRC_DIR%..

Rem extract the prebuilt prerequisites, using cmake for this avoids additional installation prerequistes
pushd %BASE_DIR%
cmake -E tar xv %SRC_DIR%\prerequisites\mapserver_prerequisites.zip
popd
set ORACLE_HOME=%BASE_DIR%\instantclient_12_1\
set PREREQ_DIR=%BASE_DIR%\release-1800-x64
mkdir %BASE_DIR%\build
pushd %BASE_DIR%\build
cmake.exe -G "Visual Studio 12 2013 Win64" %SRC_DIR% ^
-DCMAKE_PREFIX_PATH=%PREREQ_DIR% ^
-DREGEX_DIR=%BASE_DIR%\regex-0.12 ^
-DSWIG_EXECUTABLE=%BASE_DIR%\SWIG-1.3.39\swig.exe ^
-DWITH_POSTGIS=0 ^
-DWITH_ORACLE_PLUGIN=1 ^
-DWITH_MSSQL2008=1 ^
-DWITH_CSHARP=1 ^
-DWITH_KML=1 ^
-DWITH_CLIENT_WMS=1 ^
-DWITH_CLIENT_WFS=1 ^
-DMS_EXTERNAL_LIBS=WS2_32.Lib ^
-DCMAKE_C_FLAGS_RELWITHDEBINFO="/Od /Zi /Ob1 /MD" ^
-DCMAKE_CXX_FLAGS_RELWITHDEBINFO="/Od /Zi /Ob1 /MD" ^
-DICONV_DLL=%PREREQ_DIR%\bin\iconv.dll ^
-DINSTALL_LIB_DIR="" ^
-DINSTALL_BIN_DIR="" ^
-DCMAKE_INSTALL_PREFIX="c:\Program Files\Bentley\eB\Map Rendering Engine.build" 

Rem Now build mapserver
cmake --build . --config RelWithDebInfo
popd

