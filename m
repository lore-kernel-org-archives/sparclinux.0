Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730551A135
	for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663663; cv=pass; b=vCQwSWq3tR9FpFPVobA338V9Nj3yn7uSod9rhk4d1qHx9uMbnhbbbt3GUQckdIue09/kVUuZuDPGadgpt8NXtx5/T7zvjE+Y2pTGNJW7MOiZrYzUls8jt7dOTE6SmLGSvb9+4aFN3ZVYdKxCmkZSY+CGFs0+mwcpJu2FF4g03MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663663; c=relaxed/simple;
	bh=OXoyJpegabl0ocESy43SWOAVnutZsDrl9ix8aJurgKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI20Y/J0u1DxIAIZxAFMZs7yRrNGctio/5cF2hWIDi/37c1tXpTkH0CRJrR/l6kBwB7ySjuKnOJAb9zXbwPQCqSwxqqeSKje8vFgh29JeoHOdgoSiMBEzphxOW69Qq/Gc06H8KiSBFySwM2gUk8JwRsnGG+Q5JD39jvWo6e82jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/C9mgWL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKGKnJD3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/C9mgWL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKGKnJD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
	b=h/C9mgWLVKUE3XGeurN8VBjS/UsjoM5ZJ9tPSlsW3dzKSEAFnd4gOI4xE4ErfI2eOvIN4S
	1xiJOWqAUg3ahtdZBoIQpTeKpK7kQL5ctrbOz1AE33GVCC/fChAbPFI/5ecAUhXRVRV1+g
	akJs722ULOhvBfgMe2Kgrdhy6k8idRY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-MfcaXqGmOKmy5fNzBgXrCg-1; Thu, 17 Sep 2026 12:47:39 -0400
X-MC-Unique: MfcaXqGmOKmy5fNzBgXrCg-1
X-Mimecast-MFC-AGG-ID: MfcaXqGmOKmy5fNzBgXrCg_1789663658
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a1188c8948so1379675a12.0
        for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 09:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789663658; cv=none;
        d=google.com; s=arc-20260327;
        b=oeUGwlOo1aDxoD22tYMtXU7GRPwnbr9V+b1XIVC7lIjSSh/5CXRVM0HqsrxqYYdV/X
         8rTaBwmZco72eJ/siv5MtQs9Q5zskXFIi+2yo4iQhlsyBfM3yqR3LfAF5PPtzQu2PKvr
         GvjkhncBSPLkZgBiHS2SwIv+BKgCuC8RCcJVLiCIaK/iT/A/t0qSd3Ve0qF/tnWgcLHs
         bltx3HvDDT7xRODQt0LrDjwd6VNHciRdE8kPMdfFbvc2Cph6eprVblutJmsuaPh34pqw
         tPd9i2hZ3sppJeRdEubC7JLdWL4vNJdb9TLUfqDmcrHupqNCwFaVHNOy0JdCxWnH3t6m
         a7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        fh=RxqMcdHJuH77HVDivOsG+gzwSrcutQyKxGBkYB6c45g=;
        b=bS9VvoTo4mhw3/z+XyqW63IY8LAIwtM9PyrqkOkn8/T8fAZYOLm0wKX1U70Bgxgo90
         TTjMY5k6F3ec158p1tzLL4fSDtP6BQrztiNpttAu3O49henkyneO0Jc1CsL+cBKc86GK
         g/UBoID+2d89Y3ZzMdjRgz0RxAtMRGs2TgYrcCDIE8Jf6sef2rG4UGVZ5fbEgMfiyR7j
         oefY6fD7TVOL+sNJvQH7329rXYpm9aadkdwUb7Pt4UA2gS66IY9LbwlgQ9yb9uvTAGyI
         ZpdCW/UOLAgTQy6yNFwEumjGVQszC7WEwAjPO5D7rBNNY1i8fjJGe35Px4hNrzHj73OQ
         V45Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789663658; x=1790268458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        b=dKGKnJD38WiZGeDo9G7w61tJE8iA6+vSv3+VhV/+0BSAMznrhvPVqnGGKYQ4PLBA6I
         0x6n1uxTHhGhrERHIq4n2fwx7oBAGeJ0UH2xKBLCAHlcgYVJbSGdqkRY1bIrFojj6Vu2
         1xzNeV3ObTyMCYkO5MWwX8CYgFeVi4bWCgXmC4n+onP+bI4+jZOOu0utxMpLFY4bJHAr
         EnjiwLBgjs87fs6PxCZOmw1IRvyMdPyrIn9tJRRP/SWbFlBMtaD4DAF8BTLubz0gyLzg
         wVbhbv7VzQr/+jzG98EbBOOsFR5Vdnw7E8gs5KXES7CruX20+ZZXuAPdluYPVbk+dg7Y
         c55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663658; x=1790268458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        b=SvQdAQR5S3B/Zwwb86pKrc80NQhqYBHKzSgUAIAAFQSJ9I82/kTkMoGBGA9uWgLIAC
         aMwEoeMJf2dmVb/pvfg2ZjfdlatGrt2J2lAL44qiGH5jJnFj+MdvPhIRe6uNiVSZpBOK
         N13gW6GOutXzhkeLQwmTO+/R32dbdn9/qO/mZxX5rekyPgvV5v8TycFrDAIdZroSoe8s
         E6sxzS3VGvvSkHuxror+6wNWuY366phH9gkwP9CUKIt8x8mKJ6NuDAiXLPpKywEcB0Lj
         3J0zkCxt5hGKQLfQxuMno2DMJYDsnY/uj5Z9HkDDS2HzUUMrWIx4+ou17Flo0CXNHecj
         Fbng==
X-Forwarded-Encrypted: i=1; AKwUvByoFmfAw2VUMg7HD28ckYFlgtO2WZ0efkbBn5pMnmnActsaX2bQYOJuvRpf4ESPdpwS3F/68+PkgeGx@vger.kernel.org
X-Gm-Message-State: AFuF++kIj4pCKF+lIf8OkVSfXJ6Ie8f40A23ZnWBnsSkXq1MbWz6AJiZ
	2PJm2BkSjdc+wbbC5R06GXI+LcLhOblHlX/H4w0UM6keE8bU4+SxwImxmxdqMC6LgV7A1EgU7nE
	vvr7VuaDwDDTX0jAp62TN+uH2leSq+A54+Ly7Vo3tGUoH0FF3oNXsosiUPCP8Zo2DCUBOp00rNi
	z7ivwI4yF/RFs0DCDNq6zTsev2Z+Z5yZlSdiAeMQ==
X-Gm-Gg: AYBFou1vyE1/eBv9OYOf096NyQZx4Z4ZAma/UvDZWvzD1WJDy5bLLCAbZlJuAjPrngv
	0QtzXQ8tW3OoYNCLTg/cjfXIzxDGt+Xbr7pga+jRuBu7XFc2YLzk1G3H0eV3iXlsr2sf4SqDZRC
	vtAAGxsXNGZgiiTrIHgLEZ95Si89xc3QktYizojPJQT5ed+EmytNwdjMoRQIND0ZQZCCis4pHpE
	pruBiGo+7snvou5KXtQDTZ8tDkJFvPtCH4zaTZ5jRTU71puSmwrm95BFSmcLJfo/vBLnxeTfjfo
	aVg=
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id a640c23a62f3a-c29e5244c19mr627700866b.10.1789663657705;
        Thu, 17 Sep 2026 09:47:37 -0700 (PDT)
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id
 a640c23a62f3a-c29e5244c19mr627698766b.10.1789663657315; Thu, 17 Sep 2026
 09:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
 <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
In-Reply-To: <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:47:26 -0300
X-Gm-Features: AcwNN1UQ-9H3EW5aAPKYI2mYiHxV9kMvBFdM8jP3WAhZbefwH7qcxYHE69PGYDs
Message-ID: <CAABTaaAUBzp1uaLve2piMhEB1R5po5n5+Sy+U0mbbe70Ak-SUw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linux@armlinux.org.uk, 
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

On Fri, Sep 4, 2026 at 2:21=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi Ricardo,
>
> On Wed, Sep 2, 2026 at 4:44=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> >
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/alpha/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> > index fc8f6cedbb28..8a39c0473297 100644
> > --- a/arch/alpha/kernel/ptrace.c
> > +++ b/arch/alpha/kernel/ptrace.c
> > @@ -496,8 +496,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
> >         }
> >
> >  #ifdef CONFIG_AUDITSYSCALL
> > -       audit_syscall_entry(syscall_get_nr(current, regs),
> > -               regs->r16, regs->r17, regs->r18, regs->r19);
> > +       audit_syscall_entry(syscall_get_nr(current, regs), regs);
> >  #endif
> >         return syscall_get_nr(current, regs);
> >  }
> > --
> > 2.55.0
> >
> This doesn't apply on top of my "alpha: enable GENERIC_ENTRY" series
>
> https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmail=
.com/T/#t
>
> That series moves alpha's syscall entry onto the generic entry
> framework and removes syscall_trace_enter() and its direct
> audit_syscall_entry() call entirely - verified with git am against
> GENERIC_ENTRY applied, it fails at exactly this hunk.
> You don't need a replacement alpha patch, though. Once GENERIC_ENTRY
> lands, alpha's syscall entry goes through
> syscall_enter_from_user_mode_randomize_stack(), which already calls
> syscall_enter_audit() as part of the shared entry helpers
> (include/linux/entry-common.h). I applied patch 1/13 alone on top of
> GENERIC_ENTRY and confirmed alpha's entry path already routes through
> the updated __audit_syscall_entry() - no alpha-specific code needed.
> So for alpha, you can drop this patch in the next revision rather
> than rebase it.
>
> Regards
> Magnus
>

Hi Magnus,

Thanks for reviewing this patch! Ok, I'll drop this patch from the series.

Thanks!
-Ricardo

