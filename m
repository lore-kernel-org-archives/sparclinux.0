Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015083093C8;
	Fri, 29 Aug 2025 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463876; cv=none; b=KPHCtCGdQobJcDwn6ICWG9YUfZ0c33isC9i6rcAbVbeY6qEeNxC11Ks4+D3csJMhFoEmoAKNZxG/xvyCkKs9kL5kuZY2YMx3MUz/RyTa9p8nl+IgwK/3dwqwaVvz8fZVgXTJUJUwNzsIXms5TTMSdmhqobmfW2Vqel0kB8lo2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463876; c=relaxed/simple;
	bh=Q4FUm/PzMw/TJ31ECTdy78HGTpa2Cyqr0P038t5KdsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQBjNAyYqhgfVqDXgo5Qsnsoemqxt1Ipzfgc6W4bFaHkyiZdm+DJo1kNB3mbkZzuN2N7K+skhn1OyqEDELNJIb4POVtW93LJ7dpQerWiniCFI/KSoyjOQfTuientQTUne2ameQZ1qaTwAZ8StmzCVQjgH9Em/HmhLgGO6z7wiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=egdlJiWw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hXeI30d4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="egdlJiWw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hXeI30d4"
Date: Fri, 29 Aug 2025 12:37:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756463872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbb6A2w2Zs4e0LhdnCErl9QftppmHWuqEaIPu0+jqj4=;
	b=egdlJiWwR7IhA032o0tiJCBngN31azb1EnyFCEs+BQxksmYe3Jew8QJlcz5Gj/0K8egoQe
	fN2eZ86ZYVLA2EY7E1NIj1SO8VWotxpWaNpOSZnIQihe3dbemmvxN5wxMI1t2+nZ3uyic/
	9NOjeZl7enVkt8qebh60APcsoAFiKDCpjJ4xQzw0ilMbvx4z8H25eEPCSJunGYZu4sgnYN
	A9BcFQJ+lmLpcwiU2KVXeizso1UexABFPT5Qaj+RBXHF5TgYrDOj45PGKLFS4OKmmM5y94
	OhuVBQFfVuTSm4zQFiOGRHawGONGmRpZYcBju2BLwNhAcNk8XxSjxXUD4EOxRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756463872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbb6A2w2Zs4e0LhdnCErl9QftppmHWuqEaIPu0+jqj4=;
	b=hXeI30d4i5wtysnZSGrm+hJrMz/kjXFSGlvmgwdaUkqBIX2xJoKEhf13zuHZQS76MZlrMc
	wX7UgaeMAisl2eAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
Message-ID: <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>

On Fri, Aug 29, 2025 at 12:02:39PM +0200, Andreas Larsson wrote:
> On 2025-08-28 17:38, Andreas Larsson wrote:
> > and with all of them applied I got: 
> > 
> > ----------------%<----------------
> > [    1.849344] Run /init as init process
> > [    1.851309] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > [    1.851339] CPU: 4 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1+ #3 VOLUNTARY
> > [    1.851363] Call Trace:
> > [    1.851374] [<0000000000436524>] dump_stack+0x8/0x18
> > [    1.851400] [<00000000004291f4>] vpanic+0xdc/0x320
> > [    1.851420] [<000000000042945c>] panic+0x24/0x30
> > [    1.851437] [<00000000004844a4>] do_exit+0xac4/0xae0
> > [    1.851458] [<0000000000484684>] do_group_exit+0x24/0xa0
> > [    1.851476] [<0000000000494c60>] get_signal+0x900/0x940
> > [    1.851495] [<000000000043ecb8>] do_notify_resume+0xf8/0x600
> > [    1.851514] [<0000000000404b48>] __handle_signal+0xc/0x30
> > [    1.852291] Press Stop-A (L1-A) from sun keyboard or send break
> > [    1.852291] twice on console to return to the boot prom
> > [    1.852310] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> > ----------------%<----------------
> > 
> > but given that I don't have the kernel anymore I'm starting to
> > question myself if that run was really with the same base
> > commit. I'll do a rebuild and see.
> 
> I found out that my previous kernel installation for the kernel with the first 8
> patches was a broken mess. Sorry about the confusion. With that sorted out and a
> rebuilt kernel with all patches, the failure above is the one I get for both 8
> and 13 patches, and it is repeatable.

This splat means that init got killed by SIGSEGV, so that makes some sense in
the context of the code being touched. Then let's focus on patch 8 for now.

In the meantime I installed a full Debian, but the bug is still not
reproducible in QEMU.

* Did you use the SMP or UP kernel config from Debian?
* Can the fixed up kernel now run on QEMU?
* Which toolchain are you using?
* This is a 64-bit userland?

What difference does the following change make:

diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 38a664d69782..efc3fef8f9bc 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -25,7 +25,7 @@
 #include <vdso/datapage.h>
 #include <asm/vdso/vsyscall.h>
 
-unsigned int __read_mostly vdso_enabled = 1;
+unsigned int __read_mostly vdso_enabled = 0;
 
 #ifdef CONFIG_SPARC64
 static struct vm_special_mapping vdso_mapping64 = {


Or this one, independently from the one above:


diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
index f3caa29a331c..a4669f7feada 100644
--- a/arch/sparc/vdso/vdso.lds.S
+++ b/arch/sparc/vdso/vdso.lds.S
@@ -16,10 +16,7 @@
 VERSION {
        LINUX_2.6 {
        global:
-               clock_gettime;
-               __vdso_clock_gettime;
-               gettimeofday;
-               __vdso_gettimeofday;
+               __nothing;
        local: *;
        };
 }


Or this one, independently from the ones above:

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 02ea19f67164..ae87888fef8a 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -318,6 +318,8 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
        const struct vdso_clock *vc = vd->clock_data;
        u32 msk;
 
+       return false;
+
        if (!vdso_clockid_valid(clock))
                return false;
