From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 13 Jan 2009 10:06:26 +0000
Subject: collision: arch/sparc/include/asm/spinlock_64.h vs.
Message-Id: <a4423d670901130206r7cc1bdfcw685a3895bb2fc3bf@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

__raw_{read,write}*() are defined in both places.

 In file included from
/home/alexb/linux-2.6/arch/sparc/include/asm/spinlock.h:4,
                 from arch/sparc/kernel/sparc_ksyms_64.c:12:
/home/alexb/linux-2.6/arch/sparc/include/asm/spinlock_64.h:221:1:
error: "__raw_write_can_lock" redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from arch/sparc/kernel/sparc_ksyms_64.c:8:
include/linux/spinlock_up.h:70:1: error: this is the location of the
previous definition
