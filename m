Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6663345730
	for <sparclinux@vger.kernel.org>; Wed, 17 Dec 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986494; cv=none; b=HXY2bCGyEpZ4F5xyUQvSKiI/pWt/U+AeA3+Xo0Fw1Y69AEgdkOrF3Xa0AxjZER3Rz9rEAu5onxTKD+HurTBAPOqAdkrRBlITAS/Hxy+bSD0lziy8CtGkgvWOpfhR2ehNvC5eZ/DEJ2M0ueVJn7VoeeQxauW03YGn0goc8/sFCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986494; c=relaxed/simple;
	bh=PQaplJm3gICXcJ/D8khV8sK9h8Jhdr/PjOyZobO7ek0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=UsudHtjmQq6rBzMJy6tVPdJ7ZGiTLWF3+EqMuznCx9AeADBV6FlFRygjqmp2Kq091+sN6fkO4I8uXkUetvj5x2+QSXRMeSacTlMKZMQNQB6ghao6ODNGT7jcF4lhZLcIEPSs7hOicUPUsKGhm800o8QWP2cb38PAEmjuS94G9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEv5Ge+e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEv5Ge+e"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a09757004cso52513605ad.3
        for <sparclinux@vger.kernel.org>; Wed, 17 Dec 2025 07:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765986492; x=1766591292; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7g6szJSc9qKXraE1vzVnFUR39QDkw3X32snO8YJ7Qo=;
        b=aEv5Ge+edH7Gdee0INBqDnyxmkskUh9ROnT0cLsrfnTQyTCl1ZMF2hSGlt6PSUkRvg
         yjsFCzUAhYR/cLU4oG7u22mOJBWrqKKQDwCF4Q9hvoOsYtw+IyjRbwzG77llrG6FMylF
         z/C5J97K72XgeIDT/UFc+S1E0JtDFpROIfRHR3VQlsFiNziPfjFe+WfZKsCtDu3UIRRf
         saW1ynJGZVVycjHNqh8miz7vRupvZ3+Di3NIlunNXr/qug29l+fX4U4kUrYWBimraPqD
         +S9cKbVZLvz1Az/xHR9ciusZSKPoB+AlOAvcnZF6seh94tp+8h6nug6/5f3DVgZEVZdX
         YzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765986492; x=1766591292;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7g6szJSc9qKXraE1vzVnFUR39QDkw3X32snO8YJ7Qo=;
        b=hc/wuke2QLj+FtxcXOmBn7spt7/yYCKXhtlp+FQlYA4AYhHPsDqdyc/PPtGCck/DFe
         tqW3oVnaPrvSI9BLQyYiEdFyDqCct6KtEZCh2MtKHw5GXS2EcoSTqLrCdgQPqt//G0Xm
         DWY/RM/PnRPnp4fBkMnRpClrHk1uY/jq+tuRIXXoF2DU57ciETsLadDTNjmw23MgG+/P
         vthmjqNVBVqlajVHh5643J/f6sz7fkYil/0nQVZ2nWcsLE/wf1KRE/DVMp3XAFxS9TK9
         r11GeYZyicq+gqBTb1mL7p/qHLgLBU3gq1XCjMKiygIL2W/ILiW8oxptvW1GFAgICbbz
         j/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUiyrOH9/9ZP+/WrFjCV0GphB5fK4umxksPCPaGbYCRo8NqadR48y/P0B0VVWuhYVmDqf5fMMnq3w9O@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8IsDsAbiOBYVFC3TypdDsXh1WjCeU1cC/LImGnCl7LNxuqMhx
	SIqZ3dIk9nxHQTRn8WRK6x0ai8cVdpenOCWyQKobTECvFbf5RpYrwJbl
X-Gm-Gg: AY/fxX4gIxkhPY239H9pJrQPtJPknoaWspWsfB/JJYO0y2IQ5Df7tkjTak+Jj2snvPb
	B6UibDQJfEbAT21pQ2M4buVyyW5VJUtEXeQ24UvnmdaZv9LnDeS0mLchvinaLgRzclaazjDuolD
	PUBgclsqbmrJhAK6UGCkZFDQIXzlPDArudefcPw1MgXDnhe0GUxKIZhev1zc31fSEKMO3HavHCd
	qC4C6QSCgrVL5iY5DxclyAfsy059cvi0T0TaMM8gExiv08DIZtuAQGpqjUKZRi4OGNLJh/d1VFs
	ccXm1YpzSWaHwZTH5s3W9VjwEBwoDSTMS/AXELS9rAazIsqBrDCfHxNxtZK/DCkjtVnit1TAA2c
	DP8xZyxdbgIL3alOwMPyIj/h2d+Ibjzsitw/8gQiZ4+x0YGhkB1qDLcA0Bnb90qy8X9mGDdYGsQ
	RvlcHgEqHR2P3EgiAO
X-Google-Smtp-Source: AGHT+IGzrC8xHoSohluxl3TB8gicGFdkGjx48ZJyAE+fsjdi1rZJJgtl3YetY/wOPW+z2c4mkNcmfA==
X-Received: by 2002:a17:902:cf03:b0:2a0:bb05:df4f with SMTP id d9443c01a7336-2a0bb05e314mr123346515ad.44.1765986491997;
        Wed, 17 Dec 2025 07:48:11 -0800 (PST)
Received: from dw-tp ([171.76.225.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016ef4sm207003795ad.56.2025.12.17.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:48:11 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v6 14/14] mm: Add basic tests for lazy_mmu
In-Reply-To: <ca0da7fd-245c-4d52-8f4d-f8fce4717494@arm.com>
Date: Wed, 17 Dec 2025 21:16:14 +0530
Message-ID: <87a4zhkt6h.ritesh.list@gmail.com>
References: <20251215150323.2218608-1-kevin.brodsky@arm.com> <20251215150323.2218608-15-kevin.brodsky@arm.com> <20251216201403.4647a4f9861d3122ee9e90d7@linux-foundation.org> <f9550d22-8810-4145-aaa8-48961f6ea35e@arm.com> <ca0da7fd-245c-4d52-8f4d-f8fce4717494@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 17/12/2025 09:26, Kevin Brodsky wrote:
>> On 17/12/2025 05:14, Andrew Morton wrote:
>>> On Mon, 15 Dec 2025 15:03:23 +0000 Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>>>
>>>> Add basic KUnit tests for the generic aspects of the lazy MMU mode:
>>>> ensure that it appears active when it should, depending on how
>>>> enable/disable and pause/resume pairs are nested.
>>> I needed this for powerpc allmodconfig;
>>>
>>> --- a/arch/powerpc/mm/book3s64/hash_tlb.c~mm-add-basic-tests-for-lazy_mmu-fix
>>> +++ a/arch/powerpc/mm/book3s64/hash_tlb.c
>>> @@ -30,6 +30,7 @@
>>>  #include <trace/events/thp.h>
>>>  
>>>  DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
>>> +EXPORT_SYMBOL_GPL(ppc64_tlb_batch);
>>>  
>>>  /*
>>>   * A linux PTE was changed and the corresponding hash table entry
>>> @@ -154,6 +155,7 @@ void __flush_tlb_pending(struct ppc64_tl
>>>  		flush_hash_range(i, local);
>>>  	batch->index = 0;
>>>  }
>>> +EXPORT_SYMBOL_GPL(__flush_tlb_pending);
>>>  
>>>  void hash__tlb_flush(struct mmu_gather *tlb)
>>>  {
>>> _
>> 
>> Oh indeed I hadn't considered that arch_{enter,leave}_lazy_mmu_mode()
>> refer to those symbols on powerpc... Maybe a bit overkill to export
>> those just for a test module, but I'm not sure there's a good
>> alternative. Forcing LAZY_MMU_MODE_KUNIT_TEST=y is ugly as it would also
>> force KUNIT=y. Alternatively we could depend on !PPC, not pretty either.
>
> Does EXPORT_SYMBOL_IF_KUNIT() help?
>

yes, that make sense. Thanks for the suggestion!
I guess we will need a diff like this in that case -


diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index fbdeb8981ae7..ec2941cec815 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -25,11 +25,12 @@
 #include <asm/tlb.h>
 #include <asm/bug.h>
 #include <asm/pte-walk.h>
-
+#include <kunit/visibility.h>
 
 #include <trace/events/thp.h>
 
 DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
+EXPORT_SYMBOL_IF_KUNIT(ppc64_tlb_batch);
 
 /*
  * A linux PTE was changed and the corresponding hash table entry
@@ -154,6 +155,7 @@ void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
                flush_hash_range(i, local);
        batch->index = 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(__flush_tlb_pending);
 
 void hash__tlb_flush(struct mmu_gather *tlb)
 {
diff --git a/mm/tests/lazy_mmu_mode_kunit.c b/mm/tests/lazy_mmu_mode_kunit.c
index 2720eb995714..340d7cda9096 100644
--- a/mm/tests/lazy_mmu_mode_kunit.c
+++ b/mm/tests/lazy_mmu_mode_kunit.c
@@ -69,3 +69,4 @@ kunit_test_suite(lazy_mmu_mode_test_suite);
 
 MODULE_DESCRIPTION("Tests for the lazy MMU mode");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");


-ritesh
