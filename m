Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353166;
	b=40zrk++YCo7Ki8C9MvMCIVHXbEEAc/IDPPufyyfEYJWBrCrUe4+wFpePsffWPOiDO8kB
	 GjcAgJFEC5PcY+0EYhqqQs2ZM0k7wvT/pur/cEctnPKfmVcktw5jSV1rWjEm9MNMetdgC
	 vPC9x1Po3EHriMFr5sMNVNt/QmpUVKDl0VhCeAV4XguTKE2thzSEgDJpbyKAtpEWwN1ov
	 Hcurl6KWwAAwgpVFRU2MYu1L/2jwk8BnWFPvJttoW2wX88CRotpQc7zLlx8WDxoS0k8/n
	 cJBIKzxYB/itq4I2WEudEepE7NyDpybIRKsJTzgcXmtm/cxi95KlTzGp/PNgOmsxD5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353166;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
	b=qs8Hytl4ajqJKAM4hs6wPFFejwyce+oz7j146JYBez8+8FtzDbt56Zuxej+UkDHZdOrK
	 uf4wWWoc9YVwj3BcaQ6Pu6KwudCZlaFlF6b6DhrI1WY80+JcBpv2ZGN/iYIrmphGJo6kM
	 /W+NKGJ6yWAV5q1Dkh7G7pxcJqQbaSF/0tWz7gT5SijB3lFQo8Qp3owROdy5kefsHYb/i
	 5TVf6YA4SWd8qh2rRXIkqVPc1DzA8ib8U3E6VcD7ayEw8Ba5FrepqE2MJmkvGgcNogou4
	 KOLeXcS8dfCFXWtndTj+HRxWDbtrgosEpT8gYP75iG0GL8tg2PyPQX/KKforkPk4q5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F47606A31D
	for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 09:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25F47606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7c33cc572e6so448346137.1
        for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 02:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353165; x=1793957965;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
        b=X2ZBWf08Nhaqt/IncG7lj7A5vmkKJfMhr5q7obu/dsndKeo7vc35IDkjNJeD/LnpBq
         XWLF6Qog4OR+yx1qmjZiAvj6bXIo34hlcWqX3vf/EcTie0XgiEU3iy9V0HEiwJjc+SLc
         n61EW7OliGZgaBLi95I0oKJ2cWPuK9IY6lac3qSDbidid4BpfY8canSknrniIHHA3lRs
         GVfOZ82bgc2ftIUkSbYOZ5PyKKD4AAtNLbFvsINK+XYwNIbHmRHPNQnr5U0u/5F7kxd7
         r8nhW4FaS7NJKbYi6pupc1mFj6+7Fb39rJDXehpJasXlsokyPuMkoFc9XaEGPsIrCuTo
         WjLQ==
X-Forwarded-Encrypted: i=1; AKwUvByDFXYvNYcSn2Cv4LK4T1dYkGChhiT4perPKocj9RX+cOj/pIdIY5UK2NVx9zJmApw9wbGkhL1fmZh2@vger.kernel.org
X-Gm-Message-State: AFq9FYJloSfasJKYjs5ZyAtT8llp2y50iUaCmXYfCTTe3LGEERQyrJxX
	r6IxCv85XdUMeZzynIKF+4uJ83j6/7MNI0VAzfa1blXvQpenAhw1P2wtC+BAJx3F
X-Gm-Gg: AYBFou1UO5M8QXTW/tXKwhpD2/ZqO4VUFfjFjFWiFDmQtdwjRoKbs4Y4zHLijq6RwqJ
	gXGkqta8g3iLm1ppRJW7HMeBnf3q9Wie27BOvJlYxH3QhfB2g9jpL5QaRyH2DJFcqTAY+Z2A30Y
	ygaYklHSD7qIUPxIpnOl8lLNQgt61dMjl+rzkxTVXnUllt1vW85yKtrjKeT6NSNFyxO4xEkjmQB
	UpLvGw1JDHvAt2sI5p8boTFP6l0tSu5Z0f/loaBJ/wVwsdgVSKY6cgtz0gLhhXl5RfuTidog4hZ
	MP5QwXFA+1YrLSWLtLnRuiXnV3DQvnZU9QtLIcMvwymEn+M4hZJVjq0sUVTKiCdTj4pxBejsIjY
	yNmDgOy9xZSZrq99e8+WSy2MLvQAXFHTz5KKJmzQoGKSTBiTDArzQVvUfBgf8G+E07JKzjHFjMN
	MBQsGwucASnHxf493q4QOAFWirgdGxoiZjO3XB/KUcYoJ2vn1kkydvW2rJ+lPFh0GHlS1Ep9azR
	ByUKnhEMA3o3hDYOaf8lYRURuh6pETRXsEP0RmnL1yskyP3Wd2y0f1lpjQrN6vLkIZXqTapEDXA
	rBCDmC3raRhagV7kOAV3LOveHyB1UW+kRlGBPAWatxm8+elOthFW4ypyrYPJC7EjavE=
X-Received: by 2002:a05:6102:370d:b0:7cb:cfcf:3d01 with SMTP id ada2fe7eead31-7d05432ac0amr1815571137.33.1793353165122;
        Fri, 30 Oct 2026 02:39:25 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee509f58sm1908936241.12.2026.10.30.02.39.23
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:39:24 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7ce78f9d6baso435674137.0
        for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 02:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzl9Uub03pxGtf6EFlyFlTR/zlmsj+Qlx+Hn6xGH3IGB3+BbbKnBNC8ZpqO9JDGijeAcuZYpCZ9DbuN@vger.kernel.org
X-Received: by 2002:a05:6102:605a:b0:7ca:8f2d:5c29 with SMTP id
 ada2fe7eead31-7d0542ccab3mr1591386137.27.1793353163338; Fri, 30 Oct 2026
 02:39:23 -0700 (PDT)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-2-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-2-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
X-Gm-Features: AclHuK-5feC2ixWlfC3xXKJ1XowEcUrdLUZ-UGAaez_2WzCy_48TVc-7hVrg-7U
Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: remove pagetable_dtor_free()
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
> pagetable_free() now runs pagetable_dtor() for pages that have gone
> through a page-table constructor, so pagetable_dtor_free() no longer
> provides distinct behavior.
>
> Use pagetable_free() directly at the remaining call sites and remove
> the redundant helper. This keeps the decision to run the destructor in
> the common free path.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h |  4 ++--
>  arch/m68k/mm/motorola.c             |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
