From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 25 Feb 2007 20:07:03 +0000
Subject: Unaligned accesses in ip_rcv and ip_fast_csum
Message-Id: <20070225200702.GA4451@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

We have a report (Debian bug #409313 [0]) of the following unaligned 
accesses, occuring every 5-6 seconds on Netra X1 and SunFire v100 with 
kernel 2.6.18 and newer:

Kernel unaligned access at TPC[5e4420] ip_rcv+0xd0/0x58c
Kernel unaligned access at TPC[517f84] ip_fast_csum+0xc/0x80
Kernel unaligned access at TPC[517f88] ip_fast_csum+0x10/0x80
Kernel unaligned access at TPC[517f8c] ip_fast_csum+0x14/0x80
Kernel unaligned access at TPC[517f94] ip_fast_csum+0x1c/0x80

I was hoping to debug it myself, but due to time constraints was not 
able to get too far.

[0] http://bugs.debian.org/409313

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
