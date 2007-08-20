From: Robert Reif <reif@earthlink.net>
Date: Mon, 20 Aug 2007 22:46:54 +0000
Subject: Re. [SPARC32]: Fix bogus ramdisk image location check.
Message-Id: <46CA19DE.3000108@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

commit    f642b263800e6e57c377d630be6d2a999683b579

This patch causes sparc32 SMP to watchdog fail on boot.

Reverting it lets the system boot.

