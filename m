Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4316D1A2
	for <sparclinux@vger.kernel.org>; Sun, 18 Feb 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708269588; cv=none; b=WvWsOMIXy/C9gm7QMR3cy6WZuefROOUCSQsvFFG2jQIeGuhRkMcogEbiANb21Rmszzsn/4DpQ14zv39gmCcnXRz2tPURv+G142bh0gJwJQbgkR6jEhuJfni+6H/Si6IfNlLhPdmA3+W0eGea+PA+0X5R8eRs9QODdsfppnPXTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708269588; c=relaxed/simple;
	bh=lYFHSwKGcbZg0KftqGMF5GiOnvyk1uaue8OvErSz/MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwJXLted7GPU07EzaqeT98GaRJHuByy7frj9TydWRjjaeHneUsAKOyqCTz8s6buOgh27NiWuZKqT1b3rh7VqISSDzO5+4zwo0N8vrBIaqLp/ZCmmaf4DtkQTtIlk85QKzP8plBSC10+CrCGspsWFLAoRtC9BXc5eluxvAhzGy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z0XxTgjq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0XxTgjq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dba94f9201so18853095ad.0
        for <sparclinux@vger.kernel.org>; Sun, 18 Feb 2024 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708269586; x=1708874386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiWOUozWnezeYn8cXQvtDvCvh6gTYyUB/9KcoNgO2S8=;
        b=Z0XxTgjqWyazp15zaW/ZnhQPP/vQUJ16DOZ1Hq0r+BT7AlgmbJ9FONeOG3yHNtb9PL
         NY72Vj0zKPqaAgRpopK2+aqqkrQfRItybiUPkatXi9wwD13ZxQHcl8NYYoFU5Jp6RHdm
         c0o9K96cAg54FH5HIBpabLJjAOkt0mQ2F2mQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708269586; x=1708874386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiWOUozWnezeYn8cXQvtDvCvh6gTYyUB/9KcoNgO2S8=;
        b=RksO9Aru3i/hFhBmyN2dwm6sNTl80VEtkWv7d6yox2TVORnXX0c6No4EqKVXRCk90a
         7z9H3KyUeCN5kjFKfxlRFtb1ZySrmJvKe+0MeTjMfKh2PZqNhEoUwvX7iqOUoYSTQogr
         jy0EXWjM+zXax95lAJuIGpPFw9mNpHZufjAg22jXf/F0iKsQsP0udlR+SAQC76ZZ9ObF
         tRIhnSCNnyxvSaWitc8r80JmNRJjlHtkJXQ6W/eU89ztpWpWrIZFxYJxYGE9qVo4k1dQ
         9P7PJPEC3sKUkSD0zr61Asx+N0s8zfnC9kSaoOLbDaqkOpBCmLqr3NSnO+PqZW6nfdO9
         w2xw==
X-Forwarded-Encrypted: i=1; AJvYcCVcg/CqbpigyVTydugqfhcquBhGoRXeHG0p1ZVunorc3qX0cD1jcBbbbYTjQbTIN6px+8BZPduUbmJpUGAn/J/cCi7UVR9YkxKbjw==
X-Gm-Message-State: AOJu0Yys76GWiG3BNogmX5L+AKP6XSyhySERKKZBqb3lt+6gDEmNG853
	FC24DZEUa0nPBYO465JjMbN9gwT4salm67h+rumoHOT6ZP1TLbm1j1Z0fzNffMcxOX49N45Ziq8
	=
X-Google-Smtp-Source: AGHT+IEwNzubydVu0vknzcVa69X/XCvebX+hD4w1t59fYyf78CIgFeJEQwZl+9hT+F+Sx1VDcd+Ttw==
X-Received: by 2002:a17:902:ea06:b0:1db:ed09:db97 with SMTP id s6-20020a170902ea0600b001dbed09db97mr1262632plg.6.1708269585986;
        Sun, 18 Feb 2024 07:19:45 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090282c400b001da2924e576sm2777256plz.204.2024.02.18.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:19:45 -0800 (PST)
Date: Sun, 18 Feb 2024 07:19:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Wang YanQing <udknight@gmail.com>, David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, netdev@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: Take return from set_memory_rox() into
 account with bpf_jit_binary_lock_ro()
Message-ID: <202402180711.22F5C511E5@keescook>
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
 <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>

On Sun, Feb 18, 2024 at 11:55:02AM +0100, Christophe Leroy wrote:
> set_memory_rox() can fail, leaving memory unprotected.
> 
> Check return and bail out when bpf_jit_binary_lock_ro() returns
> and error.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Previous patch introduces a dependency on this patch because it modifies bpf_prog_lock_ro(), but they are independant.
> It is possible to apply this patch as standalone by handling trivial conflict with unmodified bpf_prog_lock_ro().
> ---
>  arch/arm/net/bpf_jit_32.c        | 25 ++++++++++++-------------
>  arch/arm64/net/bpf_jit_comp.c    | 21 +++++++++++++++------
>  arch/loongarch/net/bpf_jit.c     | 21 +++++++++++++++------
>  arch/mips/net/bpf_jit_comp.c     |  3 ++-
>  arch/parisc/net/bpf_jit_core.c   |  8 +++++++-
>  arch/s390/net/bpf_jit_comp.c     |  6 +++++-
>  arch/sparc/net/bpf_jit_comp_64.c |  6 +++++-
>  arch/x86/net/bpf_jit_comp32.c    |  3 +--
>  include/linux/filter.h           |  4 ++--
>  9 files changed, 64 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index 1d672457d02f..01516f83a95a 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -2222,28 +2222,21 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	/* If building the body of the JITed code fails somehow,
>  	 * we fall back to the interpretation.
>  	 */
> -	if (build_body(&ctx) < 0) {
> -		image_ptr = NULL;
> -		bpf_jit_binary_free(header);
> -		prog = orig_prog;
> -		goto out_imms;
> -	}
> +	if (build_body(&ctx) < 0)
> +		goto out_free;
>  	build_epilogue(&ctx);
>  
>  	/* 3.) Extra pass to validate JITed Code */
> -	if (validate_code(&ctx)) {
> -		image_ptr = NULL;
> -		bpf_jit_binary_free(header);
> -		prog = orig_prog;
> -		goto out_imms;
> -	}
> +	if (validate_code(&ctx))
> +		goto out_free;
>  	flush_icache_range((u32)header, (u32)(ctx.target + ctx.idx));
>  
>  	if (bpf_jit_enable > 1)
>  		/* there are 2 passes here */
>  		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
>  
> -	bpf_jit_binary_lock_ro(header);
> +	if (bpf_jit_binary_lock_ro(header))
> +		goto out_free;
>  	prog->bpf_func = (void *)ctx.target;
>  	prog->jited = 1;
>  	prog->jited_len = image_size;
> @@ -2260,5 +2253,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		bpf_jit_prog_release_other(prog, prog == orig_prog ?
>  					   tmp : orig_prog);
>  	return prog;
> +
> +out_free:
> +	image_ptr = NULL;
> +	bpf_jit_binary_free(header);
> +	prog = orig_prog;
> +	goto out_imms;

These gotos give me the creeps, but yes, it does appear to be in the
style of the existing error handling.

> [...]
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index b18ce19981ec..f2be1dcf3b24 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -2600,8 +2600,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	if (bpf_jit_enable > 1)
>  		bpf_jit_dump(prog->len, proglen, pass + 1, image);
>  
> -	if (image) {
> -		bpf_jit_binary_lock_ro(header);
> +	if (image && !bpf_jit_binary_lock_ro(header)) {

I find the "!" kind of hard to read the "inverted" logic (0 is success),
so if this gets a revision, maybe do "== 0"?:

	if (image && bpf_jit_binary_lock_ro(header) == 0) {

But that's just me. So, regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
