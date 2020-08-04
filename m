From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 04 Aug 2020 13:17:16 +0000
Subject: [sparc64] enabling CONFIG_PROVE_LOCKING makes kernel unable to build
Message-Id: <CADxRZqybxFr5reVmYM2_h+KUzqL3PU5Qo9nrZSieQPYq+gWWCg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sparc kernel list <sparclinux@vger.kernel.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

Hello!

Linus git master sources:

$ git desc
v5.8-2483-gc0842fbc1b18

If built without "kernel debugging" option CONFIG_PROVE_LOCKING
enabled, builds successfully.

If I enable
CONFIG_PROVE_LOCKING=y

it does not build:

linux-2.6$ make  arch/sparc
scripts/kconfig/conf  --syncconfig Kconfig

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) ||
ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
  Selected by [y]:
  - LOCKDEP [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
&& !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) ||
ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
  Selected by [y]:
  - LOCKDEP [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
&& !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) ||
ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
  Selected by [y]:
  - LOCKDEP [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
&& !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86

  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CALL    scripts/atomic/check-atomics.sh
  CC      arch/sparc/vdso/vclock_gettime.o
In file included from ./arch/sparc/include/asm/bug.h:25,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/sparc/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:15,
                 from ./include/linux/time.h:6,
                 from arch/sparc/vdso/vclock_gettime.c:16:
./include/linux/seqlock.h: In function ‘write_seqcount_begin_nested’:
./arch/sparc/include/asm/percpu_64.h:19:25: error:
‘__local_per_cpu_offset’ undeclared (first use in this function); did
you mean ‘per_cpu_offset’?
   19 | #define __my_cpu_offset __local_per_cpu_offset
      |                         ^~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:145:27: note: in definition of macro ‘WARN_ON_ONCE’
  145 |  int __ret_warn_once = !!(condition);   \
      |                           ^~~~~~~~~
././include/linux/compiler_types.h:301:2: note: in expansion of macro
‘__compiletime_assert’
  301 |  __compiletime_assert(condition, msg, prefix, suffix)
      |  ^~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:313:2: note: in expansion of macro
‘_compiletime_assert’
  313 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:2: note: in expansion of macro
‘compiletime_assert’
   36 |  compiletime_assert(__native_word(t) || sizeof(t) ==
sizeof(long long), \
      |  ^~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:21: note: in expansion of macro
‘__native_word’
   36 |  compiletime_assert(__native_word(t) || sizeof(t) ==
sizeof(long long), \
      |                     ^~~~~~~~~~~~~
./include/asm-generic/rwonce.h:49:2: note: in expansion of macro
‘compiletime_assert_rwonce_type’
   49 |  compiletime_assert_rwonce_type(x);    \
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:10: note: in expansion of macro ‘READ_ONCE’
  119 |  __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
      |          ^~~~~~~~~
./include/linux/percpu-defs.h:231:2: note: in expansion of macro ‘RELOC_HIDE’
  231 |  RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
      |  ^~~~~~~~~~
./include/asm-generic/percpu.h:44:31: note: in expansion of macro
‘SHIFT_PERCPU_PTR’
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
      |                               ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:44:53: note: in expansion of macro
‘__my_cpu_offset’
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
      |                                                     ^~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:242:2: note: in expansion of macro
‘arch_raw_cpu_ptr’
  242 |  arch_raw_cpu_ptr(ptr);      \
      |  ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:21: note: in expansion of macro ‘raw_cpu_ptr’
  119 |  __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
      |                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:138:11: note: in expansion of macro
‘__this_cpu_generic_read_nopreempt’
  138 |   __ret = __this_cpu_generic_read_nopreempt(pcp);  \
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:320:31: note: in expansion of macro
‘this_cpu_generic_read’
  320 | #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
      |                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:321:23: note: in expansion of macro
‘this_cpu_read_1’
  321 |  case 1: pscr_ret__ = stem##1(variable); break;   \
      |                       ^~~~
./include/linux/percpu-defs.h:507:29: note: in expansion of macro
‘__pcpu_size_call_return’
  507 | #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/lockdep.h:565:9: note: in expansion of macro ‘this_cpu_read’
  565 |         this_cpu_read(hardirqs_enabled)));  \
      |         ^~~~~~~~~~~~~
./include/linux/seqlock.h:285:2: note: in expansion of macro
‘lockdep_assert_preemption_disabled’
  285 |  lockdep_assert_preemption_disabled();
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/sparc/include/asm/percpu_64.h:19:25: note: each undeclared
identifier is reported only once for each function it appears in
   19 | #define __my_cpu_offset __local_per_cpu_offset
      |                         ^~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:145:27: note: in definition of macro ‘WARN_ON_ONCE’
  145 |  int __ret_warn_once = !!(condition);   \
      |                           ^~~~~~~~~
././include/linux/compiler_types.h:301:2: note: in expansion of macro
‘__compiletime_assert’
  301 |  __compiletime_assert(condition, msg, prefix, suffix)
      |  ^~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:313:2: note: in expansion of macro
‘_compiletime_assert’
  313 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:2: note: in expansion of macro
‘compiletime_assert’
   36 |  compiletime_assert(__native_word(t) || sizeof(t) ==
sizeof(long long), \
      |  ^~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:21: note: in expansion of macro
‘__native_word’
   36 |  compiletime_assert(__native_word(t) || sizeof(t) ==
sizeof(long long), \
      |                     ^~~~~~~~~~~~~
./include/asm-generic/rwonce.h:49:2: note: in expansion of macro
‘compiletime_assert_rwonce_type’
   49 |  compiletime_assert_rwonce_type(x);    \
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:10: note: in expansion of macro ‘READ_ONCE’
  119 |  __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
      |          ^~~~~~~~~
./include/linux/percpu-defs.h:231:2: note: in expansion of macro ‘RELOC_HIDE’
  231 |  RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
      |  ^~~~~~~~~~
./include/asm-generic/percpu.h:44:31: note: in expansion of macro
‘SHIFT_PERCPU_PTR’
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
      |                               ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:44:53: note: in expansion of macro
‘__my_cpu_offset’
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
      |                                                     ^~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:242:2: note: in expansion of macro
‘arch_raw_cpu_ptr’
  242 |  arch_raw_cpu_ptr(ptr);      \
      |  ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:21: note: in expansion of macro ‘raw_cpu_ptr’
  119 |  __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
      |                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:138:11: note: in expansion of macro
‘__this_cpu_generic_read_nopreempt’
  138 |   __ret = __this_cpu_generic_read_nopreempt(pcp);  \
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:320:31: note: in expansion of macro
‘this_cpu_generic_read’
  320 | #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
      |                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:321:23: note: in expansion of macro
‘this_cpu_read_1’
  321 |  case 1: pscr_ret__ = stem##1(variable); break;   \
      |                       ^~~~
./include/linux/percpu-defs.h:507:29: note: in expansion of macro
‘__pcpu_size_call_return’
  507 | #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/lockdep.h:565:9: note: in expansion of macro ‘this_cpu_read’
  565 |         this_cpu_read(hardirqs_enabled)));  \
      |         ^~~~~~~~~~~~~
./include/linux/seqlock.h:285:2: note: in expansion of macro
‘lockdep_assert_preemption_disabled’
  285 |  lockdep_assert_preemption_disabled();
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:281:
arch/sparc/vdso/vclock_gettime.o] Error 1
make[1]: *** [scripts/Makefile.build:497: arch/sparc/vdso] Error 2
make: *** [Makefile:1757: arch/sparc] Error 2


PS: previously reported build error with v5.8 (
https://lkml.org/lkml/2020/8/3/222 ) is fixed with
48017e5481ce85ba52c4cff082cad5f021c4b413
