Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFBC3570DC
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739855; cv=none; b=hojJmQaYbxiHMPf8FHwRAaliGPGmGY0GgsLzb//Y5yM7oeOIWBbY+19hWpjL9nwpg5h73ev+P/Uf16otK+CGHSG/2cJKPE8eyksid1mXwh2ZlG9kB1c26/Yv7qX8f3mkndjV7d/S4PJkeYzejy+toz5l5dQKsx0aLK8jibNdEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739855; c=relaxed/simple;
	bh=2vLlsr7X2ia5/OeQs8olHZPr7msI9HcqjAeK9e+vndo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cygGsYML+AWUlz4ajChjjZlK6p4Ka6u16U3Tbhup1uVsgxV0SBdfP11UuyYAKp5hNT00Fsum3FzQoHvScRJDht+lZqQC59Hw5K0wSfd3+HfzASimb34x3ruEpBBuWqYMMi6H4jLMZLfZA2YCe5eoh14gAFnHqa+j79fscv8BtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cPcrYk0l; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cPcrYk0l"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b042cc397dcso134851766b.1
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739852; x=1757344652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVsve/IFMKMWGwAEF879SRkVfMnyldOnTnxfs/L/xuQ=;
        b=cPcrYk0lG5/RAZ05cjfVkLhN1nU+ecgWhsvk7sRT53uzQ0dDFpRoU7ekOVKMTIkWPW
         6KJyY2UdEnBKa3nVLfoaqpb/EBxhsip9d6ROXKlZJ8wqFVVhP1m4iYh6CLeBwIszbsl+
         6TMQyrJKwl+uXZgauZZQ3A7E/zYQWmxOHnw3vgVIfmspqvLcyM5OmBBRG0mdq+7BtODP
         jM5EEiOtv26L+BBOm4zk1P/EmD7gETyl+6/EmhQJ8t46YTZShwNvxdBX7sFOgpdH04Mc
         9Qo4nIXVsmyJX6AMEG7VmpPn8JuLNgE04VTMNj9Uv7LINJ0y4uusJvQCxtG9D905umVS
         BQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739852; x=1757344652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVsve/IFMKMWGwAEF879SRkVfMnyldOnTnxfs/L/xuQ=;
        b=qKn5kB9Ry9sUQKfLuVLsUEN4rLORywLdCXCyGjy8RJnFIYrdNVde0Q7REBe0X3EHBE
         kwPzaJ9OYf0+U6K3moBZuqYzg7K8b5R3VJYppcQ9Q1TPrgJfWZ5zYh/km32eM+LLZ/Zs
         4QItV3JDNRLFfSmEeyMI3scwo+hxHuBeWurqgysLtcmuxqcYwXW03yWBoPA4mufyO/aJ
         TYaUvhdcKd4vIto55z2d5iT5DZ++A5W7F7nztnUf7lrd/hT29XWteZ5piHIySP9ILe6k
         SQhUtYKMXp529YKt4rRpB5iFxVt6IMYd9gkaLMQn8pFcNCIfKVak7GR14NAnxX/jiYu8
         nPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeLxl1lBtyLmX0Gb7ChpstYdTM/j2VYt4ZEZeh2kKJSkeGPZa8g4DCL1jEiYOqtu59f/YhzQKOeaKc@vger.kernel.org
X-Gm-Message-State: AOJu0YzWI8F0w3yoh+1/j8xSynfRVrGrmnw6fXWtimCuqK6aKyNeK3T/
	4J7GxWic/v4tGn/1Bn4QTe6+rrgtouO12/FmrrexXvi5Ng1JznJsOUWeFwOpSXcRPss4clUGx+D
	3zF1TxOFpO8SGNNWyfzmSn8mW84Kh3KE5SXpSG12Cug==
X-Gm-Gg: ASbGncss7LkmtL54XRA6dKvvpQUpEb0p5ntYShs/7JL0L2YW8shURXENDaPTPxIzfUK
	HmnQNmjLTTK+McYuf1aD42C87dtirwU2HPn402NeVlE/I5vGFVPqMPeGCse1YXUMYfmPAPS68uv
	Ms2S1yXEXIANm7OR0I+mxr+0+jTLBMwrg+dZCiGgr922Norg65RtdCbgYwgyy8al4cKK/On5J/x
	GvOglbB/vCYgaTIXLgPrtmJy/0JttQt9MI=
X-Google-Smtp-Source: AGHT+IG/xTCJ9bj+alHxnm8uZcbqfurR+IyDtwLk2ZtZW9b4+JSGWCUUEu7vdYbFqHJ+Zaxrj6LPdykdWiyzaO+0sH8=
X-Received: by 2002:a17:907:d8d:b0:afe:5c9d:c7f1 with SMTP id
 a640c23a62f3a-b01d8a8b328mr935024266b.10.1756739851758; Mon, 01 Sep 2025
 08:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-12-max.kellermann@ionos.com> <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
In-Reply-To: <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:17:20 +0200
X-Gm-Features: Ac12FXzbdsR-8kES_4on1Dew__ksXVksfxEkYJjm0-lwqH8RlE2IsInEJr70z8I
Message-ID: <CAKPOu+8xJJ91pOymWxJ0W3wum_mHPkn_nR7BegzmrjFwEMLrGg@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] mm: constify assert/test functions in mm.h
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

On Mon, Sep 1, 2025 at 4:07=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > -static inline void assert_fault_locked(struct vm_fault *vmf)
> > +static inline void assert_fault_locked(const struct vm_fault *vmf)
> >   {
>
> This confused me a bit: in the upper variant it's "*const" and here it's
> "const *".

That was indeed a mistake. Both should be "const*const".

> There are multiple such cases here, which might imply that it is not
> "relatively trivial to const-ify them". :)

I double-checked this patch and couldn't find any other such mistake.
Or do you mean the function vs prototype thing on parameter values?
