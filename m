From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 03 Jun 2006 02:29:20 +0000
Subject: Re: Sun Blade 2500
Message-Id: <Pine.LNX.4.63.0606021919280.2727@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Tobias have posted a question on the debian-sparc mailing list, asking 
whether he can install Debian on Blade 2500. I was able to find an old 
thread [0] from May 2005, where Dave mentioned that at that time the 
machine was not yet supported. It looks like there was at least some 
progress since then (likely due to Dave's efforts :-), because Tobias is 
at least able to boot the installer on it. It does not find the disks 
though, so I wonder what kind of drivers are required for its SCSI 
controller. Thread [1] mentions message/fusion/mpt* modules, however the 
original poster never confirmed that he got it working, so it would be 
nice to hear from someone who is actually running Linux on such a box.

[0] http://lists.debian.org/debian-sparc/2005/05/msg00166.html
[1] http://lists.debian.org/debian-boot/2005/12/msg00554.html

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
