Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0933A716
	for <sparclinux@vger.kernel.org>; Mon,  5 Jan 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622115; cv=none; b=Id87R5R5HJKogVxpkJJAKBAWhO5hgbRkmBbw6HgyuKeivo/u6mlp17DX0DrF4GsRVeJ4gy8/GmJjFrFU+ff9LXyaOituvQrcarWD+cnFLaF8f57mBRbK3TDy02LB6ptRh/VYCF1nSDICossjhJtPirEXcKt29VIXGtyx/GNz86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622115; c=relaxed/simple;
	bh=r3I6M7kWHIbwx8pg9jWTMfz8fscetYU9L971EGe7OZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2u+YbERsh7A/I/86Na8i7MRkeXueLdi3Q5JsX2ROB7ePPkivZLRoHaPLpzV5w36bdYRMc8nfZHw4xvE7F2tOBlu5B3mDQl+NTlr7rqKSxKzR+msb5wTb5T2meOpniwSrHFE7NXsbK9FCr9RDCKhfDo0kBCx1AMA0WhsNDqD3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=H9+hkPjh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="H9+hkPjh"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso6055903f8f.3
        for <sparclinux@vger.kernel.org>; Mon, 05 Jan 2026 06:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767622109; x=1768226909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=H9+hkPjhAyTEos4JbC3SAHaK4U1jFi/jCKRwkG3H3+42Ugy69WLCmKacOeNmxPOKw0
         Ix+pwpDSjEpf1yAwNXdsT20c7NqUd5oHunNPqzsePlSzps5WYOiSx5uiCtjGUY1TIUPv
         t3T9IoS8ShGcJgfzjL2u6Q1kdVMwGv1f8pIgH0DMcox24h5IEYh+Atzg4WxOTvniWzK+
         G51sNEh08yMuuRlk8CmnRljUjsg5kNffJGszJhny8HWJRogQSvnCbU6DTnjhLeuxTHmy
         I4XskcK1GoHISE8qrTfNJmMx/D+rH0FMktQJVeTsE0D2xA7ox80+XRiyZ3oSBGef62e1
         HWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622109; x=1768226909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=Ld9IoSHNo69DbcGOTWeXgaR0Bs4LO7Y1ShNgHbjtGJIAOYQt8Pm7j/zPpygMCXwgJ4
         SKLkLtS7VRn0+HAamClgbvETx9XCqzysxy/XiHv8gATw+uSCr0IBDnJto6miXJkwXglj
         Ej4a/wYCH3tNYzzoNFFRq2itBAqbAGJ6NG5DtYV9o2Ig0wcc4WGDYZmp4mEiAdEwjRFi
         A2CM5wQ/gjovTVNcSnOffZ1sbqcbptLYYEbOXnEmgscUKCZQu2sgDNG8PDFoIa+0NczO
         XLjc00ZLZfbe6Fc60pM5f9lIkizHaxlmAuPEt1k/V0YDOd6GU/XJpYL6BAueyt9b+MMG
         4Juw==
X-Forwarded-Encrypted: i=1; AJvYcCU5SL2awOU+HnPpmEnwDqeMH+Svb2YV2AIa+L8KUqTpEcGMKlcT3Ps5PrrxJIHirWljYnDUmOWSAgPH@vger.kernel.org
X-Gm-Message-State: AOJu0YyUI1i+g51esxSyEKkkaajskndnVxodXghk3IIzr17CkpgJCjN1
	te6/FhaAk+fi8wt14ldJFMEkPGhSqC/oLKv91yQcNYZFKsajMnDOMZC0wSuAOc+0yR0=
X-Gm-Gg: AY/fxX6eIqKN7lHJI9FP2X6Xjtqwv381Ph/aZp6Hvk/4DcU9hrbQC0CaJ0rL0vuJxP/
	wF0EPlmnzhq4MTHInEnO0/djmPNdmrj5M9NeNCOvzZhcfMc+FGiXhDfdHP0XTUD7WvYlnEdhcHh
	iuTVSnJXCMRrn1SrF9iTfiqRGqh2HTOEUZv2gJ1vIIvrP95863chOC+GI6wl6geBokjLMLFgd0P
	YHhgWeFYcJajoOFG0jb5aJa6W4lnuFmTkvpY3XSH5F5/1C5ZMkpcjB/nDz/QnCAOFNh2GiaFSub
	Sw2GyHk6349GWLMxpb81g+0Ghi0d2TyXqygKIzs8faNg/K7QLLet1AEd2Dtnh/ZfdAiplI0KTcf
	RjQ2h4ZjVCav3XbCI9T0K4t9LYJIHyhH7yQCTaKbGWrWLFKIFw4Gzr7XaHDu4LFwz4Q4ZCBdImD
	PL/zgPYlduoJ3oh2yd4UY1FZzom0J8q7XiPtYxivPjGkQ33xnapq2zhA9NhfJm/FfCw7bJmndoy
	IUxzwRc2ud7gXiwUoqkUB0LbyC7NxWNyKwgZp64zGnh8XDvSMvrC493B4rJW5JFyMEZCj5c
X-Google-Smtp-Source: AGHT+IFtm/KgnS/DHXZ241C9Tii09D9IuHplpok3aN88rFmOsLWOymloQBuensoLNVO5jV8TaARwoQ==
X-Received: by 2002:a5d:4842:0:b0:432:84ee:186d with SMTP id ffacd0b85a97d-43284ee2de1mr31846134f8f.62.1767622109438;
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm100250524f8f.3.2026.01.05.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Date: Mon, 5 Jan 2026 14:08:26 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/19] printk cleanup - part 3
Message-ID: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVuz_hpbrk8oSCVC@aspen.lan>

On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> Hi Marcos
>
> On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >
> > The changes proposed in this part 3 are mostly to clarify the usage of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in reality
> > the changes are not complex, and as the title says, it's basically a
> > cleanup without changing the functional changes.
>
> I ran this patchset through the kgdb test suite and I'm afraid it is
> reporting functional changes.
>
> Specifically the earlycon support for kdb has regressed (FWIW the
> problem bisects down to the final patch in the series where CON_ENABLED
> is removed).
>
> Reproduction on x86-64 KVM outside of the test suite should be easy:
>
>     make defconfig
>     scripts/config \
>         --enable DEBUG_INFO \
> 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> 	--enable DEBUG_FS \
> 	--enable KALLSYMS_ALL \
> 	--enable MAGIC_SYSRQ \
> 	--enable KGDB \
> 	--enable KGDB_TESTS \
> 	--enable KGDB_KDB \
> 	--enable KDB_KEYBOARD \
> 	--enable LKDTM \
> 	--enable SECURITY_LOCKDOWN_LSM
>     make olddefconfig
>     make -j$(nproc)
>     qemu-system-x86_64 \
>         -m 1G -smp 2 -nographic \
> 	-kernel arch/x86/boot/bzImage \
> 	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

Actually I realized there was a simpler reproduction (hinted at by the
missing "printk: legacy bootconsole [uart8250] enabled" in the regressed
case). It looks like the earlycon simply doesn't work and that means the
reproduction doesn't require anything related to kgdb at all. Simply:

    make defconfig
    make -j$(nproc)
    qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel arch/x86/boot/bzImage \
        -append "earlycon=uart8250,io,0x3f8"

With the part 3 patchset applied I get no output from the earlycon
(without the patch set I get the early boot messages which, as expected,
stop when tty0 comes up).


Daniel.
