From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Dec 2009 08:48:22 +0000
Subject: arch/sparc/include/asm/uaccess_64.h warning/error
Message-Id: <alpine.SOC.1.00.0912231041010.1790@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Like on x86, I got an error with CONFIG_DEBUG_STRICT_USER_COPY_CHECKS on 
sparc64 too:

  CC      fs/debugfs/file.o
In file included from /home/mroos/compile/linux-2.6/arch/sparc/include/asm/uaccess.h:4,
                 from /home/mroos/compile/linux-2.6/arch/sparc/include/asm/elf_64.h:10,
                 from /home/mroos/compile/linux-2.6/arch/sparc/include/asm/elf.h:4,
                 from include/linux/elf.h:7,
                 from include/linux/module.h:14,
                 from fs/debugfs/file.c:16:
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/uaccess_64.h: In function 'write_file_bool':
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/uaccess_64.h:232: error: call to 'copy_from_user_overflow' declared with attribute error: copy_from_user() buffer size is not provably correct

-- 
Meelis Roos (mroos@linux.ee)
