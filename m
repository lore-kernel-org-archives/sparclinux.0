From: Chris Newport <crn@netunix.com>
Date: Mon, 21 Feb 2005 15:49:23 +0000
Subject: SILO: sun4c does not boot from CD
Message-Id: <421A0303.2010807@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Using SILO 1.4.8 and making a bootable CD as per the instructions, the 
CD works just fine on Sun4m, Sun4d, and Sun4u but fails to boot on my
Sparc 1 ROM Rev 1.3  64Mb.
It boots OK from an older Splack 8.0 CD which was made using the old 
patched mkisofs-sparc.

 > n
ok boot sd(0,6,0)
Booting from: sd(0,6,0)
SProgram terminated

Looks like isofs.b cannot find or load second.b ?
Is this a known problem and is there a workaround ?.


