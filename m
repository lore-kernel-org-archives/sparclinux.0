Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105331B11B;
	Fri, 29 Aug 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756474889; cv=none; b=bH7RQA6aRDGOff0hvJ3nhfMddm29xbFhV7uPL+GgI7UWU6vDzAjUp34DenZlXDZL+NYlvYNS9MkrSK6g9UybVR7NDP6hWMsq+knW9lMzUBQuZrbr7OqdCvf1QXMU+eS7b18M4EIOrQv5yORF1DLTZmGg0l0TRUtDBYsRwmjgny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756474889; c=relaxed/simple;
	bh=xOH5swkXMG4oVhf3wy0TtaxnLVmSKuiuHKFiiJUgQJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsrkgADe8qmVt7YIWZnah7oYdsO1ztXIAq4FfPZn/a5HxL/RM32miHaPAWAban0cYp+9+ixWbT/maI7ABZE4Ihg7aipTb7ejzOIWb8OoZnaBehPD7Lzj7WG4HIYi7wq3mqwYzKtdK4ABPyVeGIbUabU2WorgzkjhTnhLmOJPzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=aCoNyRQe reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="aCoNyRQe"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cCzv75F21z1FbZj;
	Fri, 29 Aug 2025 15:41:23 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cCzv71pH6z1DQqY;
	Fri, 29 Aug 2025 15:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756474883;
	bh=fIFEKQbPdTMh3etZAT4QAh46FySYcbDnTI/Lzh3ryaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aCoNyRQezF2yHZQXkhEJtvc+VPf9O+ObEy5oPDP3/kmTkshaKYkGlyFRALKRlnBj1
	 n34rw3S41VVCkY/gmozexvqzxTE8V+mJqQmpNN1HVlL0ED6cvcEfnytdyLoKGGrRJd
	 NYTIuLqH9rOAw+O/munB7/ziwfIujYRzo0iN+izeSQ6bmVevdgbr/LBzo4865PdLZH
	 t4O0fUtIQK3GYPftks8fNuzq1BQRhPRk36dKkkx5saSRdU+C587cmtLfrtHhiHFtLT
	 RBDPBomJQqg3WXxwp0beugbeDeEk33g4ShIdIPriQ81yrzTFLc4kxgm/Fm1LLyssmF
	 +1Qu3SJzYDhFQ==
Message-ID: <7b699dde-2dde-4900-abd6-d902b4cff853@gaisler.com>
Date: Fri, 29 Aug 2025 15:41:22 +0200
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
 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-08-29 12:37, Thomas Weißschuh wrote:
> On Fri, Aug 29, 2025 at 12:02:39PM +0200, Andreas Larsson wrote:
>> On 2025-08-28 17:38, Andreas Larsson wrote:
>>> and with all of them applied I got: 
>>>
>>> ----------------%<----------------
>>> [    1.849344] Run /init as init process
>>> [    1.851309] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>>> [    1.851339] CPU: 4 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1+ #3 VOLUNTARY
>>> [    1.851363] Call Trace:
>>> [    1.851374] [<0000000000436524>] dump_stack+0x8/0x18
>>> [    1.851400] [<00000000004291f4>] vpanic+0xdc/0x320
>>> [    1.851420] [<000000000042945c>] panic+0x24/0x30
>>> [    1.851437] [<00000000004844a4>] do_exit+0xac4/0xae0
>>> [    1.851458] [<0000000000484684>] do_group_exit+0x24/0xa0
>>> [    1.851476] [<0000000000494c60>] get_signal+0x900/0x940
>>> [    1.851495] [<000000000043ecb8>] do_notify_resume+0xf8/0x600
>>> [    1.851514] [<0000000000404b48>] __handle_signal+0xc/0x30
>>> [    1.852291] Press Stop-A (L1-A) from sun keyboard or send break
>>> [    1.852291] twice on console to return to the boot prom
>>> [    1.852310] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>>> ----------------%<----------------
>>>
>>> but given that I don't have the kernel anymore I'm starting to
>>> question myself if that run was really with the same base
>>> commit. I'll do a rebuild and see.
>>
>> I found out that my previous kernel installation for the kernel with the first 8
>> patches was a broken mess. Sorry about the confusion. With that sorted out and a
>> rebuilt kernel with all patches, the failure above is the one I get for both 8
>> and 13 patches, and it is repeatable.
> 
> This splat means that init got killed by SIGSEGV, so that makes some sense in
> the context of the code being touched. Then let's focus on patch 8 for now.
> 
> In the meantime I installed a full Debian, but the bug is still not
> reproducible in QEMU.
> 
> * Did you use the SMP or UP kernel config from Debian?

I based my config on the SMP config that was in use on the system.
Produces an tremendous amount of modules unfortunately, so I'll have
to cut down in the config. Right now the turnaround time for testing
a new kernel with this setup for this system is quite bad.

> * Can the fixed up kernel now run on QEMU?

No, there is something else going on with my QEMU setup, unrelated to
these patches.


> * Which toolchain are you using?

A toolchain built in Buildroot with GCC 13.2.0. Old kernel headers, but
I only use it to build kernels. Do you think the kernel headers of the
toolchain would play a role for vDSO?


> * This is a 64-bit userland?

Yes.

> 
> What difference does the following change make:
> 
> diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
> index 38a664d69782..efc3fef8f9bc 100644
> --- a/arch/sparc/vdso/vma.c
> +++ b/arch/sparc/vdso/vma.c
> @@ -25,7 +25,7 @@
>  #include <vdso/datapage.h>
>  #include <asm/vdso/vsyscall.h>
>  
> -unsigned int __read_mostly vdso_enabled = 1;
> +unsigned int __read_mostly vdso_enabled = 0;
>  
>  #ifdef CONFIG_SPARC64
>  static struct vm_special_mapping vdso_mapping64 = {
> 
> 
> Or this one, independently from the one above:
> 
> 
> diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
> index f3caa29a331c..a4669f7feada 100644
> --- a/arch/sparc/vdso/vdso.lds.S
> +++ b/arch/sparc/vdso/vdso.lds.S
> @@ -16,10 +16,7 @@
>  VERSION {
>         LINUX_2.6 {
>         global:
> -               clock_gettime;
> -               __vdso_clock_gettime;
> -               gettimeofday;
> -               __vdso_gettimeofday;
> +               __nothing;
>         local: *;
>         };
>  }
> 
> 
> Or this one, independently from the ones above:
> 
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 02ea19f67164..ae87888fef8a 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -318,6 +318,8 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
>         const struct vdso_clock *vc = vd->clock_data;
>         u32 msk;
>  
> +       return false;
> +
>         if (!vdso_clockid_valid(clock))
>                 return false;
> 

I will check.

Cheers,
Andreas

