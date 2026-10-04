Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B5470133
	for <sparclinux@vger.kernel.org>; Sun,  4 Oct 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134681; cv=pass; b=TvkFlJkEx58ube4Czp0m7iPpuT6L0dOGU3MDKZ/1gJuEcFKEWO1x87wcSyUpGnoYOw0MKzQ3TWSqd/U8ffi21FVIDitD1wx0C4LTtZBuvNu7bVYdGnmUu+gqUSv1XHzTx/qvKfNVmB4TfXei4JCl7wCKg6eBEbsm3oIL7PVDnIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134681; c=relaxed/simple;
	bh=4B6T8K8eUucXVsVxRTncDC2MG3zHAWjPPggaTDLiRRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peBq64uwjJRLCcv4yn+5FUVxxZ/m0UarqXPuUfKdTj4syTWh0pT7izV+tIierEOZ7xqDO9QQ6ByZdr16FrbucSBb7fFnPeeHuE2yRDFp/HnPJag+J3coYvVn4l/86bemeTOF8TIey5spo+fZDVv7VvdDnKx4WrXocJcSCoSpHww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTu4m/1d; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTu4m/1d"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5337c7b9937so260611cf.0
        for <sparclinux@vger.kernel.org>; Sun, 04 Oct 2026 10:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134674; cv=none;
        d=google.com; s=arc-20260327;
        b=G65kd2Omqleo0QQca3RRRGGCS8x1Vn3olHRu2fO6StSADoH/al2J9/F1wan8u9vLIJ
         5qKaVA/lB2yffcK3b26E6bsdnMylJb976aHE9VoIrXusJWiCjQcUh3k8/EDMQviX1wiV
         XpH37SUV0af19UCajNitJGnH6Y0ZOvEffGZQO5e4RKCLUbF9ZrWB0xxhIfX/KB86fzyH
         FMSxQUXBJ7DbrWuCu0pw6pqHV/U3lA5QJmA1JyIXNhEJZ9WSgowTT/9Ko0Td/qiHkp+e
         o9qJ1leWKIJLQKAwW/frToqMu7WGOG3eyryFuHb/SqE5lYHj8imnvPAsvQYDDw2Wbc/J
         S8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c+M84/MVcGEHYdv8UiC0womKlZljWSjBnuX6fRyYL/I=;
        fh=6iwxI9Be5wuAie5aaybZLW8SyT+Mb7GW9oSJjZseZzY=;
        b=LnuMhfHsC4WLT/y6tdGNjeCL+9jc3mBfGIxM/5Wvz0uoieEkU0InLrgrjDR3a0gzT7
         J9Z5bf/DqDbdZelsAypNQn8YAShWKjFphlZAaiAJ7yKi6MUT/L8Gayq9q/lmyN6/d6Bt
         TRYq+kx/x/qNViufVPFBrRP+ov4sl9VNfSTxfDJpk9pxPocOrpxN7tYRJGKxegZarNWD
         bbKaAxo6iImnJgC6j/3fMW+NZCe8TMk++ka6z13FA+vFFaWzOAnLzwDH0b6Xx0pLYUI6
         4yN63MnkVU6k3S6Ka/EwbjKs9J8WsaR0Pc2R6dpdw7PfNZszbVAyiWLB0GFjqa0+7y2s
         LUNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791134674; x=1791739474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c+M84/MVcGEHYdv8UiC0womKlZljWSjBnuX6fRyYL/I=;
        b=LTu4m/1davKLoUNKr6Uy6tIgim1fKNGo5e273mXMTbhp+NMSr4rca9qK4ug6PNyHnd
         UjGZ2IvJP8SNUFIk1lnppsqn1KxS1Yah3mt3RFw+P6ehmACj7FqCqwPN2hen5rZqXiv+
         vR7tVQmN985GIGs22scrgxRvH+V7iads4ZarxZ5hbzwg7qU4gStOclaAsmGpOkNR0Fkw
         a50oT32/ZBNwn2+nEPSFkjFGRHVqB9umb7IXSo5ZW/zcuIYl7I4hB11FTQ6DqZMlVZtx
         eK18i8lzbUNqkAibhKB7obz2YWKH1wx9wJoa2PDEBRCf+JouNbsTnM1hdOC8e6L/97nR
         44HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134674; x=1791739474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+M84/MVcGEHYdv8UiC0womKlZljWSjBnuX6fRyYL/I=;
        b=SL8mpAiN9whTWKq3x2VZmCgbMaYYfYyMLG4TGSTIolV537TYtXFeOjF3beQVwSOB2Q
         BM5q62UqELcwK8evmik3p6J/Vxx8gE8ZAVdSsSu5FLmr8HSXltltoM0yRhHZfPazX3pF
         ALkFpBmk4MoA795hGxfqG1ezeUWBFKCvyDlusPT84e8xzAJMQOaH1Q3oAN5sB9x1kYSC
         rAn/XEB2Q95hyqwgyITt/15Onm5j2B0jcvuQBu39a/TE2ns4Nvs/5usOrbhpB/U/GoAW
         Ou4QBNVoGcClIOBLto7UyWIf36Z9XliBGRdqj5Tp/21Z0c2BDRj/Y2CUmsd0NIhjKKo/
         seHA==
X-Forwarded-Encrypted: i=1; AKwUvByPxCSLTa8pWnPCoXtuUeRj37czpgmQxvOl/Q3piBSSYIAIru/owSfB+M2yZLBiaCn+wHgZTAqCv6Jo@vger.kernel.org
X-Gm-Message-State: AFuF++l587KRCmj9gXIiy1meuyjvKcTO3CdYxYwPqhW8iNs/DBQuo0Yk
	QkSkebdxPBYTUk0DsIN1WfdAPVSX7EExcszMGZDthKmr9oyBfspRWB2KCeRALKxmrW9kvZvehcm
	miMKhhjkQbZbcYnwxKYQZgF6RnPlTeuG4jTfRcuLc
X-Gm-Gg: AYBFou0CdMkWLsmOda4wBa3mUP8quJrtptQMEwnWITdHTWm6oF5dqJopZpdr2rA2NkK
	mAgG+HhfEtn+EwtOF9m9nAc3x+7umY48DVXIE0t6irAdLve/gZcKyQLF7iVImGNAp6jQGEp21lA
	MQGWcLSbDHWadbjCXkzSuz+k6xjJFZ0XUO5kyRMq6zGbBBfkBAC9en6kWCib62soShmli4s47ws
	+raXJn19rcKzKJUqYMHi5hRtxoYbnUbLPw2PDC/lVKbdpHkkz5aqHx9Kud0x706fZ/8vf0WnkSN
	N6h+FVjDOtf2KPeaYK/Xq5xq6iORhxHTUab9V4XliKTDav1aBOXrbxow
X-Received: by 2002:a05:622a:606:b0:532:84d3:abb with SMTP id
 d75a77b69052e-535131b5a84mr14345371cf.7.1791134673403; Sun, 04 Oct 2026
 10:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-13-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-13-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:24:22 -0700
X-Gm-Features: AclHuK9jHlOUV2ZRb5fsxUCRxMZ3OpnGbWN3MVyf3rU51TqoB71rd8PxNlF0WhY
Message-ID: <CAJuCfpE7W7uFZfztCHRCouc9z49wPV96usW2QewJNZwprK7bRw@mail.gmail.com>
Subject: Re: [PATCH v4 13/38] bpf: arena: mark arena_map_mmap() mappings VM_MIXEDMAP
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
	fuse-devel@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:37=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> The bpf_map->ops->map_mmap callback invoked by bpf_map_mmap() can be set =
to
> one of ringbuf_map_mmap_kern(), ringbuf_map_mmap_user(), array_map_mmap()
> or arena_map_mmap().
>
> It is convention in mm to mark mappings whose pages the kernel manages
> itself with VM_MIXEDMAP, so core mm knows not to treat them as ordinary
> page cache or anonymous memory.
>
> The map_mmap callbacks ringbuf_map_mmap_kern() and ringbuf_map_mmap_user(=
)
> use remap_vmalloc_range(), which ultimately invokes vm_insert_page() and =
so
> marks the ranges VM_MIXEDMAP, and array_map_mmap() sets VM_MIXEDMAP
> explicitly.
>
> However, the exception to this is arena_map_mmap(), which doesn't set the
> flag.
>
> This patch corrects this and updates the comment to reflect it.
>
> The pages are refcounted and vm_normal_page() finds them regardless of th=
e
> flag, and VM_DONTEXPAND remains set (marking the memory as VM_SPECIAL and
> thus unmergeable). The one effect is that NUMA balancing now skips these
> VMAs, as it already does for the other bpf map mappings, which is the
> reason array_map_mmap() gives for setting the flag.
>
> The intent of this patch is to be able to establish the invariant that on=
ly
> PFN-mapped or mixed map ranges may clear the VM_MAYWRITE flag, as is done
> in bpf_map_mmap().
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  kernel/bpf/arena.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..b69fe5e34339 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -620,8 +620,9 @@ static int arena_map_mmap(struct bpf_map *map, struct=
 vm_area_struct *vma)
>          * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
>          * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
>          * being copied into the child process on fork.
> +        * This is a kernel page so set VM_MIXEDMAP.
>          */
> -       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
> +       vm_flags_set(vma, VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTCOPY);
>         vma->vm_ops =3D &arena_vm_ops;
>         return 0;
>  }
>
> --
> 2.55.0
>
