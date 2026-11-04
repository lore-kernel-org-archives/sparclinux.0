Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793752869;
	b=tlXQ7b5+83wEbmue3FyeIkBZYCAX9kCsJoYCPDiRKJXYShU+svQSY3GfJDVsNsMDsMYK
	 UpFQF53acs3WVSV8tC2rLaGVPwrLIvwpCe+lLXlk3zRkGdA/wktHo6VG2VC9qDESSvmsU
	 FT/Lxv0DB2GS9T7qOagRyxR+WuaN234Hwg34voismJslWTysgXbDggegRRh/gQ/W4ES+8
	 GIBPrFiQ0Xvz1idEXqmUUQmtKaitHYIA31MouF1khecIg1d4vSBJF0MaGgcG2WApVxFPT
	 bSJTl9AMmezXdAJiexJKpRPDn2udXqR9ANTjrTBQ93nijJqBdAgicMV5OYa9eUT/Z8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
	b=0sxZbHLbUqKrhe4PHzxUK03rCL9WmQvKEcSwqcSGQvq+F7e/NOIXu2A/QfoRZhHp+MTd
	 0Ryq4K0WMXtNFeG82RuXl5CZKdWyJIAn7gJn/jl9jXhAlBVRxvnZPocwAty7J7yvQH7jj
	 MlM2p+qO4ixx6oFAssXzytcDiHH2h0FSphJxEcBo4ihd8c3LIsW0CrejeFTwAdZTzP4J8
	 ZymJADreugIVCwRqeaCnNGAHhtSmL2jUgB37rbzEWvJpVgnz3tI6wgZopA8b3Qp//4p4T
	 xYouQqnloy4xbKf9H4LMwAHykxeYbkmrdMwgBltsOzwg4kxzvuvImBfiy9Qsm4OKuSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F7606A324
	for <sparclinux@vger.kernel.org>; Wed,  4 Nov 2026 00:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D62F7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a05b210703so114365b3a.0
        for <sparclinux@vger.kernel.org>; Tue, 03 Nov 2026 16:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793752863; cv=none;
        d=google.com; s=arc-20260327;
        b=V2u/MlCDWjydStswJfZQ89u/rsmDVwOvWOr2zgewrgKub3qzuNl3owx504YGyrBIgL
         NvURPFCUgcvNymYr+i8ALIAvciow7d+ChHxmHCyOeWxtRjpUA17uqWxeOrkoFhkmlugT
         joiaPG+V/ryJj7XZDCMOCsRZjtS9yHDDMSsm7S5JQCdGwKvUUHzW8na3n3Xi52aivnr+
         ZddkbLhaioerY9WE/nsLl7hL5hMPcg7J5NdmtJhMN3N0VKppuzkXypE0OltFF31Dx7W1
         7bRqymmubZCnSavE7fCpo5jdZolaIhiLHwsu/eu7bU7KcWsJxUw0rZ06gFKwmtUCfPqD
         Tegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        fh=leg3/dKfO01uPMTIG7oMbR/Gaivi7HIbqKF3e55iRv8=;
        b=Gc1zcxm7EO3y42Myfv2I1LphrOjgF5X4yWFpEt7557Yly67wYPmYiscRvQpWccB7F+
         AaVjzEX8nZlRmsRWG2efTMfU+TYp9jsXxWbyI/iFRs4FEU3kS9DA0FoXSgtIXsMA/S3X
         zIZe0qceK2cngQ3GRGOj0Abo8JxAROU19/IlRyeW2QEiz0PIM9/WHy8WpMl0D7JUbNZH
         8wjX0UcfbiIK4QK2tBQPg2JJ99ElrTMZ33lsfucIBYGcg7FJ8fT9BIjvN/meR0eway17
         DdIeI7uAomXO9r/kpA0DtmGXHuEx6YQ541jBVy1Y9tbitEzXrFmsdh2RDXn7e2JKHtqC
         9UGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793752863; x=1794357663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=PTPniKxw8lSLWSxMbmhmXVodXffwfFqC3M3cDEPYPvY1SsBjNOjXXv95CLFg3rVQFu
         x1tdyRAr0bqYQ6HVqsjHpfPPU10/1FhE3kd/CHXKlKRa2s8Jf9/RWGaRvSd9s3tWp3+h
         Tji6Btj/3XlTUrwGPe+aphN7moDM3Ujmyews2MtwEsOdhWo9d1B27IQnIAXxeCj/AgoF
         TwCZd9YYNW98ENSoBC4GvFAhash4XN0WeHulLfX/snYculqtKEVgWcaAWPf68LjYBfvq
         i5NzGzwAog4kKLckyYK3n2IY4tOHLEWiT5cJSG6dbW9SW1FZ4MjXmEMstZ0yw7BaSVW5
         5qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752863; x=1794357663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=aglp0Vkd/bE9B4yh/hhGRgbfWBvuF03UXhuSI2XMFLNhbJPpT2zOVylomGuzobvctj
         /bv9rbGnnH1xgr/Iz3LDkGlllUlK4uYvBkZalQ8oBKOdqqIuIHxE20eXVsaLUcbiS6F5
         LNvFKVtL+yObc1vOs30VqV2wvxSspPvOAMybdspwsNAGgiJXmy4yTYOEeTnzrKWKgmio
         ZI+1nYHmQOxVEn0GMTwTtJZ7WSpWJ75SeXus/MtWXGrKnAxGLi9Q1r+BJuA0LflW2qlD
         KMEDaNaxqPfn5GHf+JYPht1HOyQMsQYXo1o6dR+hSsqo2BoJPpf8wTzMFAs4iSuyoAe9
         9wvA==
X-Forwarded-Encrypted: i=1; AKwUvBywyKbyox76OhEu9LujI1GhTNYtbZfFFvDogrlgfhogFiHM+RjJkaYr+NTAbshziG5hyvXq65Wgoyke@vger.kernel.org
X-Gm-Message-State: APuU4Z+sL90t8tWL8hv1CFVWBTIpgVStwn4S0lgTxf61iV5L5eyLu0xZ
	seZtXuKtk+q9HnTHJf6R5kIU3nESaAl/4JQYV8vJPBtS4ONvZZgfSm+rp+orfc9LbfGxPI3ZZkh
	qoRvAteRGMUVrRfZsFymtepSAdz3MadE+YMC3NMS2
X-Gm-Gg: AYBFou1Gi401HOjIPQ42xBOJ3bPEp9FjA/K67/+gRt5D7lz8yvOokpRV/7vuazAI3FH
	7lfZAi6Tyoy1VSPh2Ug0iT48mHs3c3QpeoseFHKW/JbV6X/BnC/JnAph9acdoUlmqf/NNT4WsxV
	NyOfTMSiySLqKA8LcmL8ac7xfKXtnLspBAiRXR63Jk1FvBtp/5tic/nIjMesQflIhPgVqQmNYVt
	96wmAshoOKyxybTEbvWfSfFprzsYpdl4FizohqGn4ojV4VxsEaYr7zmb2GLpD2kBkT5CuD2sODz
	5u4qSq4EqdXuA+Vq/TJ9SZCDr0eU7etgWmwxsiLNXc4kis+jsTWWfHzYjMRbxViTblJd3nigiAD
	AIdQ07Wd4i90vRZSEPUdqqdhUqUGs8RqU8G0q+TsCKrNPm6D1rb8N+u1ZpRpR+ies8yyX
X-Received: by 2002:a05:6a00:2d96:b0:88d:4b30:1c11 with SMTP id
 d2e1a72fcca58-8a9ba703bc9mr11394030b3a.6.1793752863107; Tue, 03 Nov 2026
 16:41:03 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
 <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com> <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
In-Reply-To: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 19:40:51 -0500
X-Gm-Features: AclHuK_mzIhdjHPxjnkTYRthyfMgrzjS55JZuNf6mZPYYsQQvO81kKGlvJUv8_0
Message-ID: <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:45=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@r=
edhat.com> wrote:
> >
> > ...
> >
> > > > * As pointed out by Sashiko, when you were converting all of the
> > > > arches, it looks like you missed alpha.  I took a quick look and it
> > > > appears that it should be a pretty straightforward conversion like
> > > > most of the others.
> > >
> > > I've actually dropped the alpha patch as per Magnus's request [1].
> > >
> > > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phd=
BKy4BLWOvDTt92t5Eg@mail.gmail.com/
> >
> > The problem is that as things stand, this patchset breaks the build on
> > Alpha.  Perhaps this gets resolved during the current merge window,
> > but as you know we can't break the kernel build ...
> >
> > https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.c=
om
>
> Of course, you're absolutely right that we can't break the build. I
> was afraid that this dependency might cause trouble.
>
> I noticed Magnus posted a pull request a few days ago containing the
> "alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
> resolved during the current merge window.

... and it has, or at least it appears to me to be resolved.  I
rebased the audit/dev-staging branch against v7.4-rc1 and Alpha does
indeed appear to be using the generic syscall entry/exit code in v7.4.
I think we should be all set here wrt Alpha, thanks.

> For future reference, what's the best way to handle dependencies on
> other subsystem changes like this?

Generally speaking communication and coordination :)  Talk with the
subsystem devs/maintainers to understand what they are doing, let them
know what you want to do, and find the best way to order things so
that it all lands in Linus' tree without making a mess.  In this
particular case, with the syscall arg audit patchset not being ready
(missing maintainer ACKs) and the Alpha changes going into v7.4 it
turns out to be quite easy, which is an important lesson: sometimes it
is better to defer a new feature for a release just to ease the
coordination burden, enable better testing, etc.

--=20
paul-moore.com
