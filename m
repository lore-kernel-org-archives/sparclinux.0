Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260763;
	b=0AFNSN3QsLeFdD4cy9Db/5uPT0lmwWSAwZlMnInvkR/Kgr+aeI8uhSrlCUQgwdgEVyHv
	 Y2B0X6n8wbepxOcfgNh7fh/WLrbaryR8VfmDyhBkAvGp4eyyMQYRg1xUTB07wuR5b+rnK
	 jv6dy8oHu7y8AS2WXUV9NRaZUcY18WTjQylyQtx20KSE4y1BSFbCWVvmGqPsJOazUDmq2
	 hf7AoUHwXO595ONviExh8QTnQ44qLNTf2iVTxY8ZFSAiyaXGhQNDaC1rsVIGN5stGKySK
	 iE+y+uU34oAHBfxI6OHyrp9HuY9pflAqmsH4R8V3HRp28TvHiBajS5v3YNnmMiZPKmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
	b=yKWMOVOcHJBZPIR+MEQt/OZiWxESYESQ3rQHak87/pDtn3j+j5eJOI8vfUs7/CbblMPS
	 2nZVNdbUVZnG3ZleNOB9lGvL1AL4bl/c81B8wF3Fhn/eVhdOflKuYgTDWJsoKHvdHdba8
	 nyVXyIQAXNDHoARJ6puEqwCYevVe/epR7fyRpM5b1FtSi28QIJSM3GXllZVjrJpriQEVd
	 PIRZTS2rv3wLwVroYXx1uMJJg9DfQT8Vz+1ZAcu0o6XrFdxuSInmeow+NaJjc/n2I9s31
	 v7TBWS2TndVMQ+J6ajMwjfIjTBh+sisvp2kJbmofmKc89dfTqoxZLhVm4nJGwoH+kJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75760A2602
	for <sparclinux@vger.kernel.org>; Mon,  9 Nov 2026 21:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D75760A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-492f6b7f70dso881096f8f.0
        for <sparclinux@vger.kernel.org>; Mon, 09 Nov 2026 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794260761; x=1794865561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=LaZ0qPv5+whTFQHjIA7oYo021SUS2QeXnWN8ii9Y4im7Ue68o46nz2xh/hHMwIUfQ/
         ICad5fyoXePYl6/8nNVhZk6UxBKiDwJbHcHq6QklDSJskt7Ox2MaUqpcgklbAASOb1WD
         7U13gt1MK2zXHTSuMFiAfjmE40I4QhfpTIR2Mc6nMOBQW6Dg/mqe6U/h69Hyf/QnrKae
         CyKIviPRPYc2tnG0IM8qOylYYY2PKnrUJzf833wY0ZcFYDbyZdAS7ekVESO+FaUUNtdA
         WzN6sPDUCv7pE3hPSGmxzNcqgZM1jmpktE+mpPCXGo9ukB9qCsiBySNit7DIM51G+Ivt
         K68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260761; x=1794865561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=Fj72j7Vzu7xXZ7jjSd9GVmjrldP/HcebHl6mQR6IqrkxD4FaZx7yAH0JrGP+dfQbxU
         q9yxYvJc37LwKDAU3/U7jG8/d34CDz6OsdoYGXlVhEUli+RyHp3AyFprfwLXTY3tp0lS
         RI5HFZI0ovOeOt4W8LjmEDuL1/jgRHd6vkcXe5I57EHQVr7LQC/Yqw/o5pTd9QAdtzQe
         VJRJXMSlJDzagWivuBKdvveGvFeyJhuyeNjk0m2XIh8qeE6an8E0CTbn2QKg0jmc4pTV
         nMp2zvt7dS7eO1XbYVNrj4F0MfO48kypjwbDtRg5/l/YGhSj4IfTF/1xtWvEETXBiROk
         qI+Q==
X-Forwarded-Encrypted: i=1; AL+hErEVTNayxoIi83DD8Cfm+dR/HlLm+l5UWpclJbQlZ3B3GebYoWjEFYFncokDSWolu1R6qZ9WeqeEx8kY@vger.kernel.org
X-Gm-Message-State: APuU4Z84eAy1ihK7zzgJTUkgz3Jz9kXG2r8qZCIiFL1nal9CZ1NzxoFA
	ARXlvM05ThLPqSRuHs8tBLArFNyz7xiC/X5oh4xBda8IsOoJ7CHQNa9v
X-Gm-Gg: AYBFou2aS4Nhj99yQVVRV6WRUL4/HlZHf+9TLnf7QcFUfiMXT6BWKB6LC46M/1b9UQo
	X49y562S8SN2ZwnJQZN6mR3trPTF6JG/uTxU3DgJdI5eTFtH+dzi5O0zJcqOz7UOf2AlsLlUllL
	cY4cwVeuyuuhezvTokAkz6qSXubMIohp2a6dl4CTxh3SHEG7TXtvsc97+ZGndcvKTPQEt/W4Met
	0R1uaiyrffi1tw+HA2wDESQTZfAy9kfN469rOP9ytv1WYx8WHapqVDXlcC+X8kXTIXcMJi0qA/V
	h9/XXmcBCsl4cU5PosD+gJVGy+KNmtb87tkD04gE6Si8uxqIhkNZkKntZeCOzqSpkWvcSRXwp4d
	TITm9BXL2zYmVV32JW/2Y+m1xdnYGJnaB07LNRTUETY2fKkO+7mJmqQe2L8ZWz9+/+cKyaGuT98
	QhSRllsBFdb8gVzv2lDPMaPeUeitxTNf4unEqpvmEkT7zK1qajah0m9J4+iiwD0Zdean2h4BVQS
	x7g7bF1I17oy0As8Lw/fcs51/m87ZYM2LtwtIXQEM7Dz5ZEV7FNFwbq6HTe5b2PVUkptwjSZFK8
	Kms1AAr7hk5U9aVZ+Aax7jbisEhRkrJxYH/fxzd8DQwPKrB43zS4vUsDKuYB5l7kIg==
X-Received: by 2002:a05:6000:288d:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-4982b28aa42mr1487213f8f.3.1794260760763;
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm1213644f8f.10.2026.11.09.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Date: Mon, 9 Nov 2026 21:45:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, Linus Torvalds
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
Message-ID: <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
	<20261108185953.28054fb3@pumpkin>
	<alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
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

On Mon, 9 Nov 2026 05:05:57 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Sun, 8 Nov 2026, David Laight wrote:
> 
> > > > While at it, I think it would be good to use this conversion as an
> > > > opportunity to replace "char *" by "void *", which will probably let
> > > > you drop several casts from users.    
> > > 
> > > So I tried that too. The thing is it drops exactly one u8 * cast in
> > > ntfs3's label write.   
> > 
> > Since char is now unsigned that one isn't even needed...  
> 
>  Please excuse me missing the context, but what circumstances does your 
> claim refer to?

Just that the cast would have to be:
	u8 *foo = (u8 *)bar;
where 'bar' is 'char *', and I don't think you need a cast there when
char is unsigned.

David
 
> 
>   Maciej
> 

