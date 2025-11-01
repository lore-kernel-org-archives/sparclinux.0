Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07511EB9E3
	for <sparclinux@vger.kernel.org>; Sat,  1 Nov 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999771; cv=none; b=ZX+xVSD/0upuuTIt9he0qW1HUlQ71v6DsFXnhKU4JidNt6VSQT1dv+MzZSNSRuNUJldZLErvqxhkPijfgMGSqbQXgM5lKSj9HfHMnkzwRVhsxYHTC/iWInAA04G4tx6mVuC7rPXHC4EIgGGc2VJFEJGNmkepOpfiLSorP8iOla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999771; c=relaxed/simple;
	bh=I8W8mLAe3KzDAv7PEhne9ji0gjawU8UAnWFhTg8FafQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snikcDWldX2jU1J4idg8Psgnytmd8jVzJP/UseB0emmyiAfW5PDgbOj5Z1IVqvbDQr22hmnh4Hg9lSeSocc4e971KfXcyJWH6PzTeOZIiKOFS5CL/CfwI6zoywiWHvGlkU945NW4k1RndfF+vugRia+s0AycTFn7waSy7qvh9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQMSLWUr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZwFJyPf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQMSLWUr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZwFJyPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761999768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iR1r/3xhU7MVcJwVYZUltUXo3c7eUSFIQ+pGKdoQg2M=;
	b=UQMSLWUrkXO0pRNmu8worlMcsAfloA1RfS0gSaJ8hYaZrQeHS8G6qzI1H6FBWx3ObyL3cS
	FP3g4/q9KDVDqqaiOBnF9y7k1pshb9IlvbnKxyuZPllG2xIEbguTmAy9IVadJDjBlPxbpB
	5O1lVBWdk5ES8R5IQRu8hDJhyI54HmI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-W-8Y0myuMbW9lUgGGp2R-g-1; Sat, 01 Nov 2025 08:22:47 -0400
X-MC-Unique: W-8Y0myuMbW9lUgGGp2R-g-1
X-Mimecast-MFC-AGG-ID: W-8Y0myuMbW9lUgGGp2R-g_1761999766
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c93a28ebso346188f8f.1
        for <sparclinux@vger.kernel.org>; Sat, 01 Nov 2025 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761999766; x=1762604566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iR1r/3xhU7MVcJwVYZUltUXo3c7eUSFIQ+pGKdoQg2M=;
        b=hZwFJyPf9NDxNdf0BCr4JBM2+Cie1X1M+REKpow2vSfKYtfNCTgLqlCHdsM0ijtzmA
         rjX42vkTgxbzSV8tiO8eTKKCXvG1BuIT4nlI0XuF2BgWnzvojS0xBlU36COG6FnM7NMi
         AlAxFqIBL0U0eSqenGPIweJ8Z4Nt+scwj3Ep6ylVcE0qaxCfsFOjgCKxNELUtBrzaPvS
         Ry2Q1j6SoKo1Tywaoj6qQBdzem/WDbT6YXDc6YllZjqeMrXufkluWrFo9w0TMIy38DCx
         urHKDN8xFwenW9ith8P/AwJxkBDD8BDIQ4+/aFCzp0/kHZgqE1SbllIsXtNUUrbt8gQj
         IWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761999766; x=1762604566;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR1r/3xhU7MVcJwVYZUltUXo3c7eUSFIQ+pGKdoQg2M=;
        b=FaeyncvxtBK+drkBeONGyMYHtuW+guFcBA/6WbH3J/kc+8ptF67pDGjupVLE/460xO
         MTlD5CLcGIZ5g3N2zQcZ3qeEQr/9extTkjeOHGnPrwn3VxVHkHQDmgcz2jvcPF3K2iW4
         abAlFMQLfNWiJeHv+DWzpOfZvg94P0yEc8S0qX1/OS57QTsBtm2XAs9Nd61U2b/KwhKJ
         /miITARmhCOJTe39QAla/YtKaqMItSDkWX8MpcQNZOKvCerlwxrL9XCvQmESJrCtHBoJ
         2xJi9DBYRW7bgfh3KlNNeMXqP59U+/39Y66+3osIBfg1w3AJ0rAmb/S8qBwI+uoEmO8R
         uicQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdy8Or5Rtv63jQfP3IYbzYwg6c4zrxs0dmoJemmpursa3pDhjitrcaV0VsPUwtdZvk52i/PZCzs9w8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5/8J0G1Wm9S51gjy85Xjru1N4yi/HzEJoK+skwye7oVn/YCj
	XhGmNTAsbxUhCV6ZobKzlCWLJ2m4i3tVARBKo+pmM0Sgq02SwqB23LTh3b74ZA7GjORv20p08pw
	HFe6RE0+SXWMRQmJzCjEiihorjbL58tvnXHUmqIJqvVT5/lXc6mZFdcxOYqHcC9Q=
X-Gm-Gg: ASbGncuP5vt7B0pa+r9y/1Fu3mT/lqdXuxBYf/JUWNMxLHYav9UqKJwK1wGWc6HgEQc
	6mBeINUZv720DVhE2qbHj5dJMWoiSDPJ1qYvgADnOiae4bjUjlLyjRE7pzzq3oztG3Pm1eOyiQ6
	ALjRzEDg72A5nGIY9vGO/HQ412ZBOK12Oe902oJsRoJLfAkqPCaH0NnqSXj7FYLp1ewIqaeY4nd
	mIAdYBKLzDEuHzCfJsTn5VJtfH2HSM4vIYqmGTAKGjPgRtDZBc1kO38P0BhU8TiKFTDmkyk5XOB
	W1mALJBBrghLVTcLNK7PPEzfp+0ml0aaao/9xyEJGw7s+uoIHjRpU+sF635B0Zk2S8/06NaxHMA
	wvZ5Epfmjygn+WbhRwN0UKYT9hlEcRdiiCj25+TxLtOcFJA7lsqrDcZNno7cdyi5QNd/bhAE86a
	9iX/kZyGd5Nc6v4zQwwEj5SHRYrMc=
X-Received: by 2002:a05:6000:2f86:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-429bd6860d5mr4833015f8f.21.1761999765972;
        Sat, 01 Nov 2025 05:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ+TTH/VeYpEYhd62jH/WbFLaTQZ/6xytSCDTH7QTl8AfN9d4nyTXPMxG2nY+bN2wOvpiPqw==
X-Received: by 2002:a05:6000:2f86:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-429bd6860d5mr4832980f8f.21.1761999765533;
        Sat, 01 Nov 2025 05:22:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110037asm9461926f8f.3.2025.11.01.05.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 05:22:45 -0700 (PDT)
Message-ID: <ae1236da-2647-4d53-bf4d-ff8fc32eb734@redhat.com>
Date: Sat, 1 Nov 2025 13:22:42 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] mm: enable lazy_mmu sections to nest
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
 <20251029100909.3381140-8-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029100909.3381140-8-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   static inline void lazy_mmu_mode_pause(void)
>   {
> +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
> +
> +	VM_WARN_ON(state->nesting_level == 0 || !state->active);
> +
> +	state->active = false;
>   	arch_leave_lazy_mmu_mode();

Just one question:

Don't we want to allow for pause/resume when not enabled? Would seem 
valid to me, because pause/resume code should actually not worry about 
that, right?

if (!state->nesting_level) {
	VM_WARN_ON(state->active);
	return;
}
VM_WARN_ON(!state->active);
state->active = false;
arch_leave_lazy_mmu_mode();

-- 
Cheers

David / dhildenb

