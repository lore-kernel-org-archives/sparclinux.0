From: Ben Collins <bcollins@debian.org>
Date: Sun, 20 Jun 2004 17:08:22 +0000
Subject: New SILO (was Re: [SOLVED] Take 3: sparc64 CDs work?)
Message-Id: <20040620170821.GA19634@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I did some checking, and the newer memory allocation in SILO was not
verifying that the initrd physical location was in the lower 32-bits
address range. The kernel only accepts a 32-bit address range for
initrd's. I re-added the check, so now SILO will put out a decent
failure.

I suspect that in the long run, I really need to make it so that the
initrd gets lower memory precendence over the kernel. The kernel itself
can be loaded anywhere for sparc64, even in 64-bit address ranges.

But for now, I am about to release SILO 1.4.6 to atleast make this less
of a mystery on systems where it fails.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
