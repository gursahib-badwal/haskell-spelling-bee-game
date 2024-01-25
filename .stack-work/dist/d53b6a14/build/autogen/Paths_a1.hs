{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_a1 (
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

bindir     = "C:\\Users\\SAINI\\OneDrive\\Desktop\\CMPT 383\\CMPT - 383 Assignments\\a1\\.stack-work\\install\\76c540f9\\bin"
libdir     = "C:\\Users\\SAINI\\OneDrive\\Desktop\\CMPT 383\\CMPT - 383 Assignments\\a1\\.stack-work\\install\\76c540f9\\lib\\x86_64-windows-ghc-9.0.2\\a1-0.1.0.0-5oHh3Hm3csm88wSsVTDYEO"
dynlibdir  = "C:\\Users\\SAINI\\OneDrive\\Desktop\\CMPT 383\\CMPT - 383 Assignments\\a1\\.stack-work\\install\\76c540f9\\lib\\x86_64-windows-ghc-9.0.2"
datadir    = "C:\\Users\\SAINI\\OneDrive\\Desktop\\CMPT 383\\CMPT - 383 Assignments\\a1\\.stack-work\\install\\76c540f9\\share\\x86_64-windows-ghc-9.0.2\\a1-0.1.0.0"
libexecdir = "C:\\Users\\SAINI\\OneDrive\\Desktop\\CMPT 383\\CMPT - 383 Assignments\\a1\\.stack-work\\install\\76c540f9\\libexec\\x86_64-windows-ghc-9.0.2\\a1-0.1.0.0"
sysconfdir = "C:\\Users\\SAINI\\OneDrive\\Desktop\\CMPT 383\\CMPT - 383 Assignments\\a1\\.stack-work\\install\\76c540f9\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "a1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "a1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "a1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "a1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "a1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "a1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
