{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_third (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\anmol\\Documents\\haskell\\third\\.stack-work\\install\\f068709c\\bin"
libdir     = "C:\\Users\\anmol\\Documents\\haskell\\third\\.stack-work\\install\\f068709c\\lib\\x86_64-windows-ghc-9.0.2\\third-0.1.0.0-FMdULiGtpcm4D1LlFQvkt-third"
dynlibdir  = "C:\\Users\\anmol\\Documents\\haskell\\third\\.stack-work\\install\\f068709c\\lib\\x86_64-windows-ghc-9.0.2"
datadir    = "C:\\Users\\anmol\\Documents\\haskell\\third\\.stack-work\\install\\f068709c\\share\\x86_64-windows-ghc-9.0.2\\third-0.1.0.0"
libexecdir = "C:\\Users\\anmol\\Documents\\haskell\\third\\.stack-work\\install\\f068709c\\libexec\\x86_64-windows-ghc-9.0.2\\third-0.1.0.0"
sysconfdir = "C:\\Users\\anmol\\Documents\\haskell\\third\\.stack-work\\install\\f068709c\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "third_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "third_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "third_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "third_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "third_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "third_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
