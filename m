From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Mar 2005 07:59:12 +0000
Subject: modular floppy broken on sparc32
Message-Id: <Pine.SOC.4.61.0503220958170.29185@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

   MODPOST
*** Warning: "floppy_hardint" [drivers/block/floppy.ko] undefined!

I made floppy modular because of kernel size struggles but it does not 
seem to like it.

-- 
Meelis Roos (mroos@linux.ee)
