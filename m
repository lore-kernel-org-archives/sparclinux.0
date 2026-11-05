Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873573;
	b=dPum8tYBOL0WcELCR5vqtal3YIkkzi5X2BrsGlCd1k4W2NWFJ/4B2v/1lgZmx8pRwT3q
	 yOf1bJzo+FPQrvDc9tUHRYhtXknpaQksDQ0vJplmBbdTiyETlixpSpiSNweuW9pSNPsj5
	 OGRNX8eFq7kS5fu3ag2UAz6Z+TRADT39z2IqhN03mtLw9Z0iJPwAWiBCOm1Aia2B2uOd4
	 4Wj6RhC7KsyYyg+jDo1LrxIaiZhvgKNV+JfZYMVj/sx20AQLYiU76AWnA5lualnqy7TB/
	 xYwjlr6cnu7jfIUnqdJV0pubK3c3KMm/00j/6+aIR8+mCy7+rsr/Y1NTsoKI9TTCcPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873573;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
	b=nL5dajhDyq8/GCABa5DCAJRlyb8HYIm1TYuQz/bPigFpqYiK6ou9r2AyxQK70287acXP
	 51Aqwe2N/BdhPz5Z6l1N8xGVnVYz5ZRoR1XoMBdzjcqRCsxbu/K0RPZbX90jaVPEceYSP
	 5BeF3GybE86O3vShXNZ7r1a/lMbkISe0QiJH0RXabyWX9z/6ejo+KxMNAqc/nfS4NKwln
	 3a1BSeZvL9pvqjUvFahqL8EHyAMR6rTflmQXTAVoX4bFl9McAIQXCqK+DavoFM51FDRqu
	 36cX8G/5H+Cwf6IQ1EdgcCjMei6scqYQ67YA6ONCj5pqGD4dXS2cd4bntxFAmkFnObQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468F606EE87
	for <sparclinux@vger.kernel.org>; Thu,  5 Nov 2026 10:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A468F606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c19fc50abso17730066d6.1
        for <sparclinux@vger.kernel.org>; Thu, 05 Nov 2026 02:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873571; x=1794478371;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
        b=u/m7Fwnq9ySTAulp/t+hYjIE9XjDgndJ5XYfUgTGiDF/2M9pRhmDWTt8vJMyW0Cpef
         HeUq8V0cDAFINKD7euNNsKD/kddRRk5khnSBK4BbOoJzLgWH9Slzg3zd/dfecoL/iZDT
         yHla9kvi98mwwkTAY5uA4xrKV8OllKWFHWt3MKXhXEd4XCaum5Z4a5o7Wh+8dHDBfxk/
         51dyV5h1RtRkF1m+Hch42nOJKSdjNEpfhKlvRNOSCRXrnSsvcXY5QPVu4QV14g66/p7f
         p6We1e3EQcdKbo6EG1Iw598HLwJEaUCLWRcV3VX1NFtiSGW/j+ItQbjoy6YJyUbwvz4F
         LYqw==
X-Forwarded-Encrypted: i=1; AKwUvBytbCItdJJ6lCJXvbSbnKF8EEVWOpYJhkEkF4aTXt23HBDhcUpL7shXDyEpxNNXH4ykLMUXd0NXkcQc@vger.kernel.org
X-Gm-Message-State: APuU4Z+LBknXxyNHyfBuD6LoxjLOT8isFNzARvUObk7LdyPxK5/ORPnw
	C8Le1VpJmSBhDs9iK7oWLhMv/p9cxmEz/FkEyhzhIFfjpkRuE/+pxn8uXIbQZCGs9PU=
X-Gm-Gg: AYBFou23IKib1GcqgxHZOwJBsD87WYEMXesdo8y0jxf4AcksCNdcp4+GcuvhBZjseYV
	LhptYHdZ1CKVV9ehgHEn/aUM67JgksobOFh0L9DHmjcPyzeRcHZs0OOEsiEmHXYF52AZZwcJXdQ
	wlmZRlxvHBBg19GmvLGmI1jYFJhmTtkutSOgGU8pKeAMeka219wfHddLK01/lKi4jxtM86yC7aO
	ql+l8NZyZVRhZuwWidpr5VVjEpDC811bthW+RonOxojn1PNX2h9NaDs+fUDFmygQnvZYannY4va
	aDTvGUvVm5US5xPU9sp2gXW9DjKdLSiQ+VUr+63pBTndiLqIc8fZtt/pAln33w60o3E45dCLqlu
	1Qvni4133/x0xBlMhYBJKDn9cqG7ss1ZWmb38WWCC8FswSzEUnoMKBaRDOz0BBJqkM/kUrg6OUT
	Sn5vdKuRCOX8czS5+W+Pd5P+G1Qk4jqKMFKiwxRM+BqAqDF41coVBZ+bnqS5x/Kz4KtwAVoHcW6
	4GB/cajiJw9O5D+8EDP+NwT0uNoaCWqfmtD73oVGRt4meCnIi2k/wo8+geFIVzXY1cHzZ01B5Ck
	zgDUTSDsixHLPV2XecABCqBflzLDLSdjUbzkC1SsoR7EJG2f1vapxUEVsMa2gBPRnYfKtgU=
X-Received: by 2002:a05:6214:21c8:b0:91e:8a59:5fd7 with SMTP id 6a1803df08f44-91e8a5964a3mr65536926d6.3.1793873571253;
        Thu, 05 Nov 2026 02:12:51 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e013a5dsm44232586d6.27.2026.11.05.02.12.50
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:12:50 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e503815adso152217385a.1
        for <sparclinux@vger.kernel.org>; Thu, 05 Nov 2026 02:12:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzPfsQPfa4/Wm/8jv9bBFfHUI+y8FX6SahBjMBtH0//oENm4nO5RUW/2crHwa6Is/aO2uUgc9kLWK1C@vger.kernel.org
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060714137.5.1793873263361; Thu, 05 Nov 2026
 02:07:43 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:07:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Gm-Features: AclHuK9naqg5CZQ7lhJVrMhg9TNH44f-SpA5WbUGCGBsAlcoOw2midTd7doJSmk
Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
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

Hi Christian,

On Wed, 4 Nov 2026 at 20:32, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_write() pins the entry and calls ->proc_write() which copies
> from userspace itself. A page fault in that copy can take as long as
> the writer wants, just like the copy to userspace of a read, and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for writes as well. An entry that implements
> ->proc_write_buf() gets a NUL-terminated kernel copy of what was
> written. procfs makes that copy before it pins the entry. The copy is
> capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
> proc_simple_write() if the entry doesn't care. Larger writes fail with
> -EINVAL. The proc_ops go away with the entry, so procfs remembers the
> limit in the entry when it is registered, like the size of the seq_file
> state, instead of pinning the entry just to look up a number.
>
> Entries that take binary data in pieces, like the PCI config space,
> ALSA's data entries or a firmware image, can ask for
> PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
> ->proc_write_size bytes and the write comes up short.
>
> ->proc_write_buf() gets the position like ->proc_write() so entries
> that write at an offset keep working.
>
> Note that procfs copies in the whole write before the entry looks at any
> of it. So a write that is too large or whose buffer can't be read fails
> before the entry's own checks run, permission checks included, even
> where the entry only ever looked at the first few bytes.
>
> An entry that implements ->proc_write_buf() and still has a
> ->proc_write() fails to register.
>
> No users yet.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -67,6 +74,16 @@ struct proc_ops {
>         const struct seq_operations *proc_seq_ops;
>         int     (*proc_show)(struct seq_file *, void *);
>         unsigned int proc_state_size;
> +       /*
> +        * procfs copies what is written into a kernel buffer and calls
> +        * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
> +        * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
> +        * writes fail with -EINVAL unless the entry asks for
> +        * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
> +        * for ->write().
> +        */
> +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);

"const char *"?

Seems like you have to drop several const attributes during the
conversion from "const char __user *buf" to "char *buf".

While at it, I think it would be good to use this conversion as an
opportunity to replace "char *" by "void *", which will probably let
you drop several casts from users.

> +       unsigned int proc_write_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
