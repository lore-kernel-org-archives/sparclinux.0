Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC222BE629;
	Mon, 26 Jan 2026 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447040; cv=none; b=DMkKAG6QV2dMXObRTsQ8Df018AaqpvQc0chGxp/DxbBAGW90Kq9FplxzSGOYesI0V3MifUziuCEaob95iJlMAjBK5kHuP7fsgUXOp61Ime2dn8jaF2e8KvB9p2dqscRdo9rdI6s8CfIntrks4B+X7IWWWOJEQYjQRiC4cmtNdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447040; c=relaxed/simple;
	bh=rfI6hpzrGRCqkkT2mF0M3kbE5FgHpXVH+zCNxYlr0Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POvQYSt1a2kX1onxt/nkrwoG+acB4E+PS6xJOir+lAoZlWUGSw/zlk3/tSRKTVILIdJhMaRMjKZeIbm6Ty6eE46GNeAjqiQLoYQlpx6JMECxNBY5vBPpU/6h5Wk7IEHtVgDCAbyxiFVuJWJiV/5nU1WNd2tLcNAK/jyOTwek1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=bkuzemEa reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="bkuzemEa"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0FHb73N3z1DHpY;
	Mon, 26 Jan 2026 18:03:55 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0FHb3pqLz1DHpQ;
	Mon, 26 Jan 2026 18:03:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769447035;
	bh=Hz+LSEXGtXzDLE1kBorKh/TJk2CnKoMV21Q1s/R1nSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bkuzemEaCLRq486yTzfdZaDmFK4p6ZcNOjs8btprxGQWGtMESdfCESCXQm9KFPKnh
	 s5+JQ/tkRPA+xxnBR9zMuRSgSu8XtKBE/8IUOC9ZvTVttbZAaLriRm9EzAkydbKV4b
	 ukX/EKFNDQ3rq1oHds+r/td828YX+Gt907Y8YNVoPFNFAVF0RRshsgZnj/3dN3nshY
	 XlrlE7RoPzsjcLoOOBtzplNDmnc1jbz/qAxgELTt0iUxpA1JW+5R6GpsJeKwc5gw74
	 CK/5VnftE0Ocxd90459Qs8tr9C6gvhiLyNNnjx9yAm4VI+zhhpy3b+bEYh15PB425f
	 vquSC8lKiIz7w==
Message-ID: <631bd2ec-9a64-42f0-bd6e-faf9f36e83dd@gaisler.com>
Date: Mon, 26 Jan 2026 18:03:55 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] sparc: Add architecture support for clone3
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net,
 brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, glaubitz@physik.fu-berlin.de,
 geert@linux-m68k.org, schuster.simon@siemens-energy.com, jrtc27@jrtc27.com
References: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-19 15:47, Ludwig Rydberg wrote:
> Hi all,
> 
> This series adds support for the clone3 system call to the SPARC{32|64}
> architectures and also adds a related patch for clone/fork/vfork that fix an
> issue previously reported[1] that could result in -EFAULT for no good reason.
> Without this patch, the clone3 system call would need the same mitigation as
> introduced in glibc[2] for the clone system call.
> 
> About "sparc: Synchronize user stack on fork and clone"
> ---------------------------------------------------------
> 
> The clone3 implementation is developed on top of a fix for an issue reported
> by Adrian Glaubitz[1], where a clone call could return -EFAULT. This problem
> has since been mitigated in glibc[2] by synchronizing the user stack before
> calling clone.
> 
> The root cause analysis of the kernel side when running the program in [1]
> shows that the window spill handler routine on both SPARC{32|64} is unable to
> flush a user window to the stack (due to MMU related faults) when flushing all
> windows before handling the syscall. This then results in a -EFAULT when
> copy_thread() fails to clone the uncommitted stackframe of the parent.
> 
> For SPARC32:
> Prior to calling the syscall wrappers for clone/fork/vork all windows are
> flushed by a macro (FLUSH_ALL_KERNEL_WINDOWS).
> In the window spill trap handler, MMU fault-handling is temporarily
> disabled while storing the window. If the window can't be stored
> (which normally would have triggered a fault trap) the routine
> backups the user window and increments a thread counter (wsaved).
> 
> For SPARC64:
> Prior to calling the syscall wrappers for clone/fork/vork all windows are
> flushed by issuing the flushw instruction.
> In the window spill trap handler, if an exception triggers, then the user
> window is added to the thread's user window buffer (in kernel memory) and
> a thread counter (wsaved) counter is incremented.
> 
> Both SPARC{32|64}:
> Eventually copy_thread will be called, which then will fail to clone the parent
> stackframe to the child as the user window has not been flushed to the stack.
> 
> Fixed by adding a call to synchronize_user_stack() prior to calling
> kernel_clone(). The patch has been tested both with and without the mitigation
> in glibc by running the program mentioned in [1].
> 
> SPARC32:
> - Tested in QEMU emulating sun4m using Buildroot 2025.02
>   (qemu_sparc_ss10_defconfig).
> - Tested on LEON using a GR-CPCI-GR740 development board from
>   Frontgrade Gaisler.
> 
> SPARC64:
> - Tested in QEMU emulating sun4u using Buildroot 2025.02
>   (qemu_sparc64_sun4u_defconfig).
> 
> About the clone3 implementation:
> --------------------------------
> 
> The implementation in the architectural port follows the same pattern as for the
> original clone syscall. But instead of explicitly calling kernel_clone (as in
> sparc_clone) the clone3 handler calls the generic sys_clone3 handler
> (in kernel/fork). To get this to work without a user provided stack,
> the copy_thread functions had to be updated to handle cl_args.stack == NULL.
> In this case the stack of the parent is re-used.
> 
> The return value convention for clone3 follows the regular kernel return
> value convention (in contrast to the original clone/fork on SPARC).
> 
> In sparc_{clone|vfork|fork} there is a workaround due to the SunOS
> return value convention which is not needed for clone3.
> 
> When applying the patch series on top of v6.19-rc1 the relevant clone3 tests of
> kselftest pass:
> 
> # /usr/lib/kselftests/run_kselftest.sh -c clone3 -s
> kselftest: Running tests in clone3
> TAP version 13
> 1..4
> # selftests: clone3: clone3
> ok 1 selftests: clone3: clone3
> # selftests: clone3: clone3_clear_sighand
> ok 2 selftests: clone3: clone3_clear_sighand
> # selftests: clone3: clone3_set_tid
> ok 3 selftests: clone3: clone3_set_tid
> # selftests: clone3: clone3_cap_checkpoint_restore
> ok 4 selftests: clone3: clone3_cap_checkpoint_restore
> 
> Note that the clone3_cap_checkpoint test failed in the same way as mentioned in
> [3] (due to incompatibility with the libcap version on my system).
> When applying the patch from [4] or by downgrading libcap to 2.59 the test pass.
> 
> SPARC32:
> - Tested in QEMU emulating sun4m using Buildroot 2025.02
>   (qemu_sparc_ss10_defconfig).
> - Tested on LEON using a GR-CPCI-GR740 development board from
>   Frontgrade Gaisler.
> 
> SPARC64:
> - Tested in QEMU emulating sun4u using Buildroot 2025.02
>   (qemu_sparc64_sun4u_defconfig).
> - Tested on UltraSparc T4
> 
> [1]: https://lore.kernel.org/sparclinux/3ae4130c-c5aa-428e-b819-44cf2daf2af1@mkarcher.dialup.fu-berlin.de/
> [2]: https://sourceware.org/bugzilla/show_bug.cgi?id=31394
> [3]: https://lore.kernel.org/all/20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com/
> [4]: https://lore.kernel.org/all/20241105062948.1037011-1-zhouyuhang1010@163.com/
> 
> ---
> Changes in v2:
> - Added Tested-by tag from Adrian Glaubitz
> - Implement generic Linux return value convention for clone3
> - Drop SPARC handling for sys_clone3 in selftests
> - Remove legacy ABI return value handling in sparc_clone3
> - Link to v1: https://lore.kernel.org/sparclinux/20260116153051.21678-1-ludwig.rydberg@gaisler.com/
> ---
> 
> Andreas Larsson (1):
>   sparc: Synchronize user stack on fork and clone
> 
> Ludwig Rydberg (1):
>   sparc: Add architecture support for clone3
> 
>  arch/sparc/include/asm/syscalls.h      |  1 +
>  arch/sparc/include/asm/unistd.h        |  2 -
>  arch/sparc/kernel/entry.S              | 15 ++++++++
>  arch/sparc/kernel/kernel.h             |  1 +
>  arch/sparc/kernel/process.c            | 52 +++++++++++++++++++-------
>  arch/sparc/kernel/process_32.c         | 23 +++++++++---
>  arch/sparc/kernel/process_64.c         | 27 ++++++++++---
>  arch/sparc/kernel/syscalls.S           |  8 ++++
>  arch/sparc/kernel/syscalls/syscall.tbl |  2 +-
>  9 files changed, 102 insertions(+), 29 deletions(-)
> 
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8

Picking the series up to my for-next.

Thanks,
Andreas

