Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46E31B124
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737585; cv=none; b=Bx0tVMd8r5Y/Po4hg6O+2u11jk0atLmjkoUYI/wXdpl9Wh4RC4+5js0ZE6qqM7p1LIV5yXSQFsdry1huSnFhAIwH+5NAZU/Ntj0upO13T3Qb37UjXJE6zVUqbF0y6GEyXJUR7OIGUbhwx7BkljQ83MPp7tAmRa0J8v3ujSRNx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737585; c=relaxed/simple;
	bh=htQYfrQvt/cTrdobxmgH73W4WPpszNwvgv/0+a/GiHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCVHX+NCDKv2ySat4jNU4H8ZgDtD859w8YctzRXO/AaVQLIIjBpajgr9U//G6izUNvU5V2svNokrWu/5anY4Ea2z/gcBt3VWwyjvdRXX1vUGHBZGxRj0kYscqaxr+aizyRrmYlDlK/3vq+dPi/EFa6DuqIBir9YidUlN75d2JmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=P7l8By8+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="P7l8By8+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-affc2eb83c5so365440266b.2
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756737582; x=1757342382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htQYfrQvt/cTrdobxmgH73W4WPpszNwvgv/0+a/GiHg=;
        b=P7l8By8+4XE9YYtGkfhSvUvaLgl4Xj15mlqqx/eQuQkvJe2eXJG1bE8ecAK2W+KnI2
         5vGNhpoVYK3Tu82jRS3+jZF+w/u7KCSdqqPpvRL4KsNI9fhbk0eJdMvNqPFNeYbSsLpk
         ZmyeSRAeyxWFzcAlaTaCEClS+D3lA3tLCZUaLSK7vmduS7tkQinal12YAwjQGJ45sw9O
         YEUDKk/BsZZr5D4grqjRDauozq0hcS7dT7vVQX8zrkHujB/tg1DTt/EoqgrUybARY+0c
         EAWr3CSgV2fuyIUL1fqpg1RdPB9M3lqZKw4aMQzQKjcpV0EZ7fXbeDWH9lhoRHnJ6pw4
         qbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756737582; x=1757342382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htQYfrQvt/cTrdobxmgH73W4WPpszNwvgv/0+a/GiHg=;
        b=nUnPgiXfSxtEMMPJ/CeywjlcKvuTRZi1g/S/h/SZauLttYUQU8mRDIRN8pqGLT2ny3
         1hFlGA3LBQEqZNYf0RaFeguoVWh1IKXFVidWONkbrVvkAj56w+JJUTjav82gEZstjEfc
         kRaRRhxnOWfx/UKJHEGc8iHeroUbS5aW6e5R2U+3DNNiHq4663J8mmUNO4cyIMGZ/Xv5
         YeRltMF8nYv4cDWzcNuPGxGHehOaq4WxXNKV0w7M63DIUr8kQ6jlzvMM63/HhDDVwzUe
         I8NzWW1Bg6NPo/TmyIeMrWv4SVdMTAHFL+SGyYItUA00mGcr8aHBQgKbdiNCfi1NBIOI
         kb6w==
X-Forwarded-Encrypted: i=1; AJvYcCWR5LKXRnB9H3kdsmvCBn8+AxEgF73jhoHASSDkczstkGApxOvo1Ph1UDV4fXYwxChsxuR8t07IH57k@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFPYnAxOd+mndOdEfsgXUzGh5hIldadiHm5zx6DsywCS2LPdY
	L/jfo4INegq/DpYeSbNFLr1/iTu95uZYOZz8wBnGEsddpqmuqr9FvGNpv4SdNjSP1LYdpmcpe/B
	4O0mjJB0bMy04Il93P2kQ/TZpwNQupQwx1dH0lfsoeA==
X-Gm-Gg: ASbGncszVdrwtcGQk1phvqsx7avOsAsL+/nOhl4t76J//GaxWha5Of+iltsM4NKRPzu
	ExoOWnWgsLqLXgN7jE/ksf4m330KgmofTZtjZVAi99nLlE35OPpY7tS3zQqXTdIwD0QArTiYm4q
	iXf86rFwREVJbFGig6HMFmXUNeQJHRmyBAMypEnS6exQKKPLgzZwY9UKwcXuayXsEj8sGS1IYX6
	H9YicSLQtVJMwxqC7ykGxViX/relwq0lTSzoSYjCbP9QA==
X-Google-Smtp-Source: AGHT+IHTqF1JAmNmg2OO5LltznXi0o7wJKri+X2655du84wb99ZGTC9056cINHWh8si0MefDcLENJcuak3msFoGR/no=
X-Received: by 2002:a17:907:1ca2:b0:b04:470b:64a5 with SMTP id
 a640c23a62f3a-b04470b665cmr30691666b.36.1756737581693; Mon, 01 Sep 2025
 07:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-3-max.kellermann@ionos.com> <e509a5c4-f71b-4fcd-9776-6a3d39761b4b@redhat.com>
In-Reply-To: <e509a5c4-f71b-4fcd-9776-6a3d39761b4b@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 16:39:30 +0200
X-Gm-Features: Ac12FXxHU5onUYdItrFe4rtUI2ez9M9oa4kNLp6RrsUlpVm1LJn2X4DtIQLritA
Message-ID: <CAKPOu+-ti5bL6YLfBGMt1=3c6gjLMeBqmHGPD1nQC2J9uU9mPA@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] mm: constify pagemap related test functions for
 improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:49=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> Not only test functions but also some other "getters" in there.

Oh, I thought getter/test function means the same for you. I'll amend the t=
ext.
