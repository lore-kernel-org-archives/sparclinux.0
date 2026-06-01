Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C1379C40;
	Mon,  1 Jun 2026 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317527; cv=none; b=WPkYIMIfCYfeioln38OLDK5NIbQ/vvP4mW5j4VNzZbYNTxeVooEo1JvYADlj16ap68+cwvW88TPkWl0lKZalK/0H3WYTkcOPJix7mDuequNdRYexFDpDMvhVl7Dkatiziu6u2sB9vPFLNEKWu6J8+ELYUBLCLuieRF2KSJX1bWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317527; c=relaxed/simple;
	bh=3az3TjNqqZkuQgZxxRqhlxK+9Py9j+5itmCceE1yE0k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M/W8VkutrK98TZoz3dhrkdPMCPnC40im77wYfT0s0WI6YESZrZKouj5WgwJJH2IcQCtlveb2RL5ZYP/92l+D8hGvdHdpM8zizSbpQSXjy/3qm05qw9zALnpamgHO6xDm3eanuBkht4y8xLTj5h3t7Wu22zWl5cXH08+m4JM32Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t9X+k6Pk; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9X+k6Pk"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780317513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8Q9MsGaEY5Id3cDoyk/LMPpb+cY3ipFpIzkjqGDFMo=;
	b=t9X+k6PkHR5WsisChw0O5VpIHYqYLwjr9DFuC/tgFLuN5u0rKS+6y8bhT2MX1ghqTZTr+n
	DuMVk9niJvJLHdW7PBgKF1COtMWreGWe69fkyAbs03os4PWMGg/jK82UDtSe59liiNNRDy
	2uJ7I61UVj726QpKC4J0NufWJLLoJoQ=
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 1/5] mm/sparse-vmemmap: provide generic
 vmemmap_set_pmd() and vmemmap_check_pmd()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <db8d440d-c8a1-4f77-b5d9-00bab8737f12@kernel.org>
Date: Mon, 1 Jun 2026 20:37:42 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Andreas Larsson <andreas@gaisler.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org,
 Alexandre Ghiti <alex@ghiti.fr>,
 Albert Ou <aou@eecs.berkeley.edu>,
 WANG Xuerui <kernel@xen0n.name>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D4AF42F-37C5-4A76-9703-44ACC6374C48@linux.dev>
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
 <20260601084845.3792171-2-songmuchun@bytedance.com>
 <db8d440d-c8a1-4f77-b5d9-00bab8737f12@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jun 1, 2026, at 20:22, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 6/1/26 10:48, Muchun Song wrote:
>> The two weak functions are currently no-ops on every architecture,
>> forcing each platform that needs them to duplicate the same handful
>> of lines.  Provide a generic implementation:
>>=20
>> - vmemmap_set_pmd() simply sets a huge PMD with PAGE_KERNEL =
protection.
>>=20
>> - vmemmap_check_pmd() verifies that the PMD is present and leaf,
>>  then calls the existing vmemmap_verify() helper.
>>=20
>> Architectures that need special handling can continue to override the
>> weak symbols; everyone else gets the standard version for free.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> v2->v3:
>> - Replace BUG_ON() with WARN_ON_ONCE() in vmemmap_set_pmd()
>> ---
>> mm/sparse-vmemmap.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 112ccf9c71ca..99e2be39671b 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -386,12 +386,17 @@ int __meminit vmemmap_populate_hvo(unsigned =
long addr, unsigned long end,
>> void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
>>       unsigned long addr, unsigned long next)
>> {
>> + 	WARN_ON_ONCE(!pmd_set_huge(pmd, virt_to_phys(p), PAGE_KERNEL));
>=20
>=20
> Not sure if a VM_WARN_ON_ONCE() would be appropriate. (then, we have =
to move the
> pmd_set_huge() out of the statement).

I think it might be better to keep WARN_ON_ONCE here. This way, we can =
still
monitor for warnings in production while keeping the code simple.

>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks.

>=20
>=20
> --=20
> Cheers,
>=20
> David


