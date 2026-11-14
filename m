Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657205;
	b=BvkKyNnB5xVNfD964oCDwqE4Sph/RD1k9F1oAX/FdCfEDx+9xRuCCgiWy5dEKNjqsgdA
	 +wGlkvgvV21FC79e8mRqPVjuttV2Hvgw1akHScNvvqtSOUXPqnHyuGYsbKPK/xoVy3g0m
	 Rt7QIwCDgwOqpvR6wamBccIy1Te91OqIA0jMPYk6dn0cDbiRTFU7vFZSTnfBSL8sR3m0m
	 mfKwGZqskZKw1+7Vg61q5BtoOaFfDp8zHRtSn0BaQTb8kVoVRzmDjq7Al/7i9qBv17R0w
	 65WKGxCsnwwfG1EKyVfmfE4sRxLM/oYKKRxQomiD/1LSlFitRzpZew7DX5gKb4la8Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UHmecFZqwrRCDn8YnJiwPqnBfBvX41ZxZ7DwvgiUHrU=;
	b=wfnfXlANhwO4d0pFBXhKsp1EXT/4ZjWMrVQPAQsCmOOGqCG3cuagC7mKkTMcCXfiMRXg
	 YSGID2bKmbtKfDMbXmc9k9JbCP9lh4sA0xrCk+MhtYurUC8kCmm0ZPNdZumxCOpJWWhIP
	 qX1QiPmcQcy2FA7DgBsNihbQGdZTZrXHinRYgS5kmkK9JuVt7H1/NZdfURONWXtHw1tnZ
	 6REBbNIpj9ejdvP29A5iSsWzUkc8R2Io85e9rqCu1mm/7cOT9UYg0Y73WXUezLHfEUfrQ
	 0odthKng/4Y0PsorGeQuH7sQeoKp8MpYEcCKIAVQYe1QHNNw4t1Lg/MP+AayYFVsYVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+dVNbwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03552606A880;
	Sat, 14 Nov 2026 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+dVNbwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4481F000CD;
	Sat, 14 Nov 2026 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794657204;
	bh=UHmecFZqwrRCDn8YnJiwPqnBfBvX41ZxZ7DwvgiUHrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+dVNbwk0uX76HZMRcvgKHV0wWVIh15XIIf+4t4SDKup6nMl6XpJGv8SdxhOTXkVb
	 VRf+vbQ7NM7zMfCDclmnYAagli4wjQXlSMvUCzn++kZ7YcBFGDdo/A9+Rpzt+0x7ND
	 jDwq21WUnDPr5J4QLUc/a98qbRxmZu7MZ85terUXoA4PwoxRH2OjlOC4j7ARZn7L0d
	 +3N7+DRugwJ1YWgNjvpyGJGI1UjZAJxNlBDl6WEYgdysiwr8g6SO5F9wpa9vaK88bL
	 eVWyN3tOufSkQcD6eDZuOM5AvIE4fjSanK4mdmCDP5VE6otR6BbChMUhEGFq6txwl9
	 c+icJBOQ2sHMQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Naveen N Rao <naveen@kernel.org>, Danish Khateeb <danishkhateeb03@gmail.com>, sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] sparc64: kprobes: Single-step from an executable instruction slot
Date: Sat, 14 Nov 2026 20:53:21 +0900
Message-ID: <undine-1794657201253656548-9ae005d7b6d5e024@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261113144057.1697874-2-stian@itx.no>
References: <20261113144057.1697874-1-stian@itx.no> <20261113144057.1697874-2-stian@itx.no>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Nov 2026 15:40:54 +0100, Stian Halseth <stian@itx.no> wrote:
> kprobes single-steps the probed instruction from kprobe->ainsn.insn[].
> The array is embedded in struct kprobe, in the linear mapping. The
> sun4v linear mapping is not executable. Every probe hit oopses:
> 
>   sun4v_insn_access_exception: ADDR[fff800005b0cd66c] CTX[0000] TYPE[0006], going.
> 
> Allocate the copy with get_insn_slot(), as other architectures do. The
> slot comes from executable memory in the module area.
> 
> flush_insn_slot() flushed the embedded copy after init_aggr_kprobe()
> had copied it into the aggregator. The aggregator now shares the slot
> by pointer. arch_prepare_kprobe() flushes the slot when it writes it.
> Make the macro a no-op, like x86 and arm64.
> 
> Fixes: c4bce90ea2069 ("[SPARC64]: Deal with PTE layout differences in SUN4V.")
> Closes: https://github.com/sparclinux/issues/issues/110
> Signed-off-by: Stian Halseth <stian@itx.no>

Looks good to me from kprobe point of view.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  arch/sparc/include/asm/kprobes.h | 12 ++++++------
>  arch/sparc/kernel/kprobes.c      | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
> index aec742cd898f2..d14206c063e25 100644
> --- a/arch/sparc/include/asm/kprobes.h
> +++ b/arch/sparc/include/asm/kprobes.h
> @@ -11,25 +11,25 @@
>  #include <linux/types.h>
>  #include <linux/percpu.h>
>  
> +#define __ARCH_WANT_KPROBES_INSN_SLOT
> +
>  typedef u32 kprobe_opcode_t;
>  
>  #define MAX_INSN_SIZE 2
>  
>  #define kretprobe_blacklist_size 0
>  
> -#define arch_remove_kprobe(p)	do {} while (0)
> +struct kprobe;
> +void arch_remove_kprobe(struct kprobe *p);
>  
> -#define flush_insn_slot(p)		\
> -do { 	flushi(&(p)->ainsn.insn[0]);	\
> -	flushi(&(p)->ainsn.insn[1]);	\
> -} while (0)
> +#define flush_insn_slot(p)	do { } while (0)
>  
>  void __kretprobe_trampoline(void);
>  
>  /* Architecture specific copy of original instruction*/
>  struct arch_specific_insn {
>  	/* copy of the original instruction */
> -	kprobe_opcode_t insn[MAX_INSN_SIZE];
> +	kprobe_opcode_t *insn;
>  };
>  
>  struct prev_kprobe {
> diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
> index 191bbaca99212..608efda8cb948 100644
> --- a/arch/sparc/kernel/kprobes.c
> +++ b/arch/sparc/kernel/kprobes.c
> @@ -52,6 +52,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	if ((unsigned long) p->addr & 0x3UL)
>  		return -EILSEQ;
>  
> +	p->ainsn.insn = get_insn_slot();
> +	if (!p->ainsn.insn)
> +		return -ENOMEM;
> +
>  	p->ainsn.insn[0] = *p->addr;
>  	flushi(&p->ainsn.insn[0]);
>  
> @@ -62,6 +66,14 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	return 0;
>  }
>  
> +void __kprobes arch_remove_kprobe(struct kprobe *p)
> +{
> +	if (p->ainsn.insn) {
> +		free_insn_slot(p->ainsn.insn, 0);
> +		p->ainsn.insn = NULL;
> +	}
> +}
> +
>  void __kprobes arch_arm_kprobe(struct kprobe *p)
>  {
>  	*p->addr = BREAKPOINT_INSTRUCTION;
> -- 
> 2.43.0
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
