From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Sat, 02 Aug 2008 15:17:47 +0000
Subject: Re: 2.6.27-rc1-mm1: sparc64 BUG: using smp_processor_id() in preemptible code
Message-Id: <200808021717.47971.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20080731000354.24b55d5b.akpm@linux-foundation.org>
In-Reply-To: <20080731000354.24b55d5b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org

Hello,

$ uname -a
Linux sparc64 2.6.27-rc1-mm1 #1 SMP PREEMPT Sat Aug 2 15:51:55 CEST 2008 sparc64 sun4u TI UltraSparc II (BlackBird) GNU/Linux

Logs get a little flooded with:

BUG: using smp_processor_id() in preemptible [00000000] code: emerge/3217
caller is smp_call_function_mask+0x1c/0x180
Call Trace:
 [0000000000486374] smp_call_function_mask+0x14/0x180
 [0000000000447f94] tsb_grow+0x2d4/0x420
 [000000000040796c] sparc64_realfault_common+0x10/0x20
 [000000000045b604] schedule_tail+0x64/0xa0
 [0000000000406150] ret_from_syscall+0x8/0x48
BUG: using smp_processor_id() in preemptible [00000000] code: emerge/3220
caller is smp_call_function_mask+0x1c/0x180
Call Trace:
 [0000000000486374] smp_call_function_mask+0x14/0x180
 [0000000000447f94] tsb_grow+0x2d4/0x420
 [000000000040796c] sparc64_realfault_common+0x10/0x20
 [000000000045b604] schedule_tail+0x64/0xa0
 [0000000000406150] ret_from_syscall+0x8/0x48
BUG: using smp_processor_id() in preemptible [00000000] code: rsync/3220
caller is smp_call_function_mask+0x1c/0x180
Call Trace:
 [0000000000486374] smp_call_function_mask+0x14/0x180
 [0000000000447f94] tsb_grow+0x2d4/0x420
 [000000000040796c] sparc64_realfault_common+0x10/0x20
BUG: using smp_processor_id() in preemptible [00000000] code: rsync/3220
caller is smp_call_function_mask+0x1c/0x180
Call Trace:
 [0000000000486374] smp_call_function_mask+0x14/0x180
 [0000000000447f94] tsb_grow+0x2d4/0x420
 [000000000040796c] sparc64_realfault_common+0x10/0x20
BUG: using smp_processor_id() in preemptible [00000000] code: rsync/3224
caller is smp_call_function_mask+0x1c/0x180
Call Trace:
 [0000000000486374] smp_call_function_mask+0x14/0x180
 [0000000000447f94] tsb_grow+0x2d4/0x420
 [000000000040796c] sparc64_realfault_common+0x10/0x20
 [000000000045b604] schedule_tail+0x64/0xa0
 [0000000000406150] ret_from_syscall+0x8/0x48
BUG: using smp_processor_id() in preemptible [00000000] code: file/3246
caller is smp_call_function_mask+0x1c/0x180
Call Trace:
 [0000000000486374] smp_call_function_mask+0x14/0x180
 [0000000000447f94] tsb_grow+0x2d4/0x420
 [000000000040796c] sparc64_realfault_common+0x10/0x20

I'm running preemtible kernel and have seen similar things before:
http://marc.info/?l=linux-kernel&m0652827627051&w=2 and it was fixed by disabling
preemtpion in relevant sparc64 code paths. smp_call_function_mask() documentation
says it must be called with preemption disabled.

Here is a similar fix. Compile and run tested.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.27-rc1-mm1/arch/sparc64/kernel/smp.c	2008-07-29 04:40:31.000000000 +0200
+++ linux-2.6.27-rc1-mm1-dirty/arch/sparc64/kernel/smp.c	2008-08-02 16:40:23.000000000 +0200
@@ -837,7 +837,9 @@ static void tsb_sync(void *info)
 
 void smp_tsb_sync(struct mm_struct *mm)
 {
+	preempt_disable();
 	smp_call_function_mask(mm->cpu_vm_mask, tsb_sync, mm, 1);
+	preempt_enable();
 }


	Mariusz
