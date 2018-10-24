From: Meelis Roos <mroos@linux.ee>
Date: Wed, 24 Oct 2018 09:26:50 +0000
Subject: [sparc vdso] compile failure in v4.19-4243-ga978a5b - operation combines symbols in different segmen
Message-Id: <748cfe51-e74d-f6fc-a806-7689a86399e0@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This happens on all 4 with 2015-08 32-bit userspace that I tested todays git on:

   CC      arch/sparc/vdso/vclock_gettime.o
{standard input}: Assembler messages:
{standard input}:99: Error: operation combines symbols in different segments
{standard input}:184: Error: operation combines symbols in different segments
{standard input}:292: Error: operation combines symbols in different segments
{standard input}:99: Error: can't resolve `.text' {.text section} - `L0' {.tick_patch section}
{standard input}:99: Error: can't resolve `.tick_patch_replacement' {.tick_patch_replacement section} - `L0' {.tick_patch section}
{standard input}:184: Error: can't resolve `.text' {.text section} - `L0' {.tick_patch section}
{standard input}:184: Error: can't resolve `.tick_patch_replacement' {.tick_patch_replacement section} - `L0' {.tick_patch section}
{standard input}:292: Error: can't resolve `.text' {.text section} - `L0' {.tick_patch section}
{standard input}:292: Error: can't resolve `.tick_patch_replacement' {.tick_patch_replacement section} - `L0' {.tick_patch section}
scripts/Makefile.build:305: recipe for target 'arch/sparc/vdso/vclock_gettime.o' failed

Have not tried on anything with current 64-bit userpace, the machines are not online at the moment.

-- 
Meelis Roos <mroos@linux.ee>
