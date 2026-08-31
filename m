Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D9471CF8;
	Mon, 31 Aug 2026 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197281; cv=none; b=ooEfabpkbZP3LFhDThRMyaosEl7NjqUb7Q+2jR3sk5v/T45FDttH4BmkNLDzfeSTOHFMoCiu9oX8QNUZdWKIpfhkKJmVnc/0t90kA0D9qtz80ejSUp6OvSJDLHTpQpM8zRx5uLM7gCuOimlU/3CBzc8R2EAsX4sIg8SSD08ad8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197281; c=relaxed/simple;
	bh=kJ/1S4MN5n7+K+xTF2iKj4EfERSCdDgvdRmDcOUB7S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3ut+84gmwKEZM/aS4z5t2TXLvtNGJrjon5QPxWZzJyexfuNGc34xa2fF/im8QsAW+IMnrverdfBRNt2NQF4BCZHqldgesPvGSAin5Fhr565FFpYRGUe2v32Ue4wnKjITlfNzxOrte1tADxd1V29Fw8q5/Ozg0TICayRMksqN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=W3yyVjUQ; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="W3yyVjUQ"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788197271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A35Ouro+X6StzgWpM1L9TM6AUuUV0Hekn7+ox6+lvgQ=;
	b=W3yyVjUQlAx5lfmbjCW3sTjnsCRiLWtctj81Cl6F88gvozhZ5yi/AXP/4Wj6baP4HtZvu+
	TZ9XKuKdIBo4QSOMg6u8uDV3HhIOsCtWNkKGOaiV2ollbec5oU73QtNqIJAsv4EDEw+Bsa
	OG2O8tHoOuwkTjmAks+nzpCv2v14Cd0=
To: David Laight <david.laight.linux@gmail.com>,
	Tony Rodriguez <unixpro1970@gmail.com>
Cc: Stian Halseth <stian@itx.no>,
	davem@davemloft.net,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreas@gaisler.com,
	thuth@redhat.com,
	regressions@lists.linux.dev,
	glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH 0/1] sparc64: unify thread stack sizing and add explicit 32KB stack
Date: Mon, 31 Aug 2026 19:27:38 +0200
Message-ID: <20260831172739.3082423-1-stian@itx.no>
In-Reply-To: <20260520144104.618c75ca@pumpkin>
References: <20260520144104.618c75ca@pumpkin>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 14:41:04 +0100, David Laight wrote:
> Without the stack offsets from the dump, look at the stack frame sizes
> for the functions in that traceback.
> I suspect there are too many that get near the compile-time threshold.

I measured this on an UltraSPARC T4-1 (sun4v, onboard NEC OHCI/EHCI,
internal hub chain) running 7.2.0 with CONFIG_STACK_TRACER, booted
with "stacktrace" so the tracer was armed before the hcd drivers
probed.

It is the opposite: no frame comes near the warning threshold - the
largest in any capture is 408 bytes - but ~85% of frames are 176-224
bytes, i.e. at or just above the SPARC V9 ABI minimum (128-byte
window save area + 48-byte argument save area, paid by every non-leaf
call). The stack goes to frame count, not frame size.

The high-water mark of an ordinary successful boot was 12616 of 16384
bytes, and the maximum path is exactly the contested one - hub_probe,
with a printk and then a timer interrupt on top:

  0)    12600     208   arch_ftrace_ops_list_func+0x130/0x1c0
  1)    12392     176   hypervisor_xcall_deliver+0x4/0x320
  2)    12216     208   xcall_deliver+0x128/0x140
  3)    12008     176   arch_send_call_function_single_ipi+0x3c/0x60
        [...]
  7)    11304     176   sched_balance_trigger+0x39c/0x4e0
  8)    11128     224   sched_tick+0xf0/0x2c0
        [...]
 13)    10168     176   timer_interrupt+0x78/0xc0
 14)     9992     384   tl0_irq14+0x14/0x20
 15)     9608     144   console_flush_one_record+0x2c4/0x4a0
        [...]
 21)     8424     176   _dev_info+0x38/0x48
 22)     8248     208   hub_probe+0xe8/0x92c
        [23-49: usb_probe_interface -> device_add ->
         usb_set_configuration -> usb_new_device ->
         register_root_hub -> usb_add_hcd -> ohci_pci_probe,
         all frames 176-336 bytes]
 50)     2968     176   pci_device_probe+0x7c/0x120
        [51-64: driver core / initcall, 176-240 bytes each]
 65)      400     400   0x0
                        (66 entries total; full trace on request)

Re-running enumeration alone (zero stack_max_size, unbind/rebind the
hcd PCI functions) reached 12168 bytes over 60 frames, same shape.

So the margin is compositional: the USB probe path alone is ~9.6K, a
printk with console flush adds ~1K, and one timer interrupt whose
tick does load balancing and IPI delivery adds ~2.6K. Note the timer
interrupt runs on the task stack, not the hardirq stack. The 3.7K
that remains is ~20 more minimum frames; a deeper USB topology or a
storage stack under the console plausibly closes that gap on the
machines that panic.

It also explains why Tony's backtrace looked shallow: sparc still
keeps thread_info at the bottom of the kernel stack, so marginal
overflow corrupts it first and CONFIG_SCHED_STACK_END_CHECK fires
later from inside __schedule, after the deep path has unwound. The
posted trace shows the detection point, not the overflow path.

Caveat: the tracer samples at function entry and adds its own ~208
byte frame, so the real worst case is somewhat higher than measured;
this box did not panic. The data says 16K is structurally tight on
sparc64 - ordinary boot uses 77% of it on a minimal USB topology -
not that it always overflows.

So I think the direction of the patch is right, but the diff should
be minimal: thread_info_64.h is only compiled on sparc64, so the
CONFIG_SPARC64 / PAGE_SHIFT == 13 / fallback chain is mostly dead
code. All that is needed is

	#define THREAD_SIZE (4 * PAGE_SIZE)
	#define THREAD_SHIFT (PAGE_SHIFT + 2)
	#define THREAD_SIZE_ORDER 2

at the cost of kernel stacks becoming order-2 allocations (no
VMAP_STACK on sparc64).

Since this has been sitting since May, I've respun it with the
reduced diff and the measurements in the changelog, keeping Tony as
author - v2 follows. Tested on the T4-1: the boot high-water mark is
12616 bytes on both kernels (the worst path is deterministic), i.e.
77% of a 16K stack vs 38% of 32K.

Stian
