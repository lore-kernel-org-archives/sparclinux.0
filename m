From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 11 Oct 2011 12:18:02 +0000
Subject: [PATCH 0/4] introduction
Message-Id: <1318335487-25506-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

+ 0001-apbuart-add-polling-callbacks-to-apbuart-driver.patch adds polling functions
    to apbuart.c
    
+ 0002-apbuart-add-support-for-virtual-KGDB-GRMON-channel.patch add GRMON virtual channel
    for KGDB
    
+ The folowing 2 patches address the error that occures in kernel/debug/gdbstub.c:
    ptr += strlen(strcpy(ptr, "thread:"));
    Gcc converts strcpy to a memcpy. There are 2 possible patches:
    
    possibility 1: 0003-kernel-debug-SPARC-KGDB-stub-strcpy-fix.patch
     split into 2 aclls in kernel/debug/gdbstub.c
    possibility 2: 0004-sparc32-return-destination-pointer-on-return-from-me.patch
     fix memcpy to return destination pointer

+ 0005-sparc32-Add-support-for-KGDB-with-SMP-for-leon-and-s.patch Implement
    KGDB for SMP for Leon and sun4d, for sun4m smp4m_ipi_kgdbcapture is a
    stub that has to be implemented later.
 
Greetings Konrad

