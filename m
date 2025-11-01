Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B3A25DCE0
	for <sparclinux@vger.kernel.org>; Sat,  1 Nov 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999418; cv=none; b=ku7vEQAf6iYguGk3QUZPrgrmyqzTTZ/bnoF+vbzUXLeY+6kB4o6LwWfENtZ49LblqQlFdiPjZLxo7n9rhoEDQSz7VOMJzpCYihifnMjqykKMVQSo5PAGOKar8kadYayTyu0MSf2ugzcH6LqCU+ASbJt5vZQxuGSS/605GmPK3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999418; c=relaxed/simple;
	bh=b1AT2zcgFCPvE8GdHf8G5cCI082miZTOAZaPhWQKWHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvAg80bXUlkKzJZ711Si3Fv4DQuZ90I9CZ+cSdh3zE+uGAPrOhYh4/p4C3H5KBBQPKp8RzKNg2hYgYERiybveHQhZiasL9mUAXCD+WAbasPToRt4nHR75X0GnQ8tykYzVDhO4Fzq7Fg8lPcVIVTHaLOU6abjnEyDusxML1l8CGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+pvMkH1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAdxZcaC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+pvMkH1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAdxZcaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761999415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ec0hJUsQTUWsdl6E8s6GRpczB51mwhz+FQUrv1x/BOM=;
	b=R+pvMkH1HJx6jcVYDDjGzxmmI+Rzb0WGRQj1eYMVv/YnnC5LTIAziPzT52op1s8uSV9VSh
	Oa4JsJWsRbBzIax9SizxsHyVDrfPqZBeXCb2Z9C39SmbpNfbF4AQKv4l3pcuBAx6eY5hlx
	NVwYp4u/QKjunymin8YhjTgTSXveGHQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-bQm981u9N3-CkBujUxfp0Q-1; Sat, 01 Nov 2025 08:16:54 -0400
X-MC-Unique: bQm981u9N3-CkBujUxfp0Q-1
X-Mimecast-MFC-AGG-ID: bQm981u9N3-CkBujUxfp0Q_1761999413
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4283bf540ceso1765810f8f.1
        for <sparclinux@vger.kernel.org>; Sat, 01 Nov 2025 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761999413; x=1762604213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec0hJUsQTUWsdl6E8s6GRpczB51mwhz+FQUrv1x/BOM=;
        b=UAdxZcaCsGrsUG2iphEGmSkLLPNXxJ1rIO+mmS2X3LOM5IhKVBlh/SH91WFYb6sSsw
         nxY85UECHQPzzgR5MX8nkqqU87kGTLJcDAqgqttlL22IKjZmzFx0NH1RGEMlSXdTBhdc
         7eZoo4aOTvJweiewPG758+6lCsTN6/QiCFxNQru9Co/S03Plvs8vWKZo0OziTZV2Ybks
         uTcz/2kb716+n+6z2wTVRcs2reoKbheXXm9LK3GqXlBx3EvSD97wK2NhKzavPgav0WJR
         HWAB9Fm8AFJifv43SrCS8IBiwI7+q2X+UTyF01f/Eglk06TaNDdlxr2NhfI/1MblC5oV
         qn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761999413; x=1762604213;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ec0hJUsQTUWsdl6E8s6GRpczB51mwhz+FQUrv1x/BOM=;
        b=X3VyNWWrWvDkjahfjIGCbgeSRVzSK3hLfkpkbL8KxWIOZQUhx8ot4XTKyGxquE6fdv
         sRBT6PLCY8qqU9mdwLsurghdYOWFugDIQvkgPHjoM/iNs62FKZQ+5w3S5vbkmEMyzbH0
         AmLvAqo4OwqJK7E6u9POeqFA835Y17edlXOoO4hLm1WLfBjsK0zk7GHeZyM3XA4EE/E+
         /xiR1gPoJGQuUSLAiaaQ8pvudLg9tQJQeEJnyCxsziqrUy2djMALWEFKWoAK2NP+cjSg
         m0ZKmSzzrer+QQht+3xU8/2fF20TjLpquUgUELhMNvBVNsI8GV7ebAUbxbm7GVtPaphU
         CoiA==
X-Forwarded-Encrypted: i=1; AJvYcCWhNMU8JH7iQ4mq7PCtkKM7EvFGua3zhdk2nuNdj94y4GTDOcFTm+AOAJBFnwe+ilbox7kBopa0uc+M@vger.kernel.org
X-Gm-Message-State: AOJu0YzrgSdIgx9HhVJuTY4xhstUBqFW5734qm0okMGQXLSG6Qp0+uwZ
	wXKPNMAg1l0m2mNCkOCWwc4U3L2H4AG+ILZdlj7kud41YQz3i3VM2pQV+gmVHeifUEmPDi7Fwen
	UBjpyd0GMGWKGVc9+muHtwoPL2bN11VfpD6/WlUA1k4lLVFslC8w8mJgj6/H3JrY=
X-Gm-Gg: ASbGncs1VNp1EuAyQ/zLz3Uyt3ReDM+15oRE0VfboH6K6MNkUMtap2XbC4nQ0ZU/gaj
	OymHLU02K9Ggp86jqHc7ehLAanbRct0s4WfuaS1K2Q0Swhf92u3SI/cxkwZHUyt5tBk17fBclUo
	1rVtqtQPlhhedDnEEOF8O9QGby1vmQ3wkqHDNGGorN2mgUUKaSgRwwiEFQgp1oUdwP/88i3uwWy
	dCPTJW+6kFbtTcRhHnFaot9Azpgrs/LJScS1K0gVVVHWqiH0NRcfqyzuyYpDMEn7GXT7Zn7R+Q9
	+/FXmAi4ko06C2JZqqHfdE4u5YKGOdycfnh3KAFsBB4gzTRsAr07OGiSlxJ1R2XRpmtiJp4VXC1
	cUQGnKY8AFemakuW7OJeGgUIenoxAmqSpyVU0yU8iJMe3NRHI5cMHnauWrSBJZcjG/fNSoCphxV
	9fwkbN75JuchtwBnqvLCFwCMa0tPc=
X-Received: by 2002:a05:6000:2f86:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-429bd671cc6mr4920652f8f.8.1761999412962;
        Sat, 01 Nov 2025 05:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwyu8iCMznl2jxRh8YLUHJ3p228bh0SCAtFEkItp6biokKqMXHyqxQIX3SdYCS4w5abwUMoA==
X-Received: by 2002:a05:6000:2f86:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-429bd671cc6mr4920621f8f.8.1761999412492;
        Sat, 01 Nov 2025 05:16:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c114ca0csm9986764f8f.21.2025.11.01.05.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 05:16:51 -0700 (PDT)
Message-ID: <5368a371-10f5-40ce-9246-d8eeff52e654@redhat.com>
Date: Sat, 1 Nov 2025 13:16:49 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] mm: introduce CONFIG_ARCH_HAS_LAZY_MMU_MODE
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-6-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029100909.3381140-6-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:09, Kevin Brodsky wrote:
> Architectures currently opt in for implementing lazy_mmu helpers by
> defining __HAVE_ARCH_ENTER_LAZY_MMU_MODE.
> 
> In preparation for introducing a generic lazy_mmu layer that will
> require storage in task_struct, let's switch to a cleaner approach:
> instead of defining a macro, select a CONFIG option.
> 
> This patch introduces CONFIG_ARCH_HAS_LAZY_MMU_MODE and has each
> arch select it when it implements lazy_mmu helpers.
> __HAVE_ARCH_ENTER_LAZY_MMU_MODE is removed and <linux/pgtable.h>
> relies on the new CONFIG instead.
> 
> On x86, lazy_mmu helpers are only implemented if PARAVIRT_XXL is
> selected. This creates some complications in arch/x86/boot/, because
> a few files manually undefine PARAVIRT* options. As a result
> <asm/paravirt.h> does not define the lazy_mmu helpers, but this
> breaks the build as <linux/pgtable.h> only defines them if
> !CONFIG_ARCH_HAS_LAZY_MMU_MODE. There does not seem to be a clean
> way out of this - let's just undefine that new CONFIG too.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

