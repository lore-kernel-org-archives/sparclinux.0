From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 11 Apr 2006 01:53:44 +0000
Subject: Issues with SILO 1.4.11
Message-Id: <Pine.LNX.4.63.0604101839350.3168@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Recently we've tried to get the latest SILO (1.4.11) into the Debian 
unstable. Unfortunately, testing revealed that there is a regression:
Frans Pop has noted that when used on his Ultra 10, new SILO does not 
handle the timeout before booting correctly. On Ultra 10 it just sits 
at the boot prompt, waiting for someone to press Enter, which is pretty 
bad. It works fine on my Ultra 60. Frans has also confirmed, that if the 
changes in second/timer.c, introduced in 1.4.11 are reverted, the old 
behaviour is restored.

Another piece of information regarding new SILO, is that it still fails to 
boot SunFire V880 from CD. Stephen Frost was kind enough to test it on his 
machine, and sent me the following transcript:

   Rebooting with command: boot cdrom
   Boot device: /pci@8,700000/scsi@1/disk@6,0:f  File and args:
   SILO Version 1.4.11
   Fast Data Access MMU Miss
   {2} ok

Any ideas on what can be done to take care of these problems are welcome.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
