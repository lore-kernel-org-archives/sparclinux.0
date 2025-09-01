Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE2320A2E
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739598; cv=none; b=RjEsSL5EHbVyIEV0xsRqeHbg1xXmgCXRSeKksA5aNWSkE/f0PIcuX4LdRrAEc8VB7KF7on53lRYt7UWj/qALy25rEuqm2g9M5GXZG4znQxscABHXwQppi32AUYGw17dIf0Yolx+IEU9YApZg3HxW7czMetSOXPYIsItcL8ACLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739598; c=relaxed/simple;
	bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrzJyE9720x+Z+tBgh8KE0IYQNTWbNdsI95SZj2c0xCw8BPUomBYJT/DngTNJLMijLta0sveZe0ICfSJeAr4S10EPs3/421u/FubOYQt5avlO3rGLl11VJ/77Ww8d1a4fNLyqvZZovB3bt4/4j+tPqvT3fDb9kEm4SqhBBftfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cd/cMr3m; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cd/cMr3m"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7322da8so869421766b.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739594; x=1757344394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
        b=cd/cMr3mBFUKj/l85MxxINGe2ZL/wWXCouUOLF2P7u7Sbb3G2TSO+T7MMjaT92i8ib
         xVVye2DysYNSVHq8tJ6lKA4Lfe2j0OP/3aSBx7XrTl+MRwh75YHhMdSJp9YYyfIHRO39
         Ac9SPC5f1PEpMwBCrIbTUQfFNA7/0Z1pB89UOn0AWo0ZV/a+e7jGsUznoZHpQ+8lCHN6
         celxCU/rqMtV7FgC/CvN4UVi2u3gRCZv6iXKZLyDlHC0rFJR2xSaHcZV3AVn34Oi4Har
         ypZu2Kxo7s7oPnvu1oreYhxXi7Igh14F5/Iifs9vIPSXDKTC+a/3Mqq+6OB11kxfPlUU
         R08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739594; x=1757344394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
        b=dSOeRWJLEYB+03SsH+iuWxWm2AA5zfkPini+lmmmiXoqYg3HV4r+8CBymn+WkrBVa9
         786/Jq/VRR6Iqi/G+imwzK77bvWHnhzGqo09uP5d+vvC6zRd3dICs/morJcwx8w999h3
         6oJSKNWrxwdxoKyzkEShKPqIUSm+OHBamcMjyy29GkgsJAsW5hc7vqkMiWyR08cxUEqU
         xihXrxuTxJBfEEompfYeK0gQ8v/UtT2x3lV4upZmcUw1h9BrLhwODLWsyT+zrl2weLhU
         jSmbNWi6sBtTB+UCMa0awrg/mZ3KXH6sO9pwy9Iibb/NvZt/FExuRKoCj225JA2p3Clk
         xlNA==
X-Forwarded-Encrypted: i=1; AJvYcCXvfDk182IyghnCM2U+sXuIxG333yeyZoZU3SfuYo8kfF0dHb4ULS5SeMuWV4+PNBeEhyuDe6jquFvK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eC00/hVQaDMn8MA9IkLzeNXl2cv7BMkcRGdSeZKciTN5dc9M
	5S45jHfwDA82C1U4S+Tj6y1LFqVcPClRDaFByMa1GBc0qgG/NQvsr0f7mLexHgdg0PywLUhGVKa
	oUy7G/+b3EF6QK0ef+ivGbAiB2eMErFVFB1xDSNMFgw==
X-Gm-Gg: ASbGncsj21+vhe/V25cF3Y82fTlG6dQXD93l/smjaqwH1ANZ+ft3GrUnLyWV3vRMRZr
	WSCkbcWEXQ4NCHmi0AoGAmBwZNbtICy/I83I5NamSJ6aA/y7cZ0pyhUOWksOHbYpT2bJzY6LSNv
	9K9x8yesA1DtFY9ejswV9QrOt5U8HTX3ayC3KYxa9dDl+dJEgfgGAAaVMQYYVXnwkeBf9TIM5ld
	pvA1qRNFq52NNlBWsLbKrtgUMlLfztN0bmSwypAYREoAw==
X-Google-Smtp-Source: AGHT+IEFPWeGuNqM2+QiOgw6fHvRg/b0a6N13KZkb/trfYqooePyXBS3syenI4NwqPjQnySBBQHmRMnR+cpdOfOLUuA=
X-Received: by 2002:a17:906:9f85:b0:afc:cbf4:ca7d with SMTP id
 a640c23a62f3a-b01d979fe6emr930093166b.54.1756739594447; Mon, 01 Sep 2025
 08:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-11-max.kellermann@ionos.com> <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
In-Reply-To: <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:13:03 +0200
X-Gm-Features: Ac12FXzpx0s0QI5qZl1CeOcQ-w6EceVXiGl7R5sUJVErAX6WQ0b3KxehR5HEiuA
Message-ID: <CAKPOu+-zBstZVw4LjKz7ZQyTh_PKEJXaWYsgF0-E0+shAaTvwA@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] mm: constify various inline test functions for
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

On Mon, Sep 1, 2025 at 4:00=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> Also some getters hiding (and functions that actually implement logic --
> folio_migrate_refs())

Indeed; I mentioned that one in the message body, and I thought this
was good enough, but I dropped the word "test" from the subject line
to avoid confusion.

> > -static inline int folio_lru_gen(struct folio *folio)
> > +static inline int folio_lru_gen(const struct folio *folio)
>
> *const ?

Right. Added for next revision.
