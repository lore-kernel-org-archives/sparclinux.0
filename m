From: Ben Collins <bcollins@debian.org>
Date: Wed, 28 Jan 2004 17:10:24 +0000
Subject: SILO 1.4.0 released
Message-Id: <20040128171024.GV532@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After many weeks of bugging the shit out of Dave for help, I've finally
finished the SILO support for loading kernels into arbitrary places in
memory.  What does this mean for all of you? It means it extends the
current limit of kernel image sizes from 3.5Megs to the theoretical
8Megs that the kernel actually supports.

Two cavaets:

1) You need to wait for Dave to pull my kernel changes needed for this
   to work (the kernel needed some work to be able to run from someplace
   other than the physical base of the memory).

2) Currently images > 4Megs fail at some point in the kernel
   initialization. Something goes screwy when a function in the lower
   4Megs tries to access data in the upper 4Megs. The kernel locks two
   4Meg TLB's in the case where the kernel is > 4Megs. Something is
   broken though, and I may need Dave to look at it, since it's beyond
   my understanding at this point.

This only works on sparc64. Someone else can look at the changes I did
in SILO and do something similar for sparc32. You'll likely have to mess
with the kernel (again, wait for Dave to get my changes, and you can
look at those).

WARNING: I need to retest initrd support for sparc64 in the current
SILO, because I changed the way it allocated memory for the kernel and
initrd.  DO NOT consider this SILO stable enough for anything other than
testing at this point.

Even though you don't have the changes for the kernel, I'd appreciate if
people could test this SILO to make sure it works with current setups. I
don't want to break anything running kernels that don't support being
loaded to higher memory. I tested this on my U5, U2, SB100, U30 and
E3000. That's close to most types of machines, but it ain't the end all
to make me sleep better.

So, for the tarball and a binary build of the loaders:

http://www.sparc-boot.org/pub/silo/

If you don't want to compile it, just get the silo-loaders package,
unpack second.b into /boot/ and run "silo -f". Nothing has changed in
the first stage loaders, so you don't have to have the same version.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
