Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC73B813C
	for <sparclinux@vger.kernel.org>; Sun,  4 Oct 2026 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138264; cv=pass; b=QwSe6LDaMbun3lo5dp7FrAYmDxNiQC5tp0h6tP1KQ1Xwc5kvo9N5UKl90ILGG89j4yOt9SYZGcRsfA/q7ytXkcjQ09lBxnoTGP5yL7G0ep18Uzgqb0kF7r4dr7mjWbRVbHd3qlMFEZ4k9UnKZ99iEinqoW0PrM0pJGrFWcVxRzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138264; c=relaxed/simple;
	bh=3aBRZG0J7nrNd8eWZI+tOUTLRCjKVPsGyHM+wAKTgfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPdnzRyWBhBkN8GFxdt/cRDBst1GHDULAztFs7X2vtZvE/9mNwEUHEpGXWq8Y9fRg5XDeCw0TKI5OLe6lpi9thrqt1Lr6Zmfe6OHYPXRPzZp59xTV8jqVHGruSi5louYqol5e+GLhp/zTRl3QLcGLnrPyk6WPXad+GNxxD3+Ofk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEICTv8q; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEICTv8q"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso7766a12.0
        for <sparclinux@vger.kernel.org>; Sun, 04 Oct 2026 11:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791138259; cv=none;
        d=google.com; s=arc-20260327;
        b=d0qGTIMeUpK6QYPIUh9OPQA4aK0KRn17m82UzwelPPCds3MkFFTRPY2ZzRCbGMEntR
         pYoc10HdXpnPGzXLI76A2Ybg7xLUQcxde8DSA6fISWYbbWZJ+w0GZN0G/RAxYuugt9ls
         pSlDjh6sA1LVl4LW2ObrxBUnq3Ezl++WYwFbZbjL0bENkasEaw723laEjYw/mjVZvUjs
         g/oNO6ht36E5uluUTkxiJTYq4esI2ZW6fxM+5Uvf+V9os+0AgBvrjafh9936WT+D2bcS
         teMpO86/y3H+6zvqQ2yBlsVp9KTbbmgfr6APi6NnBjQLi3zOA8/epFdU95boSTEsrXuI
         hwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        fh=uY9aMHOLK8VWHuoXttWY/JC2FjppnMT18GhN4Vl0llg=;
        b=d+6iu8vx20fqlkzRGQcSENkRHBa9j0jZ+LU/Lr1PdHgGFwJjk8EpcwaMnz1xjrt50g
         EPHJjCxU4hoxXjFchRkX6IXgfjl1n/nunaqnQITPed4YzsDxjuZZlWcAto9XaiwFD3u0
         TlYQ+2Wu9fvvxihfccXoMP68biHlPCEppsUHppmtbcHaNImkbEDmD01D9fayJ2cbZq8o
         J0kJGXIUQxMWa1jR6rugnVzpRDl2L0f5slLtWTKwZ9MqPA7+yEYPGBjVw9y1BfgDAQaz
         jIq0PwDMBfwcK89ncs4s95DANsGTBCygY6Voostk2595p9Wjd4pC3a7aHBvFjS7CnSF2
         r59g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791138259; x=1791743059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        b=KEICTv8q3qYQz0TDKQmwuTgoTQ4+Uy1f2gTr+1Jcucbl5RmoQf2zx5avi3znfbqUYL
         mG1jalfiys6PieVouC35387QdwiS2THeCy3HWXmEuLexCnajpnQwhh/u9Y81k/N0it1v
         6biJ0Bn2hXpnvHERYN2DDPKYzyERopIrR/ej2fNfRzT1xGN8QAaJv6VWm2hyycPisVEl
         qB9CHMbhrYjxR4ocOq/KkaOeuqyvDPC6FbGfnWk4xRxdLwi4hIKZwIs5KxBN6T00oVYW
         +O8flBmEMxmEHcstMjXIfvMA8gZDeceIYjglqxvmVfj4NzY1wBNFHVUVhUCMCQrSV5QF
         dmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791138259; x=1791743059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        b=H/EjCmkrdg/PawLdN9ZsmkUuW+X/CQuzJXwfOCYVF8WggWdknjW8G/URLspuxx+QN8
         T04aRzxTnq7ef0N1N32H8Eki1lEmt7Wj5FuCc57ZQOq1ztFWUZ796of0HuG4YVDc/bwC
         chrHAJ576Iyye9U28bZHINFDb7atTY6gv02QJcHlJjac/Jd7jmaVnuHmHHIJKdJ4IsKC
         PTaR61aXLTPF6sPOKV52LmaHuLjJr+tSTykWJ13SWlAd9ud1p2t9fuwcGgNhm2Wjlmfy
         COWbI/raXQe97fP8upo2rWk3Bj262oXVUErCN92D21RvUjf6ckFhfFU1vRbKrw0u4w6z
         DEyg==
X-Forwarded-Encrypted: i=1; AKwUvBzbY/7sYjIg+ClkOFpDuMYUHpHeFRaMXzPIx1LPLbMffRyMRhRzXF2PzZkcWhNeqi31VoeNtM+t3g82@vger.kernel.org
X-Gm-Message-State: AFq9FYL3ycfk7Do+xmFoqyKxIr44MU4CxepFE1CnvZAax9OfFyjfh7fE
	A4b/rr6CVxrdeje1LBL0MHVLd+F993Jx51664fWSSAAUpIB77LsfLfIRhbB3cybWJRolF3Z87iQ
	iNeVZR5+sWRWKOtMgTnTG9Qoxeg4ftmhZtt2LJsQE
X-Gm-Gg: AYBFou3ffyRAinhFnkSDkTAX4k12KmacRVWKUFHtOx+nDLJW3Or3i+rjZgJBLq6fxC3
	ikTlq5Rt5yaKl57HsGxiYePJv1JW5TEYMMMZmzt38otI0v8CNOvXBF45Mw4+MMHuFb2sIDiMPBR
	XXTL4GMS1XxtNMmD54BcUVMs37E5/24m+JKvd8aVPC04OtxMGEIiaog6qyBDM/xWgn1gUsTac6e
	ACbcW+ltGHnQICr411OH45CtsaQTvu/FS4YpYYwmJU5mj8PV17giHo1AmIkxAzAWPb99zSYXa1+
	Ra6nRbu+GB/TGO2AtBkzGPh55+mIbeW3Ds7CHobTTZG+EA0g410UN7lE1pLor1yUZyE=
X-Received: by 2002:a05:6402:a2cb:10b0:6af:7a5a:97e4 with SMTP id
 4fb4d7f45d1cf-6afaf6bf03amr34523a12.12.1791138257648; Sun, 04 Oct 2026
 11:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-20-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-20-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 11:24:03 -0700
X-Gm-Features: AclHuK9H1gPgFkK4n-5s4Gd8NQjwfuvbGlNRYoPrM6gC5ICSAC1H3Sf5qTdT1bA
Message-ID: <CAJuCfpHOo8UhAZMvO5A3dKbqxQGAWtKGMHXJ+Fc=qwH=Nm0b6w@mail.gmail.com>
Subject: Re: [PATCH v4 20/38] mm/gup: error out early on !VMA_MAYREAD_BIT VMAs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:40=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> When populating a VMA range via the aptly named populate_vma_page_range()
> an unreadable VMA will always eventually fail with -EFAULT.
>
> That a VMA is accessible is always checked, however VMA_MAYREAD_BIT is no=
t.
>
> All user mappings always have VMA_MAYREAD_BIT set, so this check only
> impacts kernel mappings.
>
> It is implemented specifically to disallow population of uprobes XOL
> mappings which are exec-only.
>
> A nasty interaction with these mappings may occur if they are mlocked, so
> actively disallow this early.
>
> This allows a subsequent commit to remove the VM_IO check in
> __mm_populate() which otherwise requires non-MMIO mappings to be wrongly
> flagged simply as a workaround.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  mm/gup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index c2dfcb4744bc..e6310a7cc05b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1836,6 +1836,10 @@ long populate_vma_page_range(struct vm_area_struct=
 *vma,
>         if (!vma_is_accessible(vma))
>                 return -EFAULT;
>
> +       /* Unreadable VMAs also cannot be faulted in. */
> +       if (!vma_test(vma, VMA_MAYREAD_BIT))
> +               return -EFAULT;
> +
>         gup_flags =3D FOLL_TOUCH;
>         /*
>          * We want to touch writable mappings with a write fault in order
>
> --
> 2.55.0
>
