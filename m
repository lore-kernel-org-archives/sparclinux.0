Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12934D90B
	for <sparclinux@vger.kernel.org>; Thu,  6 Nov 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448946; cv=none; b=NN+aMbhmMeWw/MKPTCtA4wpmRHYTHoeddRpKu32Hp/eu+2ECZ+mbWgHdjP+DCA0UcqgdWSqTwhcuezA2IZo0M4T3SOjP5XzEKRidoXrRqW1FwvQ0af1lh0fQTpKZJ4S6OIAbd0R8MbThQ8Dxy6wju9TJbw1p7k0jK1J4K2RmOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448946; c=relaxed/simple;
	bh=brTwyt3ALfzwXTTOJDXGAi9yS9jEzrppUFzQdw+ocYk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=MuhOF55rfBIApMwkBHCKz1ewGwM1My/D8M20TkKdkqGlbbRCVDUwSUJ3EaZqCFR2u3PYEJF06nXRjBXaKjPx5UUW/N8m7fMFHSMTxV7vQhBuUgvjMpxQt4amA2lCNS2ZaF41TES9KYr1Y/EO/sgxwKoumIXeOqYGazZTD85mgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOdGsbOb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOdGsbOb"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aca3e4f575so1117706b3a.2
        for <sparclinux@vger.kernel.org>; Thu, 06 Nov 2025 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448943; x=1763053743; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nxXbjl0HhdoITaZBDxLqmLJTjrhCiLD5WEPTG0leRLU=;
        b=VOdGsbObG8XS2cOV/oYGc6509C6pplAtbg3R/s9fYoV/Y7NElk8ISvmQH5MXg0zHRn
         H2VHstJF/sP+ldXVTkrRuSVf5bWaMIUBhg+DsqODrJ2XDvywK/VeWTJPb4TpQK1FnuuN
         gvjpENQYU5sonetuDZTa/Dbeq56zYz5q7NhtomkbwAyYs+h0Jjw6NN1oalLAJEw/2AMm
         OEp5o7ey6EsJCw4mH+HyTihqHEHbja1NnhyMqRRxRYfF8ArU8Lc9yd8EBX/bq7t5qeVv
         wBWDoNRNM2QbpXSl7k922aAWxH51VOj/gzpa9JGoYn6o4XzyjnHXfxDOcIe2srSrsbTn
         N76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448943; x=1763053743;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxXbjl0HhdoITaZBDxLqmLJTjrhCiLD5WEPTG0leRLU=;
        b=sotDWA/DIpAtGp7E5AbUHlTmhuMspieoua1P8rkr5Y3EJ5kIqO4JSwFaG4WNjeoTLP
         BGPcjMYTwimPxeKzmwqVLNaq3B5ijyraxwGqEicCivWcab7xytrWjwaK0B6mVEQvMUt+
         DtN/x+YFCgwhSpECxEVLgeUL0vsM+LxkX9q4X8JdAR7nIXeQ2/5olSfNVMEqUlYCBfcE
         emG7WipsuDF7DAfhYfYkP5b/c55ReKAO/Jvwgq6hj/nilfApIj5AiCeYmbiibrnJZL7R
         W81uSqSvREQvHQuyR9b4XKgtpx3VYkzpN7csnX8j4RgmHdWlKDtOzbwbFP7V65AqaQrw
         4kPA==
X-Forwarded-Encrypted: i=1; AJvYcCXws6yMhP+skXAcNni+dkbjbFfaMHnAvkGtI6V28VMjI+DnSTcEgNI1Ldmt9n6bY556mY8wVwU+bUcI@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJ2iEgqlT9zfAXB9Jkm5oRnbqjYvP/FOA+MLjdswGMq1BgCk8
	c17nRFQJ0dP/irRVUY3rMczXwM3iopW9dYKAv8BIt0gq8V+N42zTSEEd
X-Gm-Gg: ASbGnct46XezuG34nyOW+KVubDE/5WepgiEZinJ6WiPS6OieYrYitTFUbygQpaXDVSe
	YRUCjaWCezj1rb7vpJjrtdElJAFCRgLSBH3xw47BF2ygfbNDDO6e2vgxhA/1LcoRd/iIBIO5EHY
	U/Dw1sFhYmlvPhcfTJnf9Rm+CKdeTOXMtnY0Kj7fTbA8EIe3rqaEAdSpBk3HZPGfZqbRUmtGhF7
	PEiLD2UHmyp7sTDCSgJ0MPuPF8+tlyDt7ExejY+tJ3rLJadlPl8hm/CDxheJtGHvIFsu6H6w3cX
	OGiorCBSGfuBrwGs6qFOe6eITh2xw8tiGx/GhAHVKNZxS8MHQRbpPUyXFyTixIVVIoCcX3yOv1O
	qZoWJqA1o/QkCPaZGz6gdwdNf8SdG+ekml1gQUNOwMwh9OwsGN1u5Gx9EP22ZRSQtFkzrtA==
X-Google-Smtp-Source: AGHT+IGcGbtG/gxArci+CopvKuv0vsWkSHD0Cj0H8EsVfNgzuLLOXCCQpVWCS8AAZU2IHguSNAAo3Q==
X-Received: by 2002:aa7:88c2:0:b0:7a9:f465:f25 with SMTP id d2e1a72fcca58-7b0bdb856abmr331762b3a.27.1762448942695;
        Thu, 06 Nov 2025 09:09:02 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c0874bsm68007b3a.16.2025.11.06.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:09:02 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, 
	Juergen Gross <jgross@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v4 07/12] mm: enable lazy_mmu sections to nest
In-Reply-To: <87ikfn3yvs.ritesh.list@gmail.com>
Date: Thu, 06 Nov 2025 22:31:27 +0530
Message-ID: <87h5v73xjs.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-8-kevin.brodsky@arm.com> <87ms5050g0.ritesh.list@gmail.com> <50d1b63a-88d7-4484-82c0-3bde96e3207d-agordeev@linux.ibm.com> <87ikfn3yvs.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> For e.g... 
>   
>     arch_enter_lazy_mmu_mode()
>         hpte_need_flush()
>             get_cpu_var()   // this takes care of preempt_disable() 
>             adds vpns to per-cpu batch[i]
>             put_cpu_var()   // 
>     arch_leave_lazy_mmu_mode()
>

Sorry, here is the more accurate call sequence for previous email.

caller()... 
     arch_enter_lazy_mmu_mode()
     ptep_xxx_()
        pte_update()
             hpte_need_flush()
                get_cpu_var()   // this takes care of preempt_disable() 
                adds vpns to per-cpu batch[i]
                put_cpu_var()   // 
     arch_leave_lazy_mmu_mode()

-ritesh
