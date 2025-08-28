Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EB23D2BF;
	Thu, 28 Aug 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395501; cv=none; b=ZEnc6bpGLzAs57Gqtevvs/HE0//Qo9C6mCEHE1o5g/2xjoTrOybox7OU+8j0WUDf6ObsMIyzZuv3bjvnY35uRMK43JyTZsPN34H6+2jE35Ii8AArmq3UOdMNOlm3P8YI4jnoqh/HuFtPK2AaNpKA3XuPCjncNi2kO2YNOAjE1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395501; c=relaxed/simple;
	bh=Mf1tiJipuT6EO/CS4NC8pbz4TXADAhbvZS0YCkyKzbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov7mVriuroTBHF1TGclN8DhzlwnJgxmR8hAZ/wVUC36lQYmuf/PUOC9DgdBEuv5I4CcPWvT4C+qItbJtkbFXPAtWAhC9XgLiMJggBB7AOMq44IggF4hGH73q4TldhiSjZd1fytezUyAy1X8hjdbA3++aXkO7fvgXaoIykhT4BYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=MpRQhvLk reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="MpRQhvLk"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cCQXK44vKz1FXjL;
	Thu, 28 Aug 2025 17:38:09 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cCQXK0svVz1DDXR;
	Thu, 28 Aug 2025 17:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756395489;
	bh=CWWK91jKJX6Iy6PocTyYQnHzi20V4KnM1BCF1VqMhio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MpRQhvLki8P3TneCR8+t59SHNwlbhjc0BIx8A5DuHvgO5WnGwMnHTs6V3ldMG5A7E
	 nQCLwCf3la7qvb9uf7b8IuU5k0SbhbQYhF7fi7otUTdadqRWwoo5pSNnYgu9+kiz1H
	 BhiKPJu8nmuVHuwXqyN155Khi5eNKWnDm/Vr89r56cphWwyHUwgxIS8g2kluVp6wK3
	 5RB7qou6AG2mTUlFpH4UYTyvOPQaWgOnJmNYkIc482FJsxwN9MQGIQ61vY7MOzmwzv
	 vdMPteigiNEmOebJhz9H4gt3HeolAM0/rd1pBA21bB6qnFyP3cmXPsj5ImiKsInCaL
	 ueOknoY0pS11w==
Message-ID: <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
Date: Thu, 28 Aug 2025 17:38:08 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-08-26 07:56, Thomas Weißschuh wrote:
> Hi Andreas,
> 
> thaks for testing!
> 
> On Mon, Aug 25, 2025 at 05:55:20PM +0200, Andreas Larsson wrote:
>> On 2025-08-15 12:41, Thomas Weißschuh wrote:
>>> The generic vDSO provides a lot common functionality shared between
>>> different architectures. SPARC is the last architecture not using it,
>>> preventing some necessary code cleanup.
>>>
>>> Make use of the generic infrastructure.
>>>
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> ---
>>>  arch/sparc/Kconfig                         |   4 +-
>>>  arch/sparc/include/asm/clocksource.h       |   9 --
>>>  arch/sparc/include/asm/vdso/clocksource.h  |  10 ++
>>>  arch/sparc/include/asm/vdso/gettimeofday.h |  58 ++++++++--
>>>  arch/sparc/include/asm/vdso/vsyscall.h     |  10 ++
>>>  arch/sparc/include/asm/vvar.h              |  75 -------------
>>>  arch/sparc/kernel/Makefile                 |   1 -
>>>  arch/sparc/kernel/time_64.c                |   6 +-
>>>  arch/sparc/kernel/vdso.c                   |  69 ------------
>>>  arch/sparc/vdso/Makefile                   |   6 +-
>>>  arch/sparc/vdso/vclock_gettime.c           | 169 ++++-------------------------
>>>  arch/sparc/vdso/vdso-layout.lds.S          |   7 +-
>>>  arch/sparc/vdso/vma.c                      |  70 +++---------
>>>  13 files changed, 119 insertions(+), 375 deletions(-)
>>
>> With the first seven patches (applied on v6.17-rc1) I don't run into any
>> problems, but from this patch (and onwards) things do not work properly.
>> With patches 1-8 applied, Debian running on a sun4v (in a Solaris LDOM)
>> stops being able to mount the root filesystem with the patches applied
>> up to and including this patch.
> 
> Could you give me the kernel log of the failures? 

Not sure if fuller logs would help, but with the 8 first patches applied
I get this behaviour when the kernel is trying to run /init:

----------------%<----------------
[    1.850062] Run /init as init process
Loading, please wait...
Starting systemd-udevd version 257.7-1
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... Begin: Waiting for suspend/resume device ... Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
[    5.386073] sched: DL replenish lagged too much
Begin: Running /scripts/local-block ... done.
--%<-- <25 identical lines> --%<--
Begin: Running /scripts/local-block ... done.
done.
Gave up waiting for suspend/resume device
done.
Begin: Waiting for root file system ... Begin: Running /scripts/local-block ... done.
done.
Gave up waiting for root file system device.  Common problems:
 - Boot args (cat /proc/cmdline)
   - Check rootdelay= (did the system wait long enough?)
 - Missing modules (cat /proc/modules; ls /dev)
ALERT!  UUID=2351ccc2-3dbd-4de6-9221-255a8e1fb132 does not exist.  Dropping to a shell!
----------------%<----------------

and with all of them applied I got: 

----------------%<----------------
[    1.849344] Run /init as init process
[    1.851309] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.851339] CPU: 4 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1+ #3 VOLUNTARY
[    1.851363] Call Trace:
[    1.851374] [<0000000000436524>] dump_stack+0x8/0x18
[    1.851400] [<00000000004291f4>] vpanic+0xdc/0x320
[    1.851420] [<000000000042945c>] panic+0x24/0x30
[    1.851437] [<00000000004844a4>] do_exit+0xac4/0xae0
[    1.851458] [<0000000000484684>] do_group_exit+0x24/0xa0
[    1.851476] [<0000000000494c60>] get_signal+0x900/0x940
[    1.851495] [<000000000043ecb8>] do_notify_resume+0xf8/0x600
[    1.851514] [<0000000000404b48>] __handle_signal+0xc/0x30
[    1.852291] Press Stop-A (L1-A) from sun keyboard or send break
[    1.852291] twice on console to return to the boot prom
[    1.852310] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
----------------%<----------------

but given that I don't have the kernel anymore I'm starting to
question myself if that run was really with the same base
commit. I'll do a rebuild and see.

> Is there any chance to get access to the machine? 

Such access is not mine to give I'm afraid.

> Can you reproduce this issue on sun4u? sun4v in QEMU is
> "work in progress" and instantly crashes for me. 

My current vDSO testing kernels aiming for this Debian setup are not
playing well with QEMU right now. I have to look into this.

> Can you provide me your Debian image?

What do you mean with image here? Disk image? Kernel image? This is a 25
GiB installation.

> 
>> As an aside, with all patches applied, it panics when the kernel
>> attempts to kill init.
> 
> It is suprising that the error changes between patches.
> The later patches don't change any lowlevel stuff, so if rootfs mounting
> was broken earlier I don't see how it could go on to start init later.
> Are these results repeatable?

The one with 8 patches is reliably repeatable. The one with all patches
seems to have been purged for space reasons, but I saw the same problem
multiple/all times as far as I remember. In any case, at least 7 patches
works reliably every time when 8 patches fails in the same way every
time.


Cheers,
Andreas
