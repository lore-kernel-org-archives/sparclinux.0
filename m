From: Ben Collins <bcollins@debian.org>
Date: Mon, 12 Jul 2004 00:38:17 +0000
Subject: Test second.b for helping to fix initrd problems
Message-Id: <20040712003817.GC16609@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I haven't been able to nail down this initrd problem with SILO. No one
else has had time to dig into it either.

I can't reproduce it. Moving dimms around in my machines doesn't cause a
problem.

I've made a second.b that is a little more verbose with the sparc64 memory
finder routine. I'd appreciate it if anyone that is having problems with
initrd could test this so I can see the output. If you happen to be able
to move your dimms around in a way that allows SILO to work, then please
send me the output of both ways so I can compare notes.

I need to get this bug fixed. Quite a few dists are hurting because of it.

http://www.sparc-boot.org/pub/testing/second.b

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
