From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 19 May 2005 05:20:14 +0000
Subject: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6 work]
Message-Id: <Pine.LNX.4.61.0505190111530.13987@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi again,

I have now tried the pristine 2.6.11.10 kernel and it fails on mounting 
initrd too on my Hypersparc-powered SS10. The last messages (same as with 
Debian kernels) I see are:

NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2556KiB [1 disk] into ram disk... done.
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
  <0>Press L1-A to return to the boot prom

It would be nice if you (or someone else) could confirm (or not :-) that, 
since it would eliminate possible initrd/toolchain problems.

http://www.wooyd.org/misc/sparc32.config

Thanks and best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
A
