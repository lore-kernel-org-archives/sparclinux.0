From: Ben Collins <bcollins@debian.org>
Date: Thu, 13 May 2004 20:21:46 +0000
Subject: initrd testing
Message-Id: <20040513202146.GD1098@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Some people have reported problems with initrd on sparc64. I'm trying to
trace that problem (hard, because I can't reproduce it). If you've had
the problem where silo reports loading the initrd into memory, but the
kernel fails to detect and use it, please try the second.b in the url
below, and recompile a kernel using one of the two patches there aswell
(2.4 and 2.6).

The new second.b will show the phys address that the initrd was loaded
to, in addition to the virtual address.

Thanks.

http://www.sparc-boot.org/pub/testing/

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
