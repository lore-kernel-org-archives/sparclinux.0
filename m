Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F437E5E1
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549071; cv=pass; b=B13Pwn/2UKat3THUFKwFe2iM+dylyifvGpSTFG7ESIije9ULJJHlRZAQ4Zx3ZfAeL4od/0lhKXINaQ3iziXRlyThDqs1gLdm1MUbrpyXag6CTGu6qPi/17XviMl42BR+bzfKXKvCi9a/PHFGZ4beXYhZ+p+L/JsGGy9IoBDAbis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549071; c=relaxed/simple;
	bh=67Ku8tFH0+Ws1D/iHURGK4jc/Djx1tSgxDkwhxzxT3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScKviyggjhBwosne209FZxPSg7jhmPMJ0Db50Jqdkm8/xeAn/24j4KGDTXH4tDXhmknXBgA2C6m5h7JiWytIJP02egvCb5rSGaL84o+Jjnoh0QHO8AXZIl3D7UzHb24/pkSPpzD9rNIdQruQbeISyBOWs6b9tupkC613VJsUaVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idxeZmKr; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idxeZmKr"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab062a08f5so1776181a12.2
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 15:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790549068; cv=none;
        d=google.com; s=arc-20260327;
        b=VzhZ9Yg54Fpf9CvnkMA/S3cm56nbivfHsXfWKle13Aul+O6bbETVaOWtsUrLIBvcsg
         aY/XwBDEvhJL0CyHtemC/3bjWh3dKlVSblKn0n+5Uv6QBRZrQi9H13ExeLOPcnuLwZ0E
         HYpkGnnZP5Hnd+5V7naohxiM6W51PagPExiAslMd+cgrBZ3clsNBDEAzPAe03/VuMk6n
         5eX8UBTXV6WGmx7GPPdZx8qSadj+kAbChFh+RxTxe3khETQSHV6a0fcrBnIttCX2Vd9R
         /MlibWEtXrsg3xxHuqKOKR2wUBG2mGJHSLTNxlBVlQfV+kLTAKTSeQR5WclikWy4NvNz
         Q8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3+p9C49RjwabMoeKKrN4pwFaIbJPXgpkYJgPdYQgKw=;
        fh=F8KN/yC6lcZsr63AHHaobONkTWkMqQ8LeQcwVTN5lLI=;
        b=XiSK1sCdFGnNaqVFtjTZ+NrAgc00vQwxaUPbEaTv0PuG1PxmMsqgWh09VOegJpgjWU
         mJcedShWuIrNQGiYe/HLaMKtSsJ4g/OrfJJ0Wkjch73KpYdVlm5wSbE6gX/4o+Tmq8Fw
         hyuQZDXS6XzUzD4Rdz2Sdfnr/M/7JpLvGTjkvv5LddIJ32SxUEMg1mqeWsf6aeAbGKIv
         umucmiIXnQIjVvp++CqSzy6yLriowqKNImd5YkH9Do9BInHeI4URML2t0qR8IWU6GwOD
         tWXKM2kzJ5zWza19bOO2zmw/e3VO6Vyv0ue9UZ1fKSMBUQmZLzY5r4qFBbQ+yogzcbLo
         FHcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790549068; x=1791153868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3+p9C49RjwabMoeKKrN4pwFaIbJPXgpkYJgPdYQgKw=;
        b=idxeZmKrIuYKrd/YfxWT/URZFew2m6CV9Ae1fBK3rIb4TBy60O45Wt7MP3Rba5Et8h
         EHXII1gaCEXGLF+rTKLe4YWW/3tVI23rK8ss/nL6IcCichX6kkgvCupdYYM0Lo2hTbZQ
         f0U79XjYcNsAJEvVx+O2lJggX9CGh6wNdQAQNGwsNA6J3LAujcLeSLQ2lQIobRK+25Ew
         sXepR1I4DIeQw5FbGgu/a1qTECPSkgDLSVgBVCy/HAvMOezvRP6KCzD1p6Urw3Dxd5Ap
         UxBXf9+4Srb8VHQ5Z0EjaEb39BLal2BDXByZD82Njnh0Al0JT31a+ZmPeTK+VnlWIOXv
         bMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549068; x=1791153868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3+p9C49RjwabMoeKKrN4pwFaIbJPXgpkYJgPdYQgKw=;
        b=Yk1fAwST3bbT5jXynh4AMZGb0FUJ6UIqypJcnWkGTnFZ6TlxD556fsn8EvLXQrxv86
         7l3j4s89AGt0hblx9uLCf0odpgFQ+BqDSAa9+cf9Z8c94cIz6Kv9n8z9Qkrcq5sQGsbv
         RG7ULmJBkt5sTG09osVyA9HQ5rE7WQcME7NWZOEoMvb/Qw32+d2tQAXr/h2YYV+ef7gB
         nLU0+uuCAAyJczx8USzlYbRk2izdpvtNtmXsPVb4QUAMo7ALJiVbBS08C/vg/P0nBnAr
         G7zgS/p7jWoAbKqhP2H0BbKVzFOoRBxPP7J39/ha3sYXMxbPKSf9zfYBaPkYE2sV0I1I
         8Eyw==
X-Forwarded-Encrypted: i=1; AKwUvByc5S7aIRTlOD3ADpxSAyhs7qhOP+8rvV+TgnVv8I6TkKN7Dtxawj8NyRcU75NeQ4t2xb/0zVYuO0zk@vger.kernel.org
X-Gm-Message-State: AFq9FYJlRyLqgQiJ4mnSa1eYRhn6x0ZIPZ/XZwIbr1oqjL80CLKUqzdM
	F14wFsdL+0yQZrPXxwY2sxd9dibCE700KAFw3NxpW7z9d/37zFKn9Q3kgFjzJFXBaF8Sgo+waw3
	ERepWCebM8qUu613I+Zl4hi8/uOboowA=
X-Gm-Gg: AYBFou32lhCYYuZBXQ8XmATWqeHwIsdLGowbKY0zNz5GpuHoWQFj/Qm/A5G75biyY8B
	yO4DS1jotCJJAMMyBD66Yixj8mCjc8fkP4SIpHoLfwZp4YuSZ7bjpwS1Ga9IDOjjbANfQXkRP5x
	0KxWzflI6aTJ370b6JrQrvTyIUEAh0IcDB5G3mB8+QUEDDVv8nGgFRla1Tr45//ewOGj+LLxNkU
	UAePJ6g1QxQ6alub05REv2RgT+cu5ukN6kMEkNudaujxkgO5XCNRlGpLPCTEsCUITjs3C7iD1MZ
	qa0ETUY5zxMdd6z79rG07EAPITk6iar2S5iURD90xITHQW8jSCv6p2UNIFg9usZ2Y17dhnfRzD2
	VrvkAT2heSqgSacDjrMLg2N73b+Dqy1TEv73rdMRJ1Q==
X-Received: by 2002:a05:6402:3604:b0:6aa:f630:f83b with SMTP id
 4fb4d7f45d1cf-6aaf63104edmr4907482a12.34.1790549067897; Sun, 27 Sep 2026
 15:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005726.8274-1-kaloz@kernel.org>
In-Reply-To: <20260927005726.8274-1-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 28 Sep 2026 00:44:16 +0200
X-Gm-Features: AclHuK_ocZcXs9sywIUtTayi9j3iPPsLoAkkR2Bcc_gGJtZsVc-FFNs2BXG8wLA
Message-ID: <CA+=Fv5SRtS=dZQP_773p+zdgRYYOwWJpBBNcs36fCmNhwOQHvw@mail.gmail.com>
Subject: Re: [PATCH] sparc32: order sun4m and sun4d cross-call flag resets
 before sending the IPI
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:58=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> sun4m_cross_call() and sun4d_cross_call() clear processors_in[]/
> processors_out[] for each target and then raise the cross-call
> interrupt. sun4m sends it through sbus_writel(), a volatile C store,
> which orders it only against other volatile accesses; sun4d sends it
> through cc_set_igen(), an asm volatile with no "memory" clobber.
> ccall_info is not volatile, so in both paths the compiler may sink the
> two resets below the send; gcc 14 does it for sun4m. A target that
> takes the interrupt and runs smp4m_cross_call_irq() or
> smp4d_cross_call_irq() before the resets land has its flags cleared
> behind it, and the sender spins forever on processors_in[] with
> cross_call_lock held.
>
> Add a wmb() before sending the IPI in both cross-call paths.
>
> sun4m has raised the IPI inline since the commit below; before it,
> set_cpu_int() was an out-of-line call. sun4d has had the same gap since
> 2.1.97.
>
> Fixes: 4ba22b16bbf3 ("sparc32: move smp ipi to method ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>

You have gcc 14 sinking them for sun4m; the other end of the range, for the
record: gcc 9.5.0 (crosstool-NG, sparc-linux-gnu) does not. Adding your wmb=
()
at exactly this spot leaves sun4m_smp.o byte-identical, and wmb() is barrie=
r()
on sparc32, so that compiler was already keeping the resets ahead of the se=
nd.

Might be worth a line in the changelog for the stable side: older toolchain=
s
build correct code today and the patch is a no-op for them. Still obviously
right to add the barrier.

Magnus

> Notes:
>     - gcc 14 moves the resets past the send in sun4m_cross_call() and
>       keeps them ahead of it in sun4d_cross_call(); the barrier is missin=
g
>       in both.
>     - leon_cross_call() needs no change: leon_store_reg() already carries
>       a "memory" clobber.
>
>  arch/sparc/kernel/sun4d_smp.c | 6 ++++++
>  arch/sparc/kernel/sun4m_smp.c | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.=
c
> index 9a62a5cf3337..11ce613e2682 100644
> --- a/arch/sparc/kernel/sun4d_smp.c
> +++ b/arch/sparc/kernel/sun4d_smp.c
> @@ -321,6 +321,12 @@ static void sun4d_cross_call(void *func, cpumask_t m=
ask, unsigned long arg1,
>                                 if (cpumask_test_cpu(i, &mask)) {
>                                         ccall_info.processors_in[i] =3D 0=
;
>                                         ccall_info.processors_out[i] =3D =
0;
> +                                       /*
> +                                        * The target may run the handler=
 as soon
> +                                        * as the IPI lands, so the reset=
s must be
> +                                        * visible before it is sent.
> +                                        */
> +                                       wmb();
>                                         sun4d_send_ipi(i, IRQ_CROSS_CALL)=
;
>                                 }
>                         }
> diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.=
c
> index 056df034e79e..6ee65c05d089 100644
> --- a/arch/sparc/kernel/sun4m_smp.c
> +++ b/arch/sparc/kernel/sun4m_smp.c
> @@ -197,6 +197,12 @@ static void sun4m_cross_call(void *func, cpumask_t m=
ask, unsigned long arg1,
>                                 if (cpumask_test_cpu(i, &mask)) {
>                                         ccall_info.processors_in[i] =3D 0=
;
>                                         ccall_info.processors_out[i] =3D =
0;
> +                                       /*
> +                                        * The target may run the handler=
 as soon
> +                                        * as the IPI lands, so the reset=
s must be
> +                                        * visible before it is sent.
> +                                        */
> +                                       wmb();
>                                         sun4m_send_ipi(i, IRQ_CROSS_CALL)=
;
>                                 } else {
>                                         ccall_info.processors_in[i] =3D 1=
;
>
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> --
> 2.47.3
>
>
