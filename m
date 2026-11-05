Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872290;
	b=dlIpdcp1tu2LkAWoDxgUtJ8lUzLoDIxmEKfuQ3KRW4VqGJRHqnYW3D0f80flVE77JYOR
	 7YTafcZhxpsfJXet/06eLGOAFX1ratCCJ+lQ5smwVh0vlm1TzGFEblaZ/KRFGUEMWPrdL
	 kwRMk6YyJ0OTQj2MtN+hbEWTQmJu65yjPOEVdwJuuUYijz5qEzYYNsG3Okd2+DeHSEO3X
	 Rouj3sssd8pEySyG2naI36xpQaWv2480+P0pw7hClIrRBiV+8/taCZxO+j/ywtIK3nnYy
	 HG3K7zdF+9lS8vgYO7hshTlAE70S4Lw+HWWAPe9/L0lXn0d3Z3hQKmQCtBdAOtiiwtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872290;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=oYgxj6FgMS0Ersvu4dlr+Ed8q8tOYApuJUEiwuRlaSu/QWDq9a6c1SCJHbMYM3xIEro7
	 FhejsrrstR+ij1D/Mb51HWOiTXLkC71Lb19nx7TOQqBqiEE3yehBuzlLZptQXjbKtfrSY
	 X1xh2Ee84jCPor7UxlxoQAzMUgbQX72GsJSIx1QcqCdR0P2M/s9VCcg9TbXs1JnQa6PoG
	 eCDxiYiVFtKXlgTNv0Rr1K5RGcw27WTsFUsHkAoeTQjWnd+MAE4bK4Dy9vMGZ+WqWJKZx
	 SbvSAq6Zrd3+artxV0LIgB2DDBGx5MNpDkJTZ59UgEKQUJVg21M2442NgFSNLIiDDpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94031606A330
	for <sparclinux@vger.kernel.org>; Thu,  5 Nov 2026 09:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94031606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c79a9a739so23582086d6.1
        for <sparclinux@vger.kernel.org>; Thu, 05 Nov 2026 01:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872289; x=1794477089;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=pRwUqe93XAdWRvNXtBHPqOJvqx3cbSjraeAxq29V/goutqHFOksTsfKRQJ9ePp6dCs
         LhWTxmgv9alhbx6uax8f8oyuKnm13/ip1bmgldu9tuFPKSf6Eel47mt1qR6ANefl8IPQ
         svcJg3UgrMo2FVsZVm+i5327ceYmOZAV14nOr3JkgLmDVABhf+2pFjmC+6XdEzKTYmZM
         O+N+eYZkrLWCFnvvd8mJh2deWzgJTZ0TokuRKzr2YRCv3gXTn2nQAN8TJz2E3if54n+z
         KCi/yrgtvXqoe/nNRNgxKSuR8lNs5UGz3lYVBSlLrxKfGaEA7IXPrH5SqwPpJeR7SHCr
         zDmA==
X-Forwarded-Encrypted: i=1; AKwUvBzfNAyhhT+nO4+0JdFikce7pIzsn2P+7luYifO2LyBc9mQLTy5PvdoMH4ue2TKEzXYb3iSteq0/f6JQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+oDBBXK/J7c9sfjc5gwwVL1RaEmBPs3y2SilxM0JSANA5QRe0N
	Qe27jzfSezg+LTVv0WY7ks5Cq0DFcs3Ht0GN02vltAg3f8TtpRSbIvv44rosj/uZD04=
X-Gm-Gg: AYBFou1djpxZcuLFN4QL5iUoaxpCt9c825eySbXkxpWiASVmMXYp8FAjUzG09mEW4/v
	s7KOtCwTldAinoyoki9Bo/A5hFCVrrO4GlgKw5tGa6c1A1nRxwjdtrMvCq0wB3PnYk93VRAVSAz
	cw7zgqa6/3IzUzQoNrRK+t2Exhmhvdy5rcytT7Or/xw/GzcIX7DcQmiiFKds0hNYzE8UySCwY1H
	JZkB/aiGIyAM9c0v4SqPMmcVZ2m6aG60x/7CqMA2v5il6M2Vgj3PpCMBkG/uBF7xENwRiEGu7rb
	qkP/yrMKgRFYeaDA8PWpkYcOXLRCSSyvv1KtS8sNKM3cxAmMhG4kgsboluvNKS/PjQbp0d6ZBrM
	DGbKY4a7FdSS2/NIyj12dJk0fjvJJ0zkGBsQapXy+Of11+AsBQancvFITIG7Xof4af3o7fuN22l
	VWSzJeiVmKiAOxnpdolXuOH1OYvB5MPE2Nfubh5KxBp+QTqHqQUmCT6AUbwp0rI5jF19iko/Y4H
	kfChpyU/ZSldo9wdLfCwzEOpH7TQNiIqG/kmU6MaQ/VKTKAsKTovBG8S0vWxcV4lxKCNU7LF3dI
	6t7dVGsa79OGHt2s8LeD6U6V0YZcj44yRiJrEUrJCEPWaeuqeTMPI5EJeooXY9T44eONTAoP4Qa
	0R4NFTT122sdrLOI=
X-Received: by 2002:a05:6214:419b:b0:91e:9b32:589 with SMTP id 6a1803df08f44-91e9b320d2amr9414316d6.0.1793872289446;
        Thu, 05 Nov 2026 01:51:29 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfe973bsm43453606d6.22.2026.11.05.01.51.28
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:51:28 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53c4b82919fso21003151cf.0
        for <sparclinux@vger.kernel.org>; Thu, 05 Nov 2026 01:51:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzGQLN7sDbLoqc+U5ptEmbyUmj/s0vysTCie1p/8nMeFU5QZhTJvDcCzxRVf7JVG6cEmUd3XVdioUYK@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
