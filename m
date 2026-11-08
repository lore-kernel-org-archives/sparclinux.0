Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=5pGg2VuYNQBCoUFVVNSJ8178zkevSUjy1RYGa4Yrwgwsx+wNtgaJJP0WTMDXD6PNq9mI
	 09Jzj+tsJYU9GIFT8hHF+VgFjxUyO5KsIDZK9OrxKk5ZLBNanPw+6ZY6sWKQN98g8tfsb
	 X0OsOa0G/mSxLU3aw0TxnLr5VhUScHXioQ7aapumyCBAKSXLclIzeCsarxAsa7VgRd8+L
	 vruv6FKjC5j+/x46AzAovIpMuTLszjjom0meKqG7BnbdLq2PH+Pd9hwS/ZkxV8J+L4nOv
	 F8KT9P/coB2G8CY8Qhd4I+ro+3xjKxza9GYho5mLSH2eDQ4qWyoiUTCf+15vnq3XPrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=Xyh0oPywlwyOVJb7MIbdSLLujDhqMue5fFnrSOcGsbGyGLDfI1wICLv3K0VEGZDVeQx1
	 uyNdzkF/g5/bXX7UNyL16JnUZUVj5BPb27imFQzCx5VBeSf5A8uDUBMr/pXDrFdtbm4UC
	 xNy6/aIvHHdXLqgj54ZQrdCZ0+gePZC3aS3o0d7iWsg61g/ddr6HL/JwwK49p8o0enpyI
	 aEF0KC+Eo1hYLwvelM/3IED1F1wXnm4H2vFq5cesFI+2XkHtlMadb+wQOGuCixaZCINoF
	 fMsS30PtIge6+ceZZRhTT1JeWTK3H4GtlOxSAg4PKgd0v/o7aw2EInVtjwJkCFhkWvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416F606D807
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4416F606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so1416375e9.0
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=HfHcIAbQ+2Qb/qxT0mFRqHwcNWYissjY5dAFz9rOMn2ISYHzwH9bQ90T9XiFuDJcbp
         VAeeV19lxK3IEa9ImUpHc7omITrS09l4qG2W3TytJo7ncoH5f1LxvKyTiyrk0njWP/Ct
         vYvpXFZ+yVhE8Ff1NmHNHMXLL/ZRpXJkQxb1BN59vaKbDsjbunI/H82XM563IUSfKHei
         MeRCCZ/JKkFUv9lL/k9bw/DWZoFwafKWjAXZPo73xDtMS2pLCi0TIkPvPwJQ+OtAQtZN
         ZLQezH6UFNhv9dTAH/LP+ywuIa/0swCG9pfHDFPKXjk5jqUFYwhyKY2e8j9X27P7GtEj
         UMew==
X-Forwarded-Encrypted: i=1; AL+hErHUvQ6rbegxrL12pBQSjlQ5Gg7Izy0/2n9xoJmTZPLFLADKDUqjW2FYESXAnADfCW/WXZljCunEPvPX@vger.kernel.org
X-Gm-Message-State: APuU4Z8VBrRWde06Y2Sq2P9cMw42ygibC7nUS8F0tBRVtBU8gahmH324
	VDzcUvAstCjG9Jq0rcoCYcrLZpyri+2KrbshxeccOfSTeaSJTRkCkhQL
X-Gm-Gg: AYBFou0UY4CXBhnt4p+o8VBSGsLv3oKZ7kh7qCdqotTWdJ1kS25Bs9IC87z4cObccT8
	o2KFY2pzpXoIlvSHtbQANApdeYaRyjdrPYNn+mlVuWJrtf4awCOVOHPKxWyoOml+c9zCJ7XgVNT
	Ns6KBZxSZgDr6IDNmcNPpp/nb7fsMv2NIIOmP1Ryj12HGuvZothFb4638pdRFK7PUqyIyaBHWni
	nIYJ0XGCUuHF9AHVm8kw1l/0B74lXaSJ0KgVrLnT374FtskADMgDEF4cMIWMLojFjbHtL7R/h+v
	lVVQP06KpP2prHq40NEXC69esEQaL6T0HlAsWrE7qkogC/ehgCgjqNOWFGsu43q0W2HuvA5ueQv
	V+EkBHmQZBorAL6IWuyD/23OUInRz8u8JOG0pWyTAAINPc1QglGhsksE0wur0j1OiAhbyeSfOcX
	DU/RXgvmuqp5QFhqLzxbSgI2ceCRMHHStGScBIgdcMkU17Gfxcv2eipEcb42egC/KTfRkzGbJSV
	q67u9qv1bHflw+nYF5iWPmhJZlsGdeCMVhzuu6JwZFUQyW9PVqiji91jHTgm8AYvf9Ln0nrrOzB
	0gnLMHMNrOOSsmkb63lwqkWLGh987WsrYC0XHTfoYjFPZIL0grmbNwI7JDV3SvkM
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David
