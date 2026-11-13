Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562350;
	b=QscDCwemIrzo4eyBSCOYon5IeSa/CE+YEDsjWPDXdnq3od2Ex53juR+qiXDH2TJg1Hiy
	 yEnVCLuaxUgN7SSGvzrveiOiEZhxGhJEjNyiB9l8sa842H/2zx5u+TjKwg9pw7jBc+xIJ
	 XbfyVu1587d1yE2UIC6zNuMPi9bzfOlXCTNmFxcENOj/rrqLBBaAKvdyinj/n09rUNlkN
	 H0rQc4s6aNQxmq5hGG3cGNCxizTl+63np8u1xIIevdcjvc1UVLGD0liHuumT1j4H0Y5CK
	 ItdWNR5A3zagRNi5rfxDSy8InZjaNIH8ZW16J300eSjlwLPsvQwOtni9vaUYQc6mBfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fxRGQSVxjDWbhNqC1Sux7kJap9W0076rLsx1HOBC8OM=;
	b=edjnIB7tdY7oq3C1O1oO1KHgG8f33lWwYhGXARYOXRngMs2kbmInd00Lt16M7Tko4QP7
	 kfI1XsW4cW0ehq5UcLmeGSrn2Q9BRUHFqf2Bxoe0NoQQMBGhKumetGB/ixw9ZOj6KxCyT
	 0uUmIQjA06QpQ/qswdyrvvzwFHp56/v//mIyLpQKrc8gdis6Ll6xhmBkKF4orjGyIKhno
	 idH5XkfJKalcK6bHzIQUWGwCkfCucKW6dXWPQ976aoTGp682k13uyqD1xEkvx0e8P2Tbn
	 Sjjn9bnxG/5mQgrDRAnDsYJvtA0Z3C6fOIS3lYi063yv5u3YucRIoeeDDxLXoFxnl5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akWluT03;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A338606A333;
	Fri, 13 Nov 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akWluT03
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168401F000C5;
	Fri, 13 Nov 2026 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562350;
	bh=fxRGQSVxjDWbhNqC1Sux7kJap9W0076rLsx1HOBC8OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akWluT03dkeCOhkoxtzSnnwSLBvuDmX7jyIhtRIEEsd+6lYDIgmrCS7oXhGjQlDdr
	 EDH8w09E31WzVraP8z2apW2kLfQTMa/p2Byy1Vu0J2XUvppxSan0Aoupqo+YxsaAaS
	 sxL9KnNQ80eBsp9P5/jE9mBH+Gxq4DmMdnkHDWAktUeTZkTXhv8kv0eogO6sm2oGL9
	 ZwE8Hpb5zlcBboixIl8eTv9elzul1vRq3nNesBiY1AwwUdYUU0AjoiY+r5v68Isdnk
	 Fkept3jch7SL5csXNYeGA2ABvRcG4OUsCuBrP4VxMYYxPcASbXeY9k91AdDmfTrs2z
	 s70zWlrWYrOtA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Naveen N Rao <naveen@kernel.org>, sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sparc64: kprobes: Single-step from an executable instruction slot
Date: Fri, 13 Nov 2026 18:32:27 +0900
Message-ID: <undine-1794562347340141345-b03249069e19e203@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261009180336.1315684-2-stian@itx.no>
References: <20261009180336.1315684-1-stian@itx.no> <20261009180336.1315684-2-stian@itx.no>
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

Hi,

On Fri,  9 Oct 2026 20:03:32 +0200, Stian Halseth <stian@itx.no> wrote:

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

With this change, the p->ainsn.insn becomes NULL here when kill_kprobe()
calls this function because (1) init.text is removed or (2) probed module
is unloaded.

If another module is loaded at the same region and another kprobe
is registered at the same address, register_aggr_kprobe() ->
init_aggr_kprobe() -> flush_insn_slot(NULL) is called. This can
cause a problem because it is defined as:

#define flush_insn_slot(p)		\
do { 	flushi(&(p)->ainsn.insn[0]);	\
	flushi(&(p)->ainsn.insn[1]);	\
	flushi(&(p)->ainsn.insn[2]);	\
} while (0)

Since the flush_insn_slot() is only needed if p->ainsn.insn is
embedded in the struct kprobe, as this changed it to insn_slot,
we don't need this macro anymore.
So you should update it as same as other arch like:

#define flush_insn_slot(p) do { } while (0)

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
