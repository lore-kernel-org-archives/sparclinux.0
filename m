Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792759542;
	b=BLSw2yyOrivaAZ6tngOKVxetN4gMyFEf5H7SpcQzzivuA/CwZ/Jx4VACYsVVk0xhivzw
	 RF9DwUS76aAa+qFkO9tv85ZXHgvZ1tngpIPdX4rNFGclHgE261a/mfg5jbJlVR6dJQ7YY
	 sVx0sUt9DlUz49BkG4C0YVlueSZpJw/pRzr9BFOILzZMi82cMHL3gQGXLDQ20AE8DRpp2
	 Ak18aNKcsS6ivOpK/93/2RpfNaCH8Clz23qnvxyMI4HHBkuzZLo/TLF2zOAQlJEFSOjfj
	 PoTc1gPBBgmV/l8l4PCIKZZdjnJRERyNDTTbFeHdYtKiQSM7H7z8IR/hXVhLgB3z0Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759542;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=xQ5cGIg/FygutEOBLoU6ERivHwh1dQhhp4Qp5ZhDPf3uLIA4a41aCaR+JTWbYorbhG1T
	 rFjdNzy0OaquwyQ5ohT6bu1oT4GDgU11+7pMXZxUg+QJoCsH6+690LOPXJZOpbwvGO1+k
	 Z5EmVslDSdBZ6zaz9+HYR9/3a04VwgZWkt19AjhRLq4fDVJ3yAT98lrtdoeQ3ZC3WZ7IQ
	 FZXMPhnbByc1970TBfhREA6FXNnA3ekUf74WiCUwzrCMXNX+19fgfpVkZohTjdH94VZ1a
	 RGik97Lz9Vdn8++HvgzQLNTyPutpwvRurN1oE/9t3EJZOjREGriA/Zwza4Feb9j95NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HMqYc8W+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kvNnk1JJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76719606A31D
	for <sparclinux@vger.kernel.org>; Fri, 23 Oct 2026 12:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76719606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HMqYc8W+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kvNnk1JJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792759540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=HMqYc8W+fjXYuoeU0deohfy5BjhJjLWC+ARnQHn1fjyPD//jxOKKRuH9DQMYR6V1qkQzjZ
	5TSK3qgF+nphUNqAih5iWmoJe5pTMltxyhtRYun1OXReg8Bfv6GjGwaTYm9dohrknjPc/7
	ZRCv1tsqN2nhjo84uFslVuZURLH9gPI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-iWtYZaztMfKPQbbx7SWt8A-1; Fri, 23 Oct 2026 08:45:33 -0400
X-MC-Unique: iWtYZaztMfKPQbbx7SWt8A-1
X-Mimecast-MFC-AGG-ID: iWtYZaztMfKPQbbx7SWt8A_1792759532
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c42394d1e41so70589066b.3
        for <sparclinux@vger.kernel.org>; Fri, 23 Oct 2026 05:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792759532; cv=none;
        d=google.com; s=arc-20260327;
        b=dlMC/aDsEld9g1yrwWY87Ew3at+PI0crpPRr5UMCASudUXtmN0nkHkDNxnjeotN6lr
         KvX2voyZnmydBjDI6EWY3uWQKSnIxz90DMRbMf+UwmbaKSszHpiL883jw12RiLHt+IL9
         5sbfo1h/fBfOLxp3zHsbKYEyUGxHj96qVjnhwl+ZcsUYu3RC2jNPMXisOzbgJfdkU8Pg
         gbjgBs4DqA7cZTmjrp9qspGu8f9cjVzX5jwiSVL+/dq2fO4W/wM6+QjBFPDNzV6dKlvV
         SQeP8yqPmn4dMPNuP99d4IoOrRv5u/FDV4vE4k0ApykEn76n8KUiNaqMEL4fUFbr3lAU
         fdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        fh=5CJe3ftbHjw90zm3BzG5hhHs9YSDxt2QC/oCqrYvX0Y=;
        b=mkBNQBIaj4isJRiFIBmjY1+CsiPu8b7pDakanM9ccYIo4NyA/DPqYpAmSKgq7vpe0P
         ensYPF/t4SSN8hM/UQW7n8aPdI0XjOeHVAhdeHtcw4Q9m9txqbPFktGJ987in9gmGyYy
         U/lxl7aTGToOW9JpM6p7pXnzT7YrPx3ypfqEDYnq6PQ21ZalxE5glo2Wlip01sRf+Icq
         CRlUDtPYVJlyEFgOmo5JuKSzafVRez7ZL86dbm94rv4NsQ8TuH5lQq8yQtZhlmCe2+Ir
         SDQiKyDNfFhroT8eiPZVTKdqt4E7SaEYd3FJWz8HgTE7TUXX0uAIof5afxuY/oxS/CAH
         Bkgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792759532; x=1793364332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        b=kvNnk1JJq5fdRFGdNebQGgC7q5Z0qxP3L9LUL3H41Yth6fk3qBq/vZiBoiFYGjpoaa
         n0dKED8PrTcleCQwOwv7EZPUJSb5pjlDuNEjMabYepgzXz7C3LDzgy4bYbztjIZyxLVm
         9Xqzkh+s/Df+49IhCw6cb1qC+ZGFZ4Nq2c4DcUiiFr5dQqfAvw2NN8GjnWhsaGKkKTYY
         KzF7Id+sGWe/yi/p3xtqj3XYUidB030oWuXhAmSpJVfUlD5svLFMDnkRZ4hFBW84cWXH
         J5am/hwQZPE6DkBBvdYxtO+xDbckJ1JouoT4CQ4/tz5aQZvy3bGe6vJgFqQzFd7jFxWj
         dG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792759532; x=1793364332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        b=tKXOk5UA0Anj+Dg2sdP1jfHLFYukrMZWmD6xYmqGXjRrgYyCZ+q3qf/j9C2ITiIDPd
         SDg1S5E0/I4okCnB7FCxYK11eZScTvEgZNFl8atfWdfSxqdV4pbS+QpIWOqCvVZcdfS/
         9P7RLOZk2pK6OebXbm/eqXMDm7Zu7D0li8uoW1ZBCu/65GBE1BpMtAfYcZf0hbY4nARq
         Xh5K4Kwl7Rj8Lp/A6+in8H9DleMR2+QomnCHGsE+w244m0lLHWGYYA9w9ZWHWg6Sid+b
         hZXwBx6WacDmGbdGGbISxROmqohwZn4ybZ1SAGjYDqpT2cOY41T7Mpi96TwwcolTaNAO
         rY7g==
X-Forwarded-Encrypted: i=1; AKwUvBzD7yCM/BDGxvjHe4quxzlnLQpij5rT2qIpVRHDv7970v11noF0bU7paPunAnk7czrBXE9xurx3X3G8@vger.kernel.org
X-Gm-Message-State: AFq9FYJSbnUE2oktFTngB+Eyb+bUviOWY3ZTVQQY3zO5TDlKeQR4B2UN
	Glmh+Ng8HY0njpLA0zF2racFVVr2Etp+BXTXqSdPWuBXY6NhsRk5cW4RPiJ9zww6KprkoV1CHUm
	7oxY/Q+tyVug20ck34g1/yIZlXyrRL7uFW5K3mNkjZ6wUyhmtZO5rq95tHSbH5R3up1uASia9fw
	kAG/iKEw1SriXnWdAhmiqgRL8hKLaHR9ZIkq0uNw==
X-Gm-Gg: AYBFou1uLQY+UtfIK5hM0R5O4oyfxmC0clMaUxLFuHUUsa5+7l/e1G7ejc38OpI2tos
	63KW5EeTTtw1q4Ct9YSylRmb1srqHLikgtzem6OvGbBNiEuVngtkyBuVYfJaN5zlfsreIJpy54k
	07xIxUJgVcqd6DZHTOHxGdE6l7VF8jXhGBikxoSx3eowkbCUsY8O4kWAtbFACcMPWAWl1h8keGJ
	PikWBiw4mi8MZpIbeYT6qjiFA+65b5ZnmeAw5S4BVI4tl5a8hxrxlnvOEMRrzyjkXbHxGdiA90D
	/mg=
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id a640c23a62f3a-c46a92ae6c0mr328358566b.40.1792759531924;
        Fri, 23 Oct 2026 05:45:31 -0700 (PDT)
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id
 a640c23a62f3a-c46a92ae6c0mr328354266b.40.1792759531460; Fri, 23 Oct 2026
 05:45:31 -0700 (PDT)
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
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com> <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
In-Reply-To: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 23 Oct 2026 09:45:20 -0300
X-Gm-Features: AclHuK-AKUESe6iHVc-VzwOYib6sgRKlK0BCnAtM6wg5S60Ozyo0oOLLHvDr8CI
Message-ID: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
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

On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
>
> ...
>
> > > * As pointed out by Sashiko, when you were converting all of the
> > > arches, it looks like you missed alpha.  I took a quick look and it
> > > appears that it should be a pretty straightforward conversion like
> > > most of the others.
> >
> > I've actually dropped the alpha patch as per Magnus's request [1].
> >
> > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBK=
y4BLWOvDTt92t5Eg@mail.gmail.com/
>
> The problem is that as things stand, this patchset breaks the build on
> Alpha.  Perhaps this gets resolved during the current merge window,
> but as you know we can't break the kernel build ...
>
> https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

Of course, you're absolutely right that we can't break the build. I
was afraid that this dependency might cause trouble.

I noticed Magnus posted a pull request a few days ago containing the
"alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
resolved during the current merge window.

For future reference, what's the best way to handle dependencies on
other subsystem changes like this?

[1] https://lore.kernel.org/linux-alpha/ataJlL6L7TrS3gWs@z440.darklands.se/

>
> --
> paul-moore.com
>

-Ricardo

