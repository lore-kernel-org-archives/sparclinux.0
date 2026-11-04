Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822729;
	b=z2mEdM+YZD39EyNwi1CY8ds4ySRoZhgcjFEwsZfkGAAwJpwE3yOs71LBAZ7DMgJz0fDA
	 AghUgwm9FmoKrC1ZfdiFCatJGl9lZPaNVzdaXcszBjR2bh3x9HcOTezeT9i5GU4P6x3fq
	 bixWNb1VJAM9u6x5MrnE7mZop9lMqCqzqSxaVQUrWSDwN0PIgrINNUmIqB74TVS8sdvmW
	 3rePzR9Xaf39foewdi42K74FRcP+rQrVFRuKxZ4JLLKLdi3t0fLRoKaU1dmZ85TwbjoH1
	 ceB6hdHwffuC+YMbue0EwICIK5a6JEuZD+CaFvVFhn8IHJG6Lea+YgE9o2SReunDobA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=5ojxDhQ3Z4FdyG5JmQzrtO6HiRn6oMMRx5dsnMb01c3tbRA7/3kLJLa4VB+O/fr9hB1a
	 eAkM7ndznrOV+BPLkeE0ujHWgau670Uxb2dSQXKAu8B2fOo4FEWbVJ6x718xPzMcLszwj
	 pK2eSPkVM6lhrPNknm6C6lrhrzRdAE9zE9q4NB+O6mTc3Id+ZnChpMAb8oqIW6W6RNd54
	 YYvnHWOmLLRcutlqa4wKMLhhvgMUmY5kz0CEQ7dqyShDiubZqesS6740CONC9fw+BTPmH
	 bDNS13ZFPpNNKf1iR+9XwdArnW/9TU3dZjO5EfqVuQbWEhRBtnKcK3Dm5qMKBc1koQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fI2nmlcI;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD46606FAC9
	for <sparclinux@vger.kernel.org>; Wed,  4 Nov 2026 20:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD46606FAC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fI2nmlcI
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c423b145922so162307366b.3
        for <sparclinux@vger.kernel.org>; Wed, 04 Nov 2026 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793822727; x=1794427527; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=fI2nmlcItpwZxqRsmDWssHJaMT2IN8dLg7E1xDQbx0Et/5dAwJ3lC+28bQvSn3TcBy
         jCCz6aP+hY985kmEWKQ8J3n3DZJgb7Mf7tqsXWxEtttRySDwTo9j3SEkofmGPUukuzUB
         aTxGLiQfrDGmJiexVo8c15QHheFgr9P51oFII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822727; x=1794427527;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=NZagNYcpscvOCQO/xVKqn0XsksNcl1/VDmArUBojhi7uj/ujhpGPjIpYwedxCVSXPF
         tiIewvp1LYPHdoJu/CziDSJN2FHxc2n5J4sKpgitzZ2soqhLRo8I9lDsWEI3p9GLBL9Q
         ApcbgdcPAbfjrFi93AJDHI0qclFKRhVs1ZmQqtgNPeT0xdGmOZRMA82OkgAqiIzdxGEJ
         tVU2zu/uhc1NW4lzcEGYey+T8eE4HBMSeqY4lSPcAm6mRayO+hkUarGIhVzx2SELeRN0
         iN8Rd0ub2DPJHhJvN2vdagYMzs6qehQSOIbThg/dxeeOb/Cpfihmv0cCNTaqpfkTXlgq
         m9DA==
X-Forwarded-Encrypted: i=1; AKwUvByUyK4DDbYZ4H/peFfjH6EhVDqQgAyKer/RyorRbw6EFHnBaS6CDvW6V4fslC8MBMl+paAV8pLmm9li@vger.kernel.org
X-Gm-Message-State: APuU4Z9h/c7mL974rJ6S7jc/x4k/EbtQX88PDd6Ya3Tx2UKS6jAqq2f8
	DWUkisskdSfGgut5LXM8sTKObpoXPtSpRqpHPHsw7vMpXLnML0HUFXgLaQicGjVvW/gogK0VtEC
	2BA3Rw23Ltw==
X-Gm-Gg: AYBFou1sH4MJHgDf51iqNzdHPm535tXl7VXfwlhoeRA5Gt+ds6u/PpDbUVV4gJ+juJd
	4epbn6Oza3ds7cdaZWZQUjWJ2JRkfsTc2sk73uJOM41ENLxxHvNFKid/YBp8EvRZvLx6DT/VXxP
	zbHV67/llGLtD6MfPVf/baqg3BARdDNJUdPYyjuiuO3di5FnQFMUaZnBjtKgqlCqF8shYhZEHKi
	+6UJ8vP6lZwkXZhNlLDFEY2y5fkwz7Rjm0vwyEhqIPY+SApl/T5VSdD4kaD5qOPscQQDOAxJqNL
	hITC0Hy2vJ0uhkFdi/hxtlXTATpDb9uf8Uvt59J1vW9oLCejCAhXhbn6lOg4WIzgjEg3sp2w9Hi
	qgneuICP76ZJdVknp2y3cStVYvxBq1wHkbi8ZO4okkE3+D5uC8Si/C6J2K3doMSy6LAG2SsTAw9
	tVi1HAszixZlMeZKnFphMqAvk9uXQKnHe1uQqg4yjOfDClzCjRaxcwEzHwhImOwM2ilCrvMKlz5
	/k6IOsLFCZQwJHVJKg9uE3ylKMXpsvwaexk0BXjzXxxvHFN33fb2B75uGhHgU0FFuoR1Cy13QQb
	3HGnC0zwOU36CGkk5GR8mwLv1JumDZg3Wb2NIu4bpUoU0cBLn89zirQqQEdcyfHe/hcf0LTFvgn
	EdQ==
X-Received: by 2002:a17:907:724a:b0:c46:645f:cee1 with SMTP id a640c23a62f3a-c4ca7ae41ebmr1612857466b.42.1793822727146;
        Wed, 04 Nov 2026 12:05:27 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e48d23dsm103326166b.69.2026.11.04.12.05.25
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:05:26 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c445c95d553so164002166b.1
        for <sparclinux@vger.kernel.org>; Wed, 04 Nov 2026 12:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByoyRBmST/3kv94uq64bGEHvPqJf/yUrGnhiL4VrzSLeMq5hQw30DTW6mVmoksY8G2XKx+xxsE3wK3s@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus
