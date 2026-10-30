Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368087;
	b=dq1im2wEwdE8F3rch4ZTFH8VPgnthIGirPoh/1hyUEdYhw9L+jmp1BfpWiRyYtSF2neU
	 sQn0KYEYDhbsdWBHWNaesT3aZC9/2004xn7ZzS5E6BNHFzAk3FSBEoeae5iqdg+l4DqvK
	 KSdZqJb/++BmzzpeoiJYK8j0kOB2wGy01A5pvr4wegjRq04BM13I5NW0o5vqDovrk7Cjl
	 LpqmiBaFW+zNaWH/3KGTY+09GRmHqMXyg+N5U4e+0rROJnTgXjiRvH2TC2XRbucM9f6kB
	 QUL4wDRVqMJ3QaaemmSBPaCqdIZiLcBKVJa9bAItwRq0clLqVapnYiLPTzOjrj5lAWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
	b=kysEbph0dhwcFNwwhF05WEGK+UhsE/oHdXO4XfFX4RIuwJ8dJBz+WvE6blK3KxxQsB7i
	 o8gNCKseFLCLphPesFEe9Y1sFk14JPj0coMjZ1X3ytohjuAeoKQrLK+fYocCW584gjZl0
	 M/vh3NyVzt1UzfvXOlyFkCyP2eP7JH/7my1BuaNRXI7UdbrLEyI2n/r5+DnAqCrg1T1sA
	 rYuEot0c7kG2ZmCrGN8LALxQFUAkXhxmZEBtWdlGMrK6icOUcGo3rktZ4gEfIg/av4O2y
	 2XgYvxW7kHKgT3E1oCBv1ZAE2abLvjQX0Z76GurjxuIbpPv+xFWA18bHk5EJgz9jMMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0o7zm7K;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A61606A322
	for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 13:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A61606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0o7zm7K
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso6734375e9.0
        for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368085; x=1793972885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=P0o7zm7KEPIXltx3NlgMQzHQT99NsbdanhX5hUYiA8mqcXpAtEl9r+/7vE4Ggfb6xQ
         AjDmKEsJCN3A9nhHSHYQq86Tx9QzgKkEoL+MNKiu90Y6d/c6qq8wEeWDbGqZ4zOp73t2
         V+jiEVsBNp3JryoT0gq/L7+LKDEBausQ7tqgfI+sigyrm1PvM7UpDQc9g0naBiUQsKsm
         txn6SCcpysT3ZLStg89zxyyBWbPd9BONg/H56ElBDxvktEsTFh0x/DFDQ8EoFwz5gpkM
         +r9npc2iAjvhv6WuZ+vHLzVgZO3yPFE7oA+XMRoLdTuvTODgouxb21kNS1YSNNzhhvRI
         MLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368085; x=1793972885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=LtFgZHFHWcmpoqwbuV2Gi8IXCH0JREBPmY2jYqC+AjvVfR85MojCpM6XeTyfovlSF0
         hdD/yugGrtIqH9EWyWr26/Y3W8iK0ip0CV4vdCQK0d6ICh9O03RDExH78MITN6oI1XcC
         038KjnzdbMAzLuHfeIAUOLwomV+w07piIyR6HbbQGwCt8c+oGrXnMLkD2GTG9RmcDvNa
         De7rQfo3rDvJWTiDzSVz8pNOFPVOPVAttvfWjvAPSnyF3U2nKPEvK/h9MaQVINudg/sN
         9Cp/Sdt0D1l3x0KuUaLOCPmkJxxWgA2ndAS0Ud2Y6FqMizqxIlNfIdggp+mvt4+qJ4MY
         QR0g==
X-Forwarded-Encrypted: i=1; AKwUvBzDPUQ7RkyQ/pj4svjlYOonltqlIZ+4kt3MeagHsNQj8wL1JUPbPVEMcLpxhzds/pSZ+8DHlUq0scDf@vger.kernel.org
X-Gm-Message-State: AFq9FYKBgSZwW2Lu7RIeciB+0g6Z23u7W+6wMq50L6LTeZYIQonXEp8q
	OrhT1L9NMgKsRcbwoha1tPJ//Iub9ji1K/jP5Ro0lNftXmF9IHak1z8J
X-Gm-Gg: AYBFou3a7hPyxpGKQsDI2pmy4IM+AxQhmyzcA+5e+q9teel2qV5RtPJl3GfSuRCxqaW
	Tus6mAZNxqyxpt0fPv8XVWr4m5ZSU63PutjH9EWEWgordlcWJj8oW/R9/C+BYsE5G3Mc1Z8AwfN
	Mmg6T83OECSVzcMEGPyZ1deJLcoBpPBpy+RARcPSqtm23e7Lysa2EtHbcOIuirWUSY3T1djL44Q
	WfDLo5AGF4Er0qDTOO0GyekxyLgZqoeEOoLnEo/aXkdbcNmEA+nmNF2WSIT5VLzWfdp8Td1ZwZO
	ZYRT6fpxOxy32bLfWs4gKhE47eGqqmBiGN8OdYKmUH/mJR3SQTfUoyqFacxZ08lNGRmL0cCnBId
	XLjATHhNONEBlwpKkNkioc8iaJcU0W2wT47uNjDLY/Lg4GgS253Ke2exQszfjAT1uFRxNrg8f67
	JOaMLv29Qvklfj7vbHtiBOu5dddSdnqsbT+CP0UFVWgeyTpbsb0KdROVnkIe0d5u54PAyD5foKq
	QGVZBeEWh5F5IcWPN/YHZNEEcGwOURI0kvzz6mHI8OQzkD6smZXS+PQ5aWyrtmLOhrPsowygMF4
	VEUJsgnIqe6t9PXbhE6J6vounv0N1+fbb8QzE3dReUkkgXDEZIh7pM0pB18hoXMydXntrpxcEgh
	8YdJzGn2+MwH6hw==
X-Received: by 2002:a05:600c:34d1:b0:4a2:526b:d3fd with SMTP id 5b1f17b1804b1-4ac1793fb5emr50752935e9.15.1793368085145;
        Fri, 30 Oct 2026 06:48:05 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([130.43.154.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm172048905e9.15.2026.10.30.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:48:04 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:48:02 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Message-ID: <auSgElFWW4n3sJLb@C422HJQPQG-Fractile>
References: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030083800.599152-1-songmuchun@bytedance.com>

On Fri, Oct 30, 2026 at 04:37:58PM +0800, Muchun Song wrote:
> This is a follow-up cleanup to the page-table teardown fixes [1].
> 
> pagetable_free() now invokes pagetable_dtor() for constructed page tables.
> This makes pagetable_dtor_free() redundant and leaves explicit destructor
> calls immediately before pagetable_free() duplicating lifecycle handling.
> 
> Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
> then remove the remaining redundant pagetable_dtor() calls. This keeps the
> destructor decision in the common free path. No functional change is
> intended.
> 
> [1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com
> 
> Muchun Song (2):
>   mm: remove pagetable_dtor_free()
>   mm: remove redundant pagetable_dtor() calls

For the series:

Acked-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>
