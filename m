From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Aug 2017 19:25:12 +0000
Subject: arch/sparc/kernel/nmi.c: warning: array subscript is above array bounds
Message-Id: <alpine.LRH.2.20.1708222221270.23061@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just noticed this scroll away when compiling todays 4.13-rc5+git on a 
sparc64 machine with old debian gcc version 4.9.2 (Debian 4.9.2-1).

  CC      arch/sparc/kernel/nmi.o
In file included from ./include/linux/compiler.h:58:0,
                 from ./include/uapi/linux/stddef.h:1,
                 from ./include/linux/stddef.h:4,
                 from ./include/uapi/linux/posix_types.h:4,
                 from ./include/uapi/linux/types.h:13,
                 from ./include/linux/types.h:5,
                 from ./include/linux/proc_fs.h:7,
                 from kernel/cpu.c:6:
kernel/cpu.c: In function 'cpu_up':
./arch/sparc/include/asm/percpu_64.h:13:13: warning: array subscript is above array bounds [-Warray-bounds]
  (trap_block[(__cpu)].__per_cpu_base)
             ^
./include/linux/compiler-gcc.h:53:26: note: in definition of macro 'RELOC_HIDE'
  (typeof(ptr)) (__ptr + (off));     \
                          ^
./include/linux/percpu-defs.h:223:2: note: in expansion of macro 'SHIFT_PERCPU_PTR'
  SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));   \
  ^
./arch/sparc/include/asm/percpu_64.h:14:28: note: in expansion of macro '__per_cpu_offset'
 #define per_cpu_offset(x) (__per_cpu_offset(x))
                            ^
./include/linux/percpu-defs.h:223:26: note: in expansion of macro 'per_cpu_offset'
  SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));   \
                          ^
kernel/cpu.c:802:31: note: in expansion of macro 'per_cpu_ptr'
  struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
                               ^


-- 
Meelis Roos (mroos@linux.ee)
