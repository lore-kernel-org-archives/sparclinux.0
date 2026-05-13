Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76916357CFD
	for <sparclinux@vger.kernel.org>; Wed, 13 May 2026 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643027; cv=none; b=IRtvvqZ2/ZREOeTN3IzJR+HOKhR+XwA1BGSCigt3pu7zFdBFDd75QjNFYzXoyENB52dyrc0mZZNxHxsbdwh4jCbWLaNTtQL03NEFg5qBro2Jbe7AoR5cdPs5w8h8Y7cOlM3RU8U2sSI8u9eZ+DqLH8ktGGoPmb2eTc+c7BY+qyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643027; c=relaxed/simple;
	bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ASD23ypkvh3yEmLAEoElV1RY6qa7leCq6HJFjZ421J9cep5CeQ3VlX7YdtNco7BG+TPHfFvxV6NLxNPcHkNPoSsCBo4vZj0jhmvZ3x70u+piG+PvGEpioty+sWu6HukGSgCVbWrt3y/axv6I4bFIpYXe7j9+i/AGZSJIwpJr8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZx8fmp3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZx8fmp3"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8173b2af32so4563972a12.0
        for <sparclinux@vger.kernel.org>; Tue, 12 May 2026 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778643026; x=1779247826; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
        b=kZx8fmp3MOAoMQYVmRSwbgeizNPkK2ScAllrEIXZldEPAFMH7D8Cc03hKxOYyGjN7v
         AnGMp/d7YGH9pGPfWErDXEIz1VcNcRawcxXxUePqx/9U0FoWFO14YExCmFTzguWzMTzu
         JJEIcsNYAKyE6NeAJQrAdhow6wKojpXdCUUYPzl5ELt6MSDbCMhAO3vlDpwA8xuVQCE9
         2RG7quNOEq7S1kUoQMp0V6DI0QkKD75j8XI7A5lSxhhIjYu3fQqIYGURfYwj3TuUb5qz
         L4cJRpqBhtGX2/25AzkWkriJTRxcNUikPNiea59b2HAqSfBVSbu2YOiG2nWjPvA2yGwz
         SwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778643026; x=1779247826;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
        b=KrJZFu/YgNa8jTc97Mo8mr6PlOHuZqKNVL5Ywu1T8qy9VcFR4e5s6Xt57xpTjCLiqG
         5j4I4wQ4Zb1huCl7MwWrvek5txDpb8ow/Sjn6e89aqvV3OWCV/StzyHRdMP+ftycReBU
         PNvE7esPIv1WXDUgjcA5ajK+r+IZxcjcfjpbDIiq7fP/sNB6clcMZz1OOlLrWE5OngSW
         fexJBv/JNff5kj93u5UHzJ3PJvR+1JwoL8/daAvDIuCmWi3etaqEYsjMca9jIxsL0Jm0
         yOMGOG4zmpwsuAguc+apHEglygl6D/goF1VtsuzRLpRGqHE2apok7jhYAN1ZqQ9QZxOh
         9G7Q==
X-Gm-Message-State: AOJu0YyTgJDnsfgJbU7of+sPLaxAmZnEOD0H0HKAUV3LTVww96sab9+k
	Uj3HOdWyWw/ijdkaODgHHZ+fDzXD2or7XysRIbcPQocd0oi/S+i/H57s
X-Gm-Gg: Acq92OHEjNVl26hPDvbWnNQB+QheYLeJ0ruUDT6tOLT9axmOZR7XDMRpgZC0Pi+MaTk
	Ka20L+GQf+TN+O6NAOgEM/VaDgnukVafuMUMbm88kvyfEiZWYu157WxaoA+k0TUh9BRHeeJbgKd
	024Dr2ufkt4VgLgECJGHVt01w/GyC9oGIB4zGI2LpEOwOfHvg4MqlUfI9/E5qor3VtkjpzlGB2D
	naeVaAlv1lNGOKbLTH+7878L5zQLm5CpxAx30TKqGe3ORMPkT2byw7xz3Lq+vl3zUZNhVPOL0TN
	uTb0NBlKCLWwCDDLwqAuGf0OC5YKDNkzjhRKkXmYK2wA+Ou1t2a+djkPmvAOqfuH0QompGesfBW
	41TehqnhBSKIXv6Prmv0TmA2cBmEpthPBTZBzcKa2SOYZAIPbgJzjzghtIgHvjtDJg4FHQKEBpC
	yx6pvm4TVkjADDoqHxg4H7OQ==
X-Received: by 2002:a05:6a20:728a:b0:3a2:ccb5:abc7 with SMTP id adf61e73a8af0-3af809790b7mr1486042637.13.1778643025638;
        Tue, 12 May 2026 20:30:25 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267710262sm13455532a12.18.2026.05.12.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 20:30:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
In-Reply-To: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
Date: Wed, 13 May 2026 08:55:05 +0530
Message-ID: <wlx8q9da.ritesh.list@gmail.com>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org> <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> register_page_bootmem_info_node() essentially only calls
> register_page_bootmem_memmap(). However, on powerpc that function is a
> nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
> anymore, let's just drop it.
>
> We can stop including bootmem_info.h.

Yup, the following patch [1] removed the usage of bootmem more than a
decade ago. Thanks for cleaning up the remaining unused pieces.

[1]: https://lore.kernel.org/all/1410933504-28564-1-git-send-email-anton@samba.org/

LGTM. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

