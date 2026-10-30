Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353174;
	b=RBiS8QaJr43nk3VlwwBTvFiggbYTCZ6vsRJkjDOHqViCK2iSNUVShrfG47CQiJkQ5dB/
	 CA1R5iPNCSHaZJJG7NJiYfbiceSiS/LqH+kvqOZb4i+CeQks/LlbLlj6cap0rVisy/QXH
	 CgJnKPv6CMTtl8vmPygOIoGHiZu+BzKQ9Q76/HA7EBoPDDEljnDUCW3Qml5Xi5XeXGEZp
	 q62gqKSukNoq91iiM0Vyga/obpiQ7JNPMGigUrIRyBTmfXR5Cae9RbPpD2N6CMb9VAyWg
	 FlWfQlq8pZxmT5fLhvEZRlgl64+P0m2o/5JDsaV3ScVm7KYE4472xBjj4rFgl05M9EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353174;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
	b=xEEFVl6u6psSkXgQKDqZu4NsbfUiJhttPjsEfmm6nYSfSptnDPBy6uvg2jTSqO6tCg37
	 XKwWJ+adtDDs+HOviaI1XCZaJiMw4ITLrKgg2y+mGEhlCbFUprT450izKNxLANjPnMyGV
	 9LK2909qcrSW5HYffFFh7a9TXUwxoAgn5cpfU8SDbaoSw7XXVfBYkPfde/mrKOBa5ajiV
	 nPxkbQQrXm6+9rlTb8NLAxKOs4WVv3kAVZXr7aVyqN+QIenf3xugIX57m3WZKKNkChRiy
	 fgemxz16+V3iscpbvI6VjBhgjVDg3ByFWJe8FawTkB8ncOoCNwls0iRvWIkVKEnsDOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9E606A320
	for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 09:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DB9E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso338849137.2
        for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 02:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353172; x=1793957972;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
        b=EPA96udlxCrzxDWA6aq/Imke/Lf6Km1vcqjCAmLR0po4SKBmDOr9kzwwb9VLdTMqXA
         o0yYf5EJ5LTZtogli2IZ/PpQJMjXVJfg7FB8PQS/UbqiiBzysLPZNjmIAadWME7WqxuS
         643Vs63yJbSMKxXqGHftcU7zf/u/QtYR2Xp5sOeJtDv7ZiIq3gcXl6tbab2fS8TyIDUa
         le75bGgka3JlXD9KWGjHc42k2T0yyifTkv3JNIxY1qCaya+dHc+rG1ZMmbeFYgzc1hhY
         a70h5UPP/HTPKUuBAqBM2jCwzxEHXXKh8r9Eg6tKJYQptpwSOulp7j9OdUYRzUX7cdJ6
         y1DQ==
X-Forwarded-Encrypted: i=1; AKwUvByav7LsEtU7sSMy0XJyV8IhmQnB0yT1eL7hDrSb9QI/mBJg3LzBLkm74wDH68e+dRkeK6Z845Z9gdXl@vger.kernel.org
X-Gm-Message-State: AFq9FYJP26s4y4oFo/vxp8d/R/p0k4lQphuzGuPOi0VhkWzoGc0bnJio
	JV7ZexyTbdc7AI3jRQ7xFgdoR3UeQ5MeqQDMivZHm36Q1bwEFOS4rp4vpS72kgdY
X-Gm-Gg: AYBFou2TTIkIUc8ABPRf2oLuJVUN0296JDuECq++IwCvVs4OhNC4n/onrk822unkV7j
	sRDHCesE6WhRkGcI2w6GKqGuZGyj5I7JdmrYyZCapqMTplqbY8vuD/qbqGyGj0J1DQSW+BMTNDP
	z7a0YYzYwtYQcW6rf+LMeRQt+BDNiQjYDcThuNV3pVIvq8DQIym7y4/Ln3nDAVnZjh7gOJFgJGg
	LXNX5066m8djWDaHbKWeN0frqJW7SO4ebed7EPoyaraP+oTTulP760Ml2nNPBt4kWFvB4PVfIOA
	nusNkjWolgF9k016xadcqdeHtts0GbOdlQtBUbkOaMRHzLGmj2dtzUsXJad1/znI6tv34FZlj8x
	V+YZxW6jjQYwu4nl5k+P9eq/PM4u8GswVnCCNgzJ4aTKLgDNBqU9bTjTmI3u0NExmpnojbAca6y
	E75ISYrGvFSFL2pUu+ZR2WYvrvDHok5e3C8ywriIKqzlyJWHJSkjFSvDroBdFQILUmT4vhMHTsz
	BeJzOBjqMP7ecq0hOxQLy/MIipqBo4x7ZD9LcofKhIdFpz+CXAzrh/l0uHVTvXZ5cQAu6pubFEr
	QHqxcU4yg3VQbvWl8kMAGMBRkYDUAsIMyDtbPYZ+HjT+/Ly+lsQ7HutEnnj4C70N6Tc=
X-Received: by 2002:a05:6102:6cc:b0:7d0:3eca:a872 with SMTP id ada2fe7eead31-7d072711c8cmr925920137.27.1793353172588;
        Fri, 30 Oct 2026 02:39:32 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee39730asm1879559241.3.2026.10.30.02.39.30
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:39:31 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-98ff53fb739so296153241.3
        for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 02:39:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzMogvk36W84cBKoBmpEOu72GoAmEZsVp6aR6UHqDWUBXjiIVc/g3EWwN101XPSAN9KDduAEmhGmlir@vger.kernel.org
X-Received: by 2002:a05:6102:14a3:b0:7c3:1395:a090 with SMTP id
 ada2fe7eead31-7d0726152famr950274137.6.1793353170421; Fri, 30 Oct 2026
 02:39:30 -0700 (PDT)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-3-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-3-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
X-Gm-Features: AclHuK8vFqi3dqWRxr6f8_rNGo4Y5wLrZ0prryPEwyIfD0-s59WP5msq_iDtOig
Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: remove redundant pagetable_dtor() calls
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Oct 2026 at 09:38, Muchun Song <songmuchun@bytedance.com> wrote:
> pagetable_free() now runs pagetable_dtor() for constructed page
> tables. Calling the destructor immediately before freeing the page table
> therefore duplicates the lifecycle handling at each caller.
>
> Remove the redundant calls and let pagetable_free() handle the
> destructor. No functional change is intended.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h    | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
