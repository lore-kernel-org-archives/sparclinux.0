From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 23 Dec 2006 19:19:32 +0000
Subject: Oops during boot on Netra X1 with 2.6.18 in isa_dev_get_resource
Message-Id: <20061223191932.GA4749@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Richard Mortimer (CC'd) reported an oops when booting 2.6.18 on 
Netra X1. Richard writes:

> I believe that the problem is due to a null pointer being returned 
> from of_get_property in isa_dev_get_resource() 
> arch/sparc64/kernel/isa.c. Enclosed is a disassembly of the 
> appropriate bit of code along with the prtconf -pv output for the 
> isa device tree. I wonder if the problem might be the fact that the 
> todm5819 node does not have "reg" properties.

All the debugging information is included in Debian bug report at

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug@4216

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
