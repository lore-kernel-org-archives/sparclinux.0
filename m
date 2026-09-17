Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49251A120
	for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663591; cv=pass; b=IOGRrqoyHVCnXjMufKkvbd6+8Y5Wc39M6D9zdO+SNsmF9WDghndLCQ6VFVQ543FrIkjMGyoU7ibfOu/RYcqlaiDvGvEdeHPknNI4aGk1F+jg7eDds/7aWj5l0bQPkPP46R+v3Q7URsLD0amNZqP3L6E4g/ZYpt6TeGZkMEDe4Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663591; c=relaxed/simple;
	bh=eYYWM3K0Z9Uro9HwA9hQ8je2naly/JqA+zNhzp9DrpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAASJWPZDBWuU79tZ2BXC3K4ANFODbarYF50cgHW0oaB7qfCBpRy+7cKQsBX1PzTLnA0MoEMUpSBl/+qgwTaY3GYn9Mk7lcL2M8kkLZCXPs7/Y3rFu3wMptQNZrtcyzvqiXPbrca0qWneV7HZ0Q9/G6dyKs+1e3zK13Ky7hnN3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9lWqdLX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H200DWtJ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9lWqdLX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H200DWtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
	b=N9lWqdLXj8LH/ThSIM+UCGG3PsWpXKluzUPVGEh1YVob8MZcUOGDATI6IraObPWjlZR83h
	srvFZuPvdhVz2CmogGHXp7Lo2FRCYZDrgkqlNvIQUj2myM4GSVskOqMATfhwtMKZzj7OSV
	bMIT0DTAv/VBthhGlrlwSzj3TjHICCc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-MDj4LdSbMY-2rJ-0guGI_Q-1; Thu, 17 Sep 2026 12:46:26 -0400
X-MC-Unique: MDj4LdSbMY-2rJ-0guGI_Q-1
X-Mimecast-MFC-AGG-ID: MDj4LdSbMY-2rJ-0guGI_Q_1789663585
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c294442d71dso133059666b.2
        for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 09:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789663585; cv=none;
        d=google.com; s=arc-20260327;
        b=JM9lX4O4Z/I1ZocGV8Mn4BxddmDY9ejWD+8OefUcfeVHBDEwUB4ug2ur5RWmp9MS1p
         FBForEn0r8N4wtUDNC5S39LxIQkBEH5BNBy+Y3qKHqCfOV8GqnZ06gscII6hcN59pwpO
         VptBigy/+peSbPTv71YRDumgfH9+RCqQg1SKRLOaxCQ0ekX+OZ78U2pFmqT5/aT8/mov
         WZ8fGMvgYYZiYEFbhdt2O86bAcJQ64Qmxnnnz7XFjNCCWc7eO9ilbd8ub8pQj5Y8JyjO
         JAfwOOi3R16MyjtvNAZ1vzSf1vStgrl4Sn31me4Ogt1G1pY6PlZmz2Rx7fOUwSX9HXTi
         pU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        fh=9PwnGd++xaCcTclvnTiQ2agwFNm6TydBFsPB0kh66Mw=;
        b=bF8exMYqU/rpNjIEFYUHuByJ4y8fAgcaeT4aIS6rIiArFkN06k+742JgDrhv3e6AW8
         drTSw3MTzj+5gDHum7db8DGmiUrIZ2Xni0iC47iBTaEhNv1WY94eSf5Yaa23G2kQWbW4
         o5DBpjWITBJaQYVBqxiUSiNEln+kfolEuaXqeW/2l6HcF0zKt0mW+wxN/V86oqjuK2wg
         s3fvKY7bj2MEdzPsVaS6XMhfFecUEtHcYBzDOw7usZqTQlw5+AeaEfo8Hqh5OCNRr8Dk
         1Stn2ZunthwlMF+A+HJzBlAl6IleMuFNM4aFUTTvfDGJiq5YoeNy+81ctoLLgjmNO08G
         AnFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789663585; x=1790268385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        b=H200DWtJICF9QH6JHKN/nmm5tV86eiUouPYi7aafDRycxl6U169OnOUHb3rKCENsez
         +0RXYTDalsgbqK5ghOadRO1Q8ILIs3srTU1f8QjOTFAsX6a0xyq2jTukvLaLDFgK2T3X
         nqWiLKjVhJUi1FY9XS2W+MFSI/Yfh90CWlNqT5+QBG5KUeK+wYo2J2lpSvjs9TNMBe+y
         xQ+ptvfiXIvmOWzzcDpd4BoaAXwTWRZRRuQ6ZGdvEVm7fpOJRHQ6Y+CSZnj1bU6AMMRf
         3uQUC6XuxCuwpCc07yBmfv3xF+IN8gmARl5UVfqxlHr6om+vwq01CYDReMmqjLfntZU/
         SgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663585; x=1790268385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        b=LmrxHzXODV3glGxraLhEd5ZpxZW9GoNn0A7HmLyrQWDDkit6deYkegJA/H1uUOcYqU
         4yls7j8nTqm7RADhfSp2S+n+mrlUNmeeFUn0thp7gxGbHoZw1QeJy/zUQON/arJ8GRN/
         Fcy94q/umVMK63ndSfIHb5T71LTNPtZc23gYheI34f+4r3vHQJIh2SW/zy4ammm2W8LF
         Wr9k56AOWuwkqFzEUcFPD5Ek3JW6dCAv+vGtxG2WwYTSmSuGqPJaGlUYSaOKXkAYVgDO
         vxO6nNI2A1/kTObWWkA22N1yimtl0jUD74jwC8ZyEg50rLrvRhBahd1Y3y3DlAIKeNDL
         xWCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwd2lQwhA5crVCCE/FoXex4EkBcb1ri/+gIhMKx0gJMrqg/PTehq+xMqhzoNVTt+K6JsC1xgfFFjbhz@vger.kernel.org
X-Gm-Message-State: AFuF++llOycmhM8NincFXctslMKUERuhY+5Lwl9mCdX10vfFKMFw64fS
	61w+uHyDbMrHBk8OU+H/Gq22YRvbvtK4w8G5IBFH2r7cMFgXP+UZcUjyYr7rhwDcvDYoX3/VtC2
	gv3OryPMcEY3qyuTEFGrHmqQQhpkntGUgM3Y9qCrsU0IVcEJp1aTKB4mjvbMK/WPu7UyakmxK8m
	rTNbEBdMM37sCS0BLjgfC393SpJYPelodECEh8jA==
X-Gm-Gg: AYBFou1CBtKqgMPTSj+biz0GoGIQloLDzw8TT0wykz3Ewm0K1leQs85EWHLd7mHRdUr
	IZRS310nAUXiHWK9rRKTq+DVyXIXwWUdpFyKJ6lt1Gtt1XFtx5L5xdnGo6WY+BE0E7wY16Sbotn
	t4COAG7gkL2HnPBTf501cbB6Bu2xog42gHSUCe9XDfrTmTaExi/bPOFVt9dySBO99RsuZN6r1zG
	Imor/H7jS8RNyX+sJaVrHfXo9V0ngF4GqaJIPv79y6amPtgetClCiNNt1KAHFbwNloElHtGXDvH
	W3k=
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id a640c23a62f3a-c29e53184f0mr504527266b.42.1789663585490;
        Thu, 17 Sep 2026 09:46:25 -0700 (PDT)
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id
 a640c23a62f3a-c29e53184f0mr504523266b.42.1789663585091; Thu, 17 Sep 2026
 09:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
 <apkuNj1paR_GO3x9@willie-the-truck>
In-Reply-To: <apkuNj1paR_GO3x9@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:46:11 -0300
X-Gm-Features: AcwNN1UTQywdGW9xqj12KwNHAYLGfDNNso402GZvP3WcYYwXGdDJ7Oiz7qML_cg
Message-ID: <CAABTaaCoNztwDUA-HPp4LaikxL4dxk-1bvCCpoZEGD4rnds1oA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
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

On Thu, Sep 3, 2026 at 5:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 02, 2026 at 11:43:37AM -0300, Ricardo Robaina wrote:
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/arm64/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index f743cbec1c3a..65532b2a8cd4 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
> >       if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >               trace_sys_enter(regs, regs->syscallno);
> >
> > -     audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1]=
,
> > -                         regs->regs[2], regs->regs[3]);
> > +     audit_syscall_entry(regs->syscallno, regs);
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Thanks for doing this.
>
> Will
>

Thanks, Will!

-Ricardo

