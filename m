Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB136C0AB
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732666; cv=pass; b=H7CZwrZhCC53MYi6FPV/4qF3c2IhNv2vPxlabjuzM8OCLgmuYRwucXAaCrk/jltd64C4D6jLutTtq0DRxoiWS5Wo/REr5ST+ialmDN23QR03pqCInsd32DCprMyIfLggDmoO7Uk8nw7iGYm1wyT+PTmPdQCM+tBJjOmEXEGjLEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732666; c=relaxed/simple;
	bh=+yTnC3qUCMhYF5izBj08k4AdSicm6irjFGKLdWdw5gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3GrrBW5AQ5hPZ1cJPJvZ4VXw/HEIu24IAPLmXPJiNQCB/LBk6+Ncq+lGYx5jv9fdhOf0O+YasUmEEVruen74YoXeRc5mnGt6trZrRD0de9eUqflO78Zu4Dbk0jeo2ZAEzYxgmF6g953b0/AdYj09f8anE24cmrWN2q39EhC6SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrZu+qdo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMua4GwG; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrZu+qdo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMua4GwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786732664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
	b=hrZu+qdoz3Xn9mJSNltKFNpdHGMnq6olmPGRf4aELEhsFnGrW7xHZ6rqspnCW9wOyXStXC
	WN/MCTBGnklfTPNI5L02lycGCvPOS//UzyqZGzw22AY8VP6r5IJzqJ+mHVDs894vgxMwhh
	tr+ub+1uuAOWs2b3AH1+JnG2hEDBtPo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-TVI3_KNzPM26pLPEwtj07Q-1; Fri, 14 Aug 2026 14:37:42 -0400
X-MC-Unique: TVI3_KNzPM26pLPEwtj07Q-1
X-Mimecast-MFC-AGG-ID: TVI3_KNzPM26pLPEwtj07Q_1786732662
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1670dd0f5dso101747066b.2
        for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 11:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786732661; cv=none;
        d=google.com; s=arc-20260327;
        b=ncgAW0+xpvfkbdHRYxQqF7dhAB30JtB3h+4DxoCVMMNxJzUEhopA9pbp5AJwlazYR7
         2xROj937TqxeyZDiR6ut8pe4MeLTdSUYcfmqb8auEnwaqJjn3mh1lwYvS6fnLvg4Jsi/
         J/yk2pcF3xuEljhqh6XbV2KCz0nQyLxak6H6HOyYYdjJdcevMU2G48AxlisFZdWe4EBo
         LAokQRT5sNo8ekNF1QFV8sMke7jm/nJjWRTXplZb8ziwTUBN9llpKvlV9Ive4cnyzToj
         1jc0kS/vHRGwIuelTDfIE42vxzFwe/fhXujoq20IIAvC9RAwArZe65PINwcwjoM+BSEv
         vb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
        fh=6fz6vUkKuK2noc8mnjZeGqo2T1XcXfHxZ65PyR+CesA=;
        b=hpd/XXfca1SkU7P/xUE6QYh1dPLNwaEIi7h54fxMSMitv79oJ647ZmNTVHKYHkzBFX
         nzPTvgPlTSITI8m8mlSW+PsUV9N0DJPvLOXWPAveFl0XCR5/Yd9N2sEgRyyywIfP4YsS
         xvF3LglutpTZ1AgCH0rWnEB/PnQpyDw1sLnf9mJtOXgAqgqxG7/dZ07NrNnD5xTl6vGA
         nVcCjlNumE1nuLGKREnACrtvE8TlOCaeLNB2wZeAp68SCIceXaLwhLm+sE0Zq8NnwXZ6
         TwbZhu+yyL6GMw01dH6j3rsa0c0xX/F1U4xanPTAV4NtPepYtpCtFwtarTD4iPafw1s3
         FNuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786732661; x=1787337461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
        b=IMua4GwGR8xgEcgZhotLfCGvXH65efJ9beslnsfvwQD9QUS/sD71Oy/dIH1BjRvl05
         MgB1txZ0uJK8mk2om42x3xjSm5VkXBG4SpUBGl6ewbnFk2d7X2E0MDaBBx+c6DTlJTOt
         HJstxmRabNK92/+NjfsgoS0QDMw6qgy/M+/PvyZLkA+BKo19LoQKgFwEEq7QlNMf0HEg
         Az1/HIoKtcX5tGzPiZ4WpHQGf7Mu+hJ9PKhAu+++2vuhyeZ7IA1bR05EUIro/fooehOp
         xg1ZDSfETRVbyWWI9eqCVNegA9kblL8t+sU7jvBgWhEWLMpuKrbxMFysqceSrN48zP9L
         poDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786732661; x=1787337461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
        b=jYz+J6NCNoZIer3vGt+TIdaahqDRk9TJDu/oDAOMQDH8yEHjDNZvDqK34VvnWuSCXz
         egViKTEUYM28jx4T5gYOBCVrqv3FNUNgoPd6kfrLL+0y1BJhVPZ5651e3A1noMEIJc4G
         3WAmoveoR4GKgB64kLwyzjbIX+7eZ+Kq4vO47ACWoChNMuqriM633BCnpQ3KfeyvBzRI
         4AnNpQKjrThpGKeua69eB15Q62nfzI+PhqGbVQuqHUGtHr9TlbtXZpeVuHTcSMoYKZ7H
         064inreDeTbsJg89sX11WUutPs85zZs3/M2Jrk5z5mh2eTnk8Oul/mBxaqQrEIzMTrIn
         MOCg==
X-Forwarded-Encrypted: i=1; AHgh+RqQzQJC+WRecjPsivTjdRxDy4S1iSsOnuRohZxnbXjZPGKXktSF4feXqsaJSTIm6rUm0lkVh2JhnWNh@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnJpmquv4hE7Qq7a0RJYDBFs0bS5zZv0YleOAQvGjRLOsTJmx
	RWHIXEKhTqUj6oUesGNm6pkLays0nA2Cx0NTzgXSDa6i+VJiDuS0ZZcSolB8j9vN/xOiaLQavVZ
	oRjjt8T7OAJkzXastKWW3xhdIA1ToGsyHjnSa7DUp0638+LVROHQeadZdJHWMG5e3td6os8Zip/
	PouORrLjhkfLWTfuSdDQE0yOYRCBsN9/EqAOheyA==
X-Gm-Gg: AR+sD11HKix10VhSaOy84Ec5s1lTTXvHAHzqLgqexIFIhI343mZC0e9/YJhcP4zS/i9
	WOSJSquWVzOef8/5Fi2K061iCHmjt8WzcdKJUVUBAyuepdOR9VPBj8aIGpagjXPcLjEU6vak1sq
	lbolb1W2850d1EKZ6ckaCfyKgHM3WYUnUBA7J8v/0m988z1xiwTCiExlftTnF4MxByl3jZe9JlP
	/5plxY+6W6yUF18YP6RGv1lBxEusZIjvpQN2qW5ZzWlVg==
X-Received: by 2002:a17:907:1c94:b0:c20:87f9:875a with SMTP id a640c23a62f3a-c212a23ba41mr343801566b.30.1786732661692;
        Fri, 14 Aug 2026 11:37:41 -0700 (PDT)
X-Received: by 2002:a17:907:1c94:b0:c20:87f9:875a with SMTP id
 a640c23a62f3a-c212a23ba41mr343797466b.30.1786732661284; Fri, 14 Aug 2026
 11:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786626275.git.rrobaina@redhat.com> <an7Udt-luZfJO71U@willie-the-truck>
In-Reply-To: <an7Udt-luZfJO71U@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 14 Aug 2026 15:37:30 -0300
X-Gm-Features: AUfX_mwn2tCHNr249W_00_JVZBPk2OAqZsqdPsMuBo2JtJrJsV0GhfYgrjHGFrM
Message-ID: <CAABTaaCcyTLV5TdmzZfpP6LMV+5GeCKqotPoJrb0u9n0h-TaHQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] audit: log all six syscall arguments in the SYSCALL record
To: Will Deacon <will@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, guoren@kernel.org, 
	monstr@monstr.eu, tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:40=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Aug 13, 2026 at 02:02:50PM -0300, Ricardo Robaina wrote:
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
> >
> > The audit testsuite runs successfully:
> >
> >  # make test
> >  make -C tests test
> >  chmod +x */test
> >  Running as   user    root
> >         with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1=
023
> >         on   system  Fedora
> >
> >  amcast_joinpart/test ................. ok
> >  backlog_wait_time_actual_reset/test .. ok
> >  bpf/test ............................. ok
> >  coredump/test ........................ ok
> >  exec_execve/test ..................... ok
> >  exec_name/test ....................... ok
> >  fanotify/test ........................ ok
> >  field_compare/test ................... ok
> >  file_create/test ..................... ok
> >  file_delete/test ..................... ok
> >  file_permission/test ................. ok
> >  file_rename/test ..................... ok
> >  filter_device/test ................... ok
> >  filter_exclude/test .................. ok
> >  filter_exit/test ..................... ok
> >  filter_inode/test .................... ok
> >  filter_saddr_fam/test ................ ok
> >  filter_sessionid/test ................ ok
> >  io_uring/test ........................ ok
> >  login_tty/test ....................... ok
> >  lost_reset/test ...................... ok
> >  netfilter_pkt/test ................... ok
> >  signal/test .......................... ok
> >  syscalls_file/test ................... ok
> >  syscall_module/test .................. ok
> >  syscall_socketcall/test .............. ok
> >  time_change/test ..................... ok
> >  user_msg/test ........................ ok
> >  All tests successful.
> >  Result: PASS
> >
> > Ricardo Robaina (13):
> >   audit: log all six syscall arguments in the SYSCALL record
> >   alpha: pass all six syscall args to audit_syscall_entry()
> >   arm: pass all six syscall args to audit_syscall_entry()
> >   arm64: pass all six syscall args to audit_syscall_entry()
> >   csky: pass all six syscall args to audit_syscall_entry()
> >   microblaze: pass all six syscall args to audit_syscall_entry()
> >   mips: pass all six syscall args to audit_syscall_entry()
> >   openrisc: pass all six syscall args to audit_syscall_entry()
> >   parisc: pass all six syscall args to audit_syscall_entry()
> >   sh: pass all six syscall args to audit_syscall_entry()
> >   sparc64: pass all six syscall args to audit_syscall_entry()
> >   um: pass all six syscall args to audit_syscall_entry()
> >   xtensa: pass all six syscall args to audit_syscall_entry()
>
> Could audit make use of syscall_get_arguments() instead?
>
> Will
>

Hi Will,

Thanks for reviewing this patch. Yes, I think so. I'll fix that in the v2.

Thanks,
-Ricardo

