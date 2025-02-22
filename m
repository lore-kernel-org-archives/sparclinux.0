Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED935948
	for <sparclinux@vger.kernel.org>; Sat, 22 Feb 2025 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184453; cv=none; b=Vejib616TmRneUbcU/LfdhWXxXA6OUxZZIZuOdFnycYHDZ/RMKsnqcXTBNK6fG+mJoAzRkEafDl95DvuVOeNkPDSWs1UlKoUh5z10ZShvlg9zpT3j7SVIpNcbZqj9hOuxSh4maSDgC3LmMLAE7fNe9cj07dyI0MuRJbw9kznfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184453; c=relaxed/simple;
	bh=VBQHljTSYFVCaj1bbqPfTOtZckZuFzfefk82naOnO1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgB9Aa4MFSsxZeqNhYj0iBUIDZhM2RzE1ofgaLq4R6oTi0LjKXv+lbz2sKffcyVEGuqNNKy5YrvworrcjBuiPfmeZZ6VmLeXaVtBt2y9pQ41xw0sCDQQwPDtx2fN2D1/tLjHXekd3WIb7PVwupz5Ba2Fq4bJTr47/QIE1qkcplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OUaLZ8oR; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OUaLZ8oR"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f666c94285so24600307b3.3
        for <sparclinux@vger.kernel.org>; Fri, 21 Feb 2025 16:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740184450; x=1740789250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwm1CmURc5ve7fRU7CIVjr3XJe8XTIamKjt5b8I2oxA=;
        b=OUaLZ8oRu1P66C9ZZZkX3ynr5GVCRqOCfxm+eS10iyjZ/PQSQVzJcOLZ6xUj2SVdYN
         M4K8v7SJJNGtsVfIa8UAf/TytFgQB7jB17v0YqxAZeaJ0z7poxTRKJtsLNNfDGLEzCtl
         seyhz1IBRRwX+if/gK7lWjT9j8r22Ve4Q5tw8y7tH4v0VO86On+zdAarH3tOUkuAZpC+
         42QHcKAyfH9frZU0Zmd2KD7X742j4GBihhNWnbrr+XZUDJUe8nnJrCAFuMuLqqZIBe++
         7xlE0daBQ4baD0AJRZFXYr9quFZHlK3q3UVtm8HMqcrK9PO0mdFobh1wMMbzoIxycBMQ
         K8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740184450; x=1740789250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwm1CmURc5ve7fRU7CIVjr3XJe8XTIamKjt5b8I2oxA=;
        b=tldTXxBwdJv9Vz7KFohTwAM/t/xb+s79YxNyIKI2lAqrdPCfVHlMXDWlu4Pamsg8/T
         HPHE96y8aBas29wjcl0y0a1o3A8UGsr0crBRvDP4J+mNPfgajbDiG2GHh3g19vg0xb0w
         HkjrrzNRCFWDadMBrf88EgMUbmalzJIScxF+nG9B2ZZipGfZVzbHdtTRpB3btxB3PAg2
         GJwKpdpIm0pysW0M6iOS0QFgh2AMlpY8JHGmg2ND3FS9TvBLLop9Bogbz+bL7j0MFGRz
         pDthVVFMJVZ1TS2eecqLU5mj89pdH+qUKRCO9dY/Fb4cusV0FswjU4nBJISDGAO1lkTv
         hTLA==
X-Forwarded-Encrypted: i=1; AJvYcCXzrkifne0jzwGmTfLPtENfzgq0fFpSI8XsmLIBgFBtIz2b+Ikg1oc43K+PT51C6zetof94sA+uS6y7@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXBdJcdPvfDsDsRJqQUUrmI7ITDqpmO3EYvjsYQXuy9xcxMIF
	v6PgU3bWAj7t1X2ODACF0W5gAxbDWYqMzQZoLtth1u3XZWsVpSqQThK26wtASJoZa5e9CpYYVDO
	OlTy9fpnTz4G6z8qlbxaH8nCcBLyWh1aX2qT6
X-Gm-Gg: ASbGncvshbaAl3MYiKewRR1z3G1gTmOPmORc5m6a73rJB5TVriwQ8RkcmKk1/p2nsWY
	VB8c27LVh4gJxxwm/sViukJ1p32KvBv2nM5emynKQUYcS3LXdJ6RX4tURh93BcfZ0ZLpTCzuuIQ
	J2NJvc+SI=
X-Google-Smtp-Source: AGHT+IHU8mqrXQveakYlLhZ7AQnDt8Huldya+naR0jPDiYuZo2FksnUyR3yBLKwefOB052PduAKRpiO/vKqO0ObiYCs=
X-Received: by 2002:a05:690c:3506:b0:6f6:c937:2cf4 with SMTP id
 00721157ae682-6fbcc81835dmr37934927b3.23.1740184450404; Fri, 21 Feb 2025
 16:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org> <20250221.ahB8jei2Chie@digikod.net>
In-Reply-To: <20250221.ahB8jei2Chie@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Feb 2025 19:33:59 -0500
X-Gm-Features: AWEUYZkJvdf7eQZPTJrwhKnqZP-Y8wnVSUpipQ3Me6WvrrB1wQej040Y9lsHrww
Message-ID: <CAHC9VhSnP=j_T30ctVmzQ8TwhD6YFcrWhLbqa_oG3WSAPUPOaA@mail.gmail.com>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
To: Andrey Albershteyn <aalbersh@redhat.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:08=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> It looks security checks are missing.  With IOCTL commands, file
> permissions are checked at open time, but with these syscalls the path
> is only resolved but no specific access seems to be checked (except
> inode_owner_or_capable via vfs_fileattr_set).

Thanks for reviewing the patch and catching this Micka=C3=ABl.  I agree
with the hooks identified and their placement; it should be fairly
straightforward with only a few lines added in each case.

--=20
paul-moore.com
