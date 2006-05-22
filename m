From: Meelis Roos <mroos@linux.ee>
Date: Mon, 22 May 2006 13:33:59 +0000
Subject: Warnings from latest git
Message-Id: <Pine.SOC.4.61.0605221632480.4211@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is todays 2.6.17-rc4+git,
cg-update && make oldconfig && make && make image

[...]
   MODPOST
WARNING: vmlinux: 'sys_close' exported twice. Previous export was in vmlinux
WARNING: arch/sparc64/solaris/solaris.o - Section mismatch: reference to .init.text:init_socksys from .text between 'init_module' (at offset 0x2c8c) and 'cleanup_module'
[...]

-- 
Meelis Roos (mroos@linux.ee)
