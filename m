Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AD26E6E1
	for <sparclinux@vger.kernel.org>; Thu,  6 Nov 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448332; cv=none; b=r2YLpM/d1DarhMUjCyIbAMnzdg78GnssDPHwZEmc7NQmCHKYM9vLiTSrCPrbcO7x3a4Fm/OQ1PzIlann4nGYDINezpEUUcc4EcHilMSY73Wy7BmYO/PDyKu62mwA45/BsRhEtKueE6PnhIQ0ZL00eewIhYuWH0xBJWOfp6PZxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448332; c=relaxed/simple;
	bh=BOt4fX3vP7Dk8HqITO4nB06oLQzIotDeNqs6n2sz1vU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=tUvpWZFfJ8tXBe/QZjAY2hy/XPi/Aac/vl4I01VHbj1y7La88iPJCVujCcCczd6GAv61hUvpoxWJ/RUfxnaM0S9OEVryhNFC1Mwn9TDFXtrwjZONCxmhl7WvKwJihCQOMnG90tg3V1f6F9bY6Y0Mv/Z8ME8ilewGrKlePOVG26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTI5nTcL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTI5nTcL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29470bc80ceso14513875ad.1
        for <sparclinux@vger.kernel.org>; Thu, 06 Nov 2025 08:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448329; x=1763053129; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mwdpEtZUkKLd4HieJ0n4xeeNKNrAgrCllkk+QdYNeo=;
        b=fTI5nTcLRGsCSJPGLp+EyTKKBKp85BaumdKq5rsTqimzubzlRRKU8LyQjeYrcAEDMG
         POIzO7r2ls/oyVEQz986aocRRUrmLB/aza+qhqPRdj7MV5U+f9Xj7FtFSE0UsVkTGx/j
         W6e4HmPUQYCUsap0gjZupz4+rLp1j9Gh9dLYsFYJMzxrouIx7QYnWRfiurmaf0OjMzLi
         G9p/1esJC38VzBxBeT98oYYYqatFSdyNRJ+CgO6y1IUeQX/OsGNK+kShZoTmqor+JGij
         nIfinDBaAM4uyYd8sMqR5ZkeKWLit+onELd2rsAhsTM12CEjZyPxycatV0cKHT5KgNhY
         yMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448329; x=1763053129;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mwdpEtZUkKLd4HieJ0n4xeeNKNrAgrCllkk+QdYNeo=;
        b=dZxIJfyUHGaSMao5jVO//WB8VJfnhWr4DOiNN37pgVLcgd3ADi3XOj3PW9ulAwU+m4
         EJCVSPdsoF3k9gRQhmuO0MQQ75iKnzzzOjnsjQtjZVVtyXGewWMc81IMTFSV2kbElxKe
         MPwPOB8t+5Q0Yh0X3woPVhoZz6rLNMkgJDh62blBTSgU11Xf+yxPtU34vvpclMQ0VM5h
         Ehk2tT1uoTAnn8psVAPGqFOWtrc5wdoOdhS+9zTTKG07WFx3Fq+eOHTpV2spmLntsSj6
         Zra/m1Bjk9vblzC/RY+q+kNRZeuPccaMT6WXFVPgVzsJjSwyw5qPhod/9Fu5nvIfeE9c
         QGrA==
X-Forwarded-Encrypted: i=1; AJvYcCW4NHAQ4dRejH5Fac6GRCk+QqpV4JqyGOLodWQUQDMDn2SsXdm0pISrUGl2uKhw5R6K9KVGwxV7XkN8@vger.kernel.org
X-Gm-Message-State: AOJu0YwUfyi9nxBAJD7hpGdfDPf6LLU6SW9lNF79+k9+TH47Q2Vs1hg6
	qzcy7/Pk+fv/y/lhEurD0lGqxRUu4MYuhLxmm4MMXbUyxLjZ0SByADis
X-Gm-Gg: ASbGnctw2MPCBqY0xsqmtRsx9+tjAlONQk5YEmTgkvmsMMKAmEaiULwiAdoyLqiaHpi
	msOAJZNx1LpaNMkO85j8mwOqJwhzeUdd5J5fxqlFvGXq652LdK8Gu2q6DsKtDS09J5fiBftJFd+
	tq/RW3X63YlZd8qtVshe/JmBHX78DdzxmWJklBWl0/fQgoVaK2hN0SjPoTSTHylp6GOTI9aY/2H
	9aK/D3YGRerJLtqqN2o0J5GKz6+8ksgMZom4MvLzDfAMYeLclYiMhXDKnHBSmLauTEE+W5v7oEw
	NgFiHVuNUVArz1WYCEDX77DWF22svan7JNv+1I6950x1Ztcw3yuYBirJSaCHcBEhHtHgzXUDPF8
	KonF3CukfQkbwJ0/ZXh4UutyaCPGqj83vPcWc5Lyk6A4TyWLkY6ZR9uqaE3fF4PkdJ9t4Cg==
X-Google-Smtp-Source: AGHT+IEmGC1fJcE4OAtV0Owu2fNKpRqQY3VzTeskRzxNQPbLVeyWOXOzToL4xIfj+nPDKGb1lmA/VA==
X-Received: by 2002:a17:902:ce07:b0:295:50f5:c0e3 with SMTP id d9443c01a7336-297c00b9141mr3517035ad.14.1762448328641;
        Thu, 06 Nov 2025 08:58:48 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8c880c5sm3013244a12.6.2025.11.06.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:58:47 -0800 (PST)
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
In-Reply-To: <50d1b63a-88d7-4484-82c0-3bde96e3207d-agordeev@linux.ibm.com>
Date: Thu, 06 Nov 2025 22:02:39 +0530
Message-ID: <87ikfn3yvs.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-8-kevin.brodsky@arm.com> <87ms5050g0.ritesh.list@gmail.com> <50d1b63a-88d7-4484-82c0-3bde96e3207d-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Wed, Nov 05, 2025 at 02:19:03PM +0530, Ritesh Harjani wrote:
>> > + * in_lazy_mmu_mode() can be used to check whether the lazy MMU mode is
>> > + * currently enabled.
>> >   */
>> >  #ifdef CONFIG_ARCH_HAS_LAZY_MMU_MODE
>> >  static inline void lazy_mmu_mode_enable(void)
>> >  {
>> > -	arch_enter_lazy_mmu_mode();
>> > +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>> > +
>> > +	VM_WARN_ON_ONCE(state->nesting_level == U8_MAX);
>> > +	/* enable() must not be called while paused */
>> > +	VM_WARN_ON(state->nesting_level > 0 && !state->active);
>> > +
>> > +	if (state->nesting_level++ == 0) {
>> > +		state->active = true;
>> > +		arch_enter_lazy_mmu_mode();
>> > +	}
>> >  }
>> 
>> Some architectures disables preemption in their
>> arch_enter_lazy_mmu_mode(). So shouldn't the state->active = true should
>> happen after arch_enter_lazy_mmu_mode() has disabled preemption()? i.e.
>
> Do you have some scenario in mind that could cause an issue?
>
No not really. But that's a deviation from what previous arch hooks were
expecting. Although thinking this through - I don't have any usecase
where this can be a problem. 

But let me re-visit some of the code paths on ppc64 lazy mmu... 

Looking at the arch specific usecase I see we always do get_cpu_var()
for accessing the per-cpu batch array which disables preemption before
accessing the per-cpu structure.. This per-cpu structure is where we
batch pte updates... 

For e.g... 
  
    arch_enter_lazy_mmu_mode()
        hpte_need_flush()
            get_cpu_var()   // this takes care of preempt_disable() 
            adds vpns to per-cpu batch[i]
            put_cpu_var()   // 
    arch_leave_lazy_mmu_mode()

> IOW, what could go wrong if the process is scheduled to another
> CPU before preempt_disable() is called?

So from above - I don't think your sequence to update
   state->active = true 
before calling arch_enter hook should be a problem.
Based on above this looks mostly ok to me.

-ritesh
