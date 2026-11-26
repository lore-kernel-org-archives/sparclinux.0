Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686087;
	b=Ig4rwtyexdyne9xxrYSyrUyJPNSKN8EgSKVTrSeixMPK5oWm8MJsmDEQ/8LrXzhYxItJ
	 PqhsZdsu8ZRtqfsc71VBUlUgA+QCFZvOI10qOBVrJ1BF1cn1XGlhCNrcJXN3Ol1rq3FEv
	 BPSFljUHAQ6sSjrtVR4fLaZ9Oiw1rTzszxMcA4J1FRYu0UXYhlmHHVpepfSdV0/iQAVVY
	 jOD4jPT0QuIedLfx7zZAA1uLnA8iCBRLmtn6z8SiLQoog+I2acgCe6v9M1ojwfIEYR45i
	 sp7C2yA5QHsFGkmvnBBAEJtooSVAA42fH6Cph2pdNmMp4n3OWNgo8yI0qyoL0l1PAWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686087;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uKEu8rBHFm8Xin6IAqpGEUcROLNEf/CC5kpPw3+Yfv0=;
	b=m0bV716fApmoH89JgUEyrePJ/Q2NYNzfXDvXeXy7GJKp+JUBjHMUVX7vwDQQZotv99Jl
	 122oGnf2DgY2bf/TU5fEe9renpzoHR7/pwqjM3l4PtENemvZBxc3tg1ZhmC6GEJKVB0R7
	 BXMuvxgYEjfw80Soni8Ir/ZuK9yMwdnaEOkz6I967Gpi+2fLpGKNQfQzHrHVL8EgD2p/f
	 QdAujwSEjUubupV7cLJEVCcL06zx707t2WeIBYERaWDB/BteA5xUC5l3YS8So7unx6bcs
	 1RMVwIxKhTihSW+Vl7gZyGX2minb7bOkLwG6BLuyS70edZEsANssWjcRTBiA4dqzicA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZF2JbxnD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907A606A31C
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZF2JbxnD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC00F1F000C6;
	Thu, 26 Nov 2026 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795686086;
	bh=uKEu8rBHFm8Xin6IAqpGEUcROLNEf/CC5kpPw3+Yfv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZF2JbxnDjfTg/vleJYq7LEkvZLhOK/zyv8gitaqLCf0RL+IaDk/8KDA2Jeu/Wp5U1
	 iYIPBHe7LRMVlWIVhgOs9YN3e2v2SO5HfcbWVCmWqOU7Lj/YcBnOX8cFxdZ2m6hIvC
	 7REkM/KIa7QjjKZK6kFRCnm7Z4fwZM/CE31pAWwnpEMNoNo6xiRyCH4ZAagRrstHxV
	 mmEMf5rJmcwFkPuGW/mh2TxgX6lkmot4igxyCSYLitUnZkzZcZm4kspre1FkxoIUpg
	 Aobq75vEoF/7yH1lrN7X8F51o5YRzj6u5+1LBwsYRxgUGHvV29BMqirg9NyGhDl2rO
	 HXoAjRbx67NDw==
Message-ID: <sashiko-outbox-235154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/18] sparc32,leon: retain SMP TLB shootdowns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261126093106.1345825-3-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
 <20261126093106.1345825-3-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:41:26 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] sparc32: missing preemption disable in smp_flush_tlb_mm() [1]
--

commit 20d5675eb7a3d5e5a3910745d8ae9ac1da8711f2
Author: Magnus Lindholm <linmag7@gmail.com>

sparc32,leon: retain SMP TLB shootdowns

This commit retains the SMP TLB flush wrappers on LEON instead of replacing
them with local operations, and updates leon_switch_mm() to invoke
leon_flush_tlb_all() directly for local context switches.

> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 145a63a5fda91..fb95865d7ddd5 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -1746,7 +1746,8 @@ void __init load_mmu(void)
>  	/* El switcheroo... */
>  	local_ops =3D sparc32_cachetlb_ops;
> =20
> -	if (sparc_cpu_model =3D=3D sun4d || sparc_cpu_model =3D=3D sparc_leon) {
> +	/* sun4d supplies its own SMP TLB operations. */
> +	if (sparc_cpu_model =3D=3D sun4d) {
>  		smp_cachetlb_ops.tlb_all =3D local_ops->tlb_all;
>  		smp_cachetlb_ops.tlb_mm =3D local_ops->tlb_mm;
>  		smp_cachetlb_ops.tlb_range =3D local_ops->tlb_range;

[Severity: High]
This problem wasn't introduced by this patch, but can smp_flush_tlb_mm()
leave stale TLB entries on the original CPU if the caller is preempted and
migrated mid-flush [1]?

With LEON now using smp_cachetlb_ops.tlb_mm, flush_tlb_mm() calls
smp_flush_tlb_mm(), which runs without disabling preemption when invoked
from preemptible context (such as fork() -> dup_mmap() -> flush_tlb_mm()):

arch/sparc/mm/srmmu.c:any_other_mm_cpus() {
	return cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids;
}
...
arch/sparc/mm/srmmu.c:smp_flush_tlb_mm() {
	if (mm->context !=3D NO_CONTEXT) {
		if (any_other_mm_cpus(mm))
			xc1(local_ops->tlb_mm, (unsigned long)mm);
		local_ops->tlb_mm(mm);
	}
}

Aside from calling smp_processor_id() in preemptible context (which warns
under CONFIG_DEBUG_PREEMPT), the cross-call excludes the initiating CPU and
re-enables preemption before local_ops->tlb_mm() runs:

CPU0                                  CPU1
smp_flush_tlb_mm(mm)
  xc1(local_ops->tlb_mm, ...)
    sun4m_cross_call(...)
      cpumask_clear_cpu(0, &mask)
      ...
      spin_unlock_irqrestore(...)
  [migrated to CPU1]
                                      local_ops->tlb_mm(mm)  <-- CPU0 missed

CPU1 is flushed twice while CPU0's TLB is never flushed, which can cause
memory corruption after page table updates.

[1] https://sashiko.dev/#/bug/linux-faa0e34b-f932-4bee-ba78-e5a71fbc6fe8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093106.1345=
825-1-linmag7@gmail.com?part=3D2
