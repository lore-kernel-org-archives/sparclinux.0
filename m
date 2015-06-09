From: James Y Knight <jyknight@google.com>
Date: Tue, 09 Jun 2015 04:11:03 +0000
Subject: Linux Sparc FPU register corruption
Message-Id: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_96DEE7E0-8EE4-496B-8DBF-6972FAAF4F4C"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--Apple-Mail=_96DEE7E0-8EE4-496B-8DBF-6972FAAF4F4C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Those for whom this is a followup: the ASI_BLK_P stores used by memcpy, =
memset, and bzero in glibc seem to definitely be a problem. And, I'm =
going to going to have to take back some of my previous words -- this =
really is looking like a kernel bug (or two) now, rather than a glibc =
bug as I had thought likely. Oops. :)


For those just joining my tale: I have a Sparc T3-1, with Debian =
Unstable's Sparc port on it as a guest in a "Oracle VM Server for Sparc" =
("ldm") VM. I'm running a recent debian kernel: =
linux-image-4.0.0-2-sparc64-smp 4.0.4-1. In case you're not familiar, =
note that Debian has a 64bit kernel, with a 32bit userland, which has =
been compiled to assume at least sparcv9 CPUs (the so called "v8plus" =
mode in gcc).

I unfortunately found that sometimes, programs like "gcc" are getting =
incorrect behavior or segfaults. Aurelian reported the same issue a =
couple years ago, reporting that it only occurs on UltraSparc T1 and =
later processors, not earlier UltraSparcs (I have no other Sparc to test =
on, so I cannot confirm that myself). I wanted to fix the problem, so I =
could use the machine. And I did -- by getting rid of the sparcv9 =
optimized asm routines in glibc (going back to the base sparc32 =
routines), everything seems to be working reliably. The machine became =
properly usable with Linux for the first time.

I thus guessed that the issue was just a bug in glibc's routines. But, =
despite having seemingly fixed my problem, not knowing *why* it had been =
broken bugged me...So, further down this rabbit hole I went...

...And found that the glibc routines were broken because the floating =
point registers they were blatting to memory sometimes got replaced with =
garbage, not because of anything they were doing wrong themselves. D'oh!

Attached is a simple reproduction case, not involving the glibc =
functions, which exhibits the same FP register corruption problem I see =
when using the memset routine in glibc's =
sysdeps/sparc/sparc32/sparcv9/memset.S.

For comparison, this test program appears to runs perfectly reliably =
under Solaris on the same hardware.

Problem 1 - Lower 16 fp regs (%f0 - %f31) getting overwritten with =
garbage.
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Basically, it appears that if you do:
  stda %f0, [%0] ASI_BLK_P
...and the address you're storing into causes a fault to the kernel =
(e.g. in the example, it's a freshly mmapped zero-page), then, =
SOMETIMES, the first 16 fp registers seem to get trashed.

I'm guessing the kernel uses the FPU internally, and then forgets to =
restore the registers upon return from the trap handler sometimes, for =
some reason? But why only for this instruction? (Does the kernel care =
which instruction caused the page fault trap? Or, could it be a hardware =
bug that's trashing the fpu registers, not a kernel bug? But since it =
works in Solaris, probably not?)

If you then do a syscall like usleep, these registers are *usually* =
restored to their previous, valid, contents. This appears to be since I =
didn't modify any fp registers, so they're not marked as dirty, and thus =
the corrupted versions never get saved to the kernel thread_info struct =
on the way into the usleep. Then, on resume of the task after the =
usleep, the correct register contents get properly restored from the =
saved location. (I've verified that touching a low fp reg before the =
usleep *does* cause the bogus values to be preserved across the usleep =
call).

Here's some typical looking output from running:
  gcc ~/test-err.c
  seq 64 | xargs -n1 -P64 /bin/sh -c 'while ./a.out; do : ; done'

(I have 64 vCPUs assigned to linux, that's why 64 parallelism). This =
typically reproduces the issue for me in 10 seconds or less.

FP regs xx: 0: 0xffff8005784d5600 0xffff800554ff3500 0xffff800088091900 =
0xffff800dd7dda600 0xffff800de669ee00 0xffff800dd865d800 =
0xffff800dd5c18500 0xffff800de6717500
FP regs xx: 1: 0xffff800088091900 0xffff800dd7dda600 0xffff800de669ee00 =
0xffff800dd865d800 0xffff800dd5c18500 0xffff800de6717500 =
0xffff8005784d5600 0xffff800554ff3500
FP regs xx: 2: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708
FP regs xx: 3: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708

FP regs yy: 0: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708
FP regs yy: 1: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708
FP regs yy: 2: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708
FP regs yy: 3: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708

Note that all regs were supposed to be 0x102030405060708, but that the =
first 16 are trashed in "xx", and then corrected in "yy" ("yy" being the =
second time I read them, after the usleep). BTW, all those garbage =
register values sure do look suspiciously like they might be kernel =
memory addresses, don't you think? ("MM: PAGE_OFFSET is =
0xffff800000000000 (max_phys_bits =3D=3D 43)") The values that appear =
are not always the same. They also don't always look like kernel memory =
addresses, but most often, they do.

Anyhow -- #define USE_BLKSTORE 0 in the test program "fixes" this =
problem. If I use a normal store instruction instead of the block store, =
the lower 16 fp regs seem always reliably preserved.


Problem 2 - *Upper* 16 fp regs (%f32 - %f63) getting replaced by zeros.
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Additionally, while creating the test case for Problem 1, I've found =
what at first glance appears to be a separate bug -- potentially a worse =
one, since it can affect code that doesn't use ASI_BLK_P, so it's not as =
easy to fix. (Although...this issue seems to occur *much* less often, =
sometimes taking a few minutes to reproduce). In the same example =
program as before, once I've "#define USE_BLKSTORE 0", sometimes I see =
the upper 16 regs have all turned into zeros! (This can also be observed =
with USE_BLOCKSTORE=3D1, too, it's just usually overshadowed by the more =
frequent other issue). In either case, the usleep call doesn't restore =
the lost upper registers.

E.g., I'll get this output:

FP regs xx: 0: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708
FP regs xx: 1: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708
FP regs xx: 2: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
FP regs xx: 3: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0

FP regs yy: 0: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708
FP regs yy: 1: 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708 0x102030405060708 0x102030405060708 0x102030405060708 =
0x102030405060708
FP regs yy: 2: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
FP regs yy: 3: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0


In summary:
Always: upper 16 fp regs sometimes zeroed.
Using ASI_BLK_P: lower 16 fp regs often corrupted.
Without ASI_BLK_P: lower 16 fp regs (seemingly) always preserved.

Any ideas?


--Apple-Mail=_96DEE7E0-8EE4-496B-8DBF-6972FAAF4F4C
Content-Disposition: attachment;
	filename=test-err.c
Content-Type: application/octet-stream;
	name="test-err.c"
Content-Transfer-Encoding: 7bit

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

#define USE_BLKSTORE 1

static void set_fp_regs(long long val) {
  long long *pval = &val;
  asm volatile (
"ldd [%0], %%f0; ldd [%0], %%f2; ldd [%0], %%f4; ldd [%0], %%f6; ldd [%0], %%f8;"
"ldd [%0], %%f10; ldd [%0], %%f12; ldd [%0], %%f14; ldd [%0], %%f16; ldd [%0], %%f18;"
"ldd [%0], %%f20; ldd [%0], %%f22; ldd [%0], %%f24; ldd [%0], %%f26; ldd [%0], %%f28;"
"ldd [%0], %%f30; ldd [%0], %%f32; ldd [%0], %%f34; ldd [%0], %%f36; ldd [%0], %%f38; "
"ldd [%0], %%f40; ldd [%0], %%f42; ldd [%0], %%f44; ldd [%0], %%f46; ldd [%0], %%f48; "
"ldd [%0], %%f50; ldd [%0], %%f52; ldd [%0], %%f54; ldd [%0], %%f56; ldd [%0], %%f58; "
"ldd [%0], %%f60; ldd [%0], %%f62" : : "r"(pval));
}

static void get_fp_regs(long long *xx) {
  asm volatile (
"std %%f0,  [%0 + 0x00]; std %%f2, [%0 + 0x08]; "
"std %%f4, [%0 + 0x10]; std %%f6, [%0 + 0x18]; "
"std %%f8, [%0 + 0x20]; std %%f10, [%0 + 0x28]; "
"std %%f12, [%0 + 0x30]; std %%f14, [%0 + 0x38]; "
"std %%f16, [%0 + 0x40]; std %%f18, [%0 + 0x48]; "
"std %%f20, [%0 + 0x50]; std %%f22, [%0 + 0x58]; "
"std %%f24, [%0 + 0x60]; std %%f26, [%0 + 0x68]; "
"std %%f28, [%0 + 0x70]; std %%f30, [%0 + 0x78]; "
"std %%f32, [%0 + 0x80]; std %%f34, [%0 + 0x88]; "
"std %%f36, [%0 + 0x90]; std %%f38, [%0 + 0x98]; "
"std %%f40, [%0 + 0xa0]; std %%f42, [%0 + 0xa8]; "
"std %%f44, [%0 + 0xb0]; std %%f46, [%0 + 0xb8]; "
"std %%f48, [%0 + 0xc0]; std %%f50, [%0 + 0xc8]; "
"std %%f52, [%0 + 0xd0]; std %%f54, [%0 + 0xd8]; "
"std %%f56, [%0 + 0xe0]; std %%f58, [%0 + 0xe8]; "
"std %%f60, [%0 + 0xf0]; std %%f62, [%0 + 0xf8]" : : "r"(xx) : "memory");
}

static void print_fp_regs(char *prefix, long long *xx) {
  printf("%s0: 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx\n",
	 prefix, xx[0], xx[1], xx[2], xx[3], xx[4], xx[5], xx[6], xx[7]);
  printf("%s1: 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx\n",
	 prefix, xx[8], xx[9], xx[10], xx[11], xx[12], xx[13], xx[14], xx[15]);
  printf("%s2: 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx\n",
	 prefix, xx[16], xx[17], xx[18], xx[19], xx[20], xx[21], xx[22], xx[23]);
  printf("%s3: 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx\n",
	 prefix, xx[24], xx[25], xx[26], xx[27], xx[28], xx[29], xx[30], xx[31]);
  printf("\n");
}

int main() {
  void *res = mmap(NULL, 0x14a000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  if (res == MAP_FAILED || ((long)res & 0xfff) != 0) {
    printf("Unexpected address %p", res);
    return 1;
  }

  long long __attribute__((aligned (256))) xx[32];
  long long __attribute__((aligned (256))) yy[32];
      
  set_fp_regs(0x0102030405060708);
#if USE_BLKSTORE
  int *mem;
  for (mem = (int*)res; mem < (int*)((char*)res + 0x140000); mem += 16) {
    // 0xf0 == ASI_BLK_P
    asm volatile("stda %%f0, [%0] 0xf0" : : "r"(mem) : "memory");
  }
#else
  int *mem;
  for (mem = (int*)res; mem < (int*)((char*)res + 0x140000); mem += 16) {
    *mem = 0;
  }
  asm volatile("" : : "r"(mem) : "memory");
#endif
  get_fp_regs(xx);

  int i;
  for(i = 0; i < 32; ++i) {
    if (xx[i] != 0x0102030405060708) {
      // Modifying a low-fp register causes the usleep to not restore the values.
      // asm volatile("fsrc2 %f32, %f0");
      // Calling usleep causes the fp registers to regain their proper values.
      usleep(10);
      get_fp_regs(yy);
      print_fp_regs("FP regs xx: ", xx);
      print_fp_regs("FP regs yy: ", yy);
      abort();
    }
  }
    
  return 0;
}


--Apple-Mail=_96DEE7E0-8EE4-496B-8DBF-6972FAAF4F4C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



James

On Jun 5, 2015, at 5:39 PM, Patrick Baggett <baggett.patrick@gmail.com> =
wrote:

> I would ask David S. Miller about the sparc ASM stuff - he seems to be =
the resident sparc genius and linux kernel maintainer.
>=20
> On Fri, Jun 5, 2015 at 4:18 PM, James Y Knight <jyknight@google.com> =
wrote:
>=20
>> On Jun 4, 2015, at 11:07 AM, James Y Knight <jyknight@google.com> =
wrote:
>>> GLibc
>>> =3D=3D=3D=3D=3D
>>> After that, everything seemed to be going fine, except that programs =
like GCC would randomly segfault and give parse errors. This has been =
reported before, e.g. =
http://thread.gmane.org/gmane.linux.ports.sparc/16835, from 2 years ago. =
Things were stable enough to use interactively, if you're willing to =
keep retrying a build until it works, but not stable enough to use for =
any autobuild system.
>>>=20
>>> After a getting a hint from Aurelien that disabling optimized memcpy =
routines in glibc (eglibc 2.19-1, on Wed, 04 Jun 2014 20:32:06 +0200) =
had improved, but did not fix, the problem, I started looking into =
that....
>>>=20
>>> ...And found that recompiling glibc, disabling the sparcv9 =
optimizations (that is: eliminating =
debian/patches/sparc/local-sparcv9-target.diff), *appears* to have =
completely fixed the stability issue!
>>>=20
>>> To try to verify that, I ran a loop building and rebuilding 'clang' =
(with full "ninja" parallelism) overnight, and it's had zero crashes in =
all 14 builds of clang that it got through. Prior to fixing glibc, at =
least one of the ~2300 build steps (gcc/as/ld) was sure to crash =
unreproducibly.
>>>=20
>>> It'd be great if someone wants to try to figure out exactly /which/ =
of the asm routines in the various sysdeps/**/sparc32/sparcv9 are =
broken, to narrow down the problem better, too. I highly suspect there's =
just something wrong in one or more of the hand-written asm files, but =
it's certainly possible there's some wider problem that the sparcv9 =
optimizations of glibc (but nothing else I've seen so far), just happens =
to expose.
>>=20
>> So, bad news and good news:=20
>>=20
>> Bad News: the above solution of simply disabling sparcv9 breaks some =
things (other than gcc). It breaks something about atomics or =
semaphores, likely due to a mismatch of expectations between libc and =
other things (the sparc32 routines, when *NOT* compiled in a shared =
library, dynamically choose between the v8 and v9 ways of doing things, =
so it's entirely reasonable to assume that doing it the v8 way cannot =
work right).
>>=20
>> Good News:
>>=20
>> My next attempt at a fix, is to just disable the optimized string =
ops:
>>  rm sysdeps/sparc/sparc32/sparcv9/*mem* =
sysdeps/sparc/sparc32/sparcv9/*st*
>> That seems to still have fixed the random gcc crashes, AND doesn't =
break other things. :)
>>=20
>>=20
>> Looking into what the deleted routines are doing that's =
"interesting":
>>=20
>> * memcpy and memset:
>>=20
>> They're using LDBLOCKF STBLOCKF "block copy" instructions, which are:
>> 1) Not actually part of the Sparcv9 standard instruction set, but =
rather are processor-specific (Although, these processor-specific =
instructions have been implemented since the UltraSPARC I).
>> "The LDBLOCKF instruction is intended to be a processor-specific =
instruction, which may or may not be implemented in future Oracle SPARC =
Architecture implementations. Therefore, it should only be used in =
platform-specific dynamically-linked libraries or in software created by =
a runtime code generator that is aware of the specific virtual processor =
implementation on which it is executing."
>>=20
>> 2) Marked deprecated.
>> "The LDBLOCKF instructions are deprecated and should not be used in =
new software. A sequence of LDDF instructions should be used instead."
>>=20
>> 3) Don't follow the normal TSO memory model ordering that everything =
else does; they require explicit MEMBARs in the right places to ensure =
even *single-thread/cpu* memory ordering correctness.
>> "Block operations do not generally conform to dependence order on the =
issuing virtual processor; that is, no read-after-write or =
write-after-read checking occurs between block loads and stores. =
Explicit MEMBARs are required to enforce dependence ordering between =
block operations that reference the same address."
>>=20
>> It certainly looks like the author of those routines *tried* to do =
the right thing w.r.t. inserting membar instructions in the right place, =
but I can easily imagine it's wrong somehow. And it is entirely =
plausible that the behavior would be hardware-generation specific, since =
it has, by design, weird hardware-specific memory semantics. I'm placing =
my bets on this one being the problem.
>>=20
>> * memchr, memcmp, strcmp, strcpy, etc.
>>=20
>> These are using a nonfaulting load instruction. The nonfaulting load =
doesn't actually mean the hardware doesn't fault on loading from an =
unmapped page. Actually, unmapped pages still cause a fault, but the =
fault is supposed to be handled by the OS. It's also possible to map =
pages as "for use by nonfaulting loads only" (linux doesn't appear to do =
this).
>>=20
>> That's a rare instruction -- not generated by GCC I think, so I could =
imagine there being a bug in the fault handler for it. I think that's =
less likely though, since it doesn't seem like it'd be CPU-architecture =
specific.
>>=20
>> James
>>=20
>>=20


--Apple-Mail=_96DEE7E0-8EE4-496B-8DBF-6972FAAF4F4C--
