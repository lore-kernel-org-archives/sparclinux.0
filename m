From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sun, 27 May 2007 20:33:59 +0000
Subject: SILO bug
Message-Id: <Pine.LNX.4.61.0705272225100.11140@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi fans of sparcs,


there's a bug in SILO. When it prints the boot: line, enter some invalid 
filename. Afterwards, issue ls:

boot: /foo  
Allocated 8 Megs of memory at 0x40000000 for kernel

Cannot find /foo (Unknown ext2 error: 2133571404)

Image not found.... try again
boot: ls /
Fast Data Access MMU Miss
{0} ok boot


	Jan
-- 
