Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A663DA7F6
	for <sparclinux@vger.kernel.org>; Fri, 10 Apr 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835134; cv=pass; b=hcb7YoxlIYH8ezqdZwRC2ULcpghcqNMrcmxYpKuk+T1ypBz6YKpHAgZRzJE9FTau0xfGzXYSkaySQDWBoXABaKDQYW1zL1tVUGUz6vkBcAe4dh962OXbfctb6wzrf53AmitBeXVA/jLGpO/obzEZSn5FQjmIZC3Vts8iBw/D6X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835134; c=relaxed/simple;
	bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfousxzQ1tTsDm853eZKZJTNjoqg0ROqdi1J493WxRwXVQBIsM9JFkJMOMgLx8V/eFa3PPHYR26QugmvzBJ3hHxX9rF3gfv7mTaHGePeUa5r2jIUuAyU8NDlF6fk+O8KhzYBBoqfRtGmh3H6PaxngA7pmvg5E5tXIv67ZNfjMeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=cs+zJ0r8; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="cs+zJ0r8"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271257ae53so9590770c88.1
        for <sparclinux@vger.kernel.org>; Fri, 10 Apr 2026 08:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835131; cv=none;
        d=google.com; s=arc-20240605;
        b=XzCVaokbooKE5N9EbCeBqvLaJ2h2L1qPbmxK+OZohhUI7YgQRRuyyXlUDVZ+whFFh9
         FQtSTbNPWLdWLYgWkGNIwUG2G1Aw4+R47xvOmMBPnwMjm6eWOEVVNMv/k7FIr/d52ZZC
         N55+G1YimxPBgTkQxAZgYNngeH5idNfJWQXo9VZzSRNtklYrzm1RTtewLo+ZVDGqWNbC
         a2CNkdOYZrWD/y57HzRR1ACgQb+eNyHp5fgHyC4xqHQaZRWE05cUFLRIg3bBVnWSR5KY
         KdP1g5oVJq3/cCH+SNvi65uJCbxmKJbSvFvrD3lbEH34YI5RF8u2PRCNMpCXy17WT3Ra
         gK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        fh=m6t/IAQDn22yAbew20pQR5mRykchrBu6J66SHXT9Prk=;
        b=F5ZG5UEZVoBKmXje3rL/OrUHToFmh9HWjl03Hh6pp9mFxn/x3P5baTY9M9F5rlo8sC
         gb3ZQXT5SSIvyxxlqFesAo8BrIR1Dg3R9wcfGCeHXT41YPBxmk2gF8fBT22iHJNxjfdu
         vLodYYWGv9XT6tkapIdmkYnzf00xFW17C771i6xcVw5iUaPuskUEnGsyjgNMIOLpMHTU
         xM28Be5iisdMKYbh2vyRsdgP0NrqVNtJ3bn1HN2SORMZ0niP+U8F0BrindP3qfIB84wH
         sfdmoLw581oBc8dRDm0vuZ7fjJu45aexp8HxyIQsnk63nBxlc8gxFzoN2gZ4OD/NADPR
         rYNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1775835131; x=1776439931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=cs+zJ0r8E1VxbeERL/6orYDfRzBNN0xV+FBDuuOmam2/EuHZ7scxaUctzZ3REo2LBr
         KdQSu4tLtUeUQ/Am7PGmtjXBLQ/7knpdVClf5erC+tpkhYxe59BfVvuW88STHDIDr49T
         TpKPrBeobAalm+DfnxseCj+mCeyPg4AFXq4Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835131; x=1776439931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=cjG2fiAFX/OTEfhSt2bnXQuTcKLIxVNG95Pwd9iQiIaNunNsB1wqPZ9zsBkloxuEv8
         TpxohzwIJZY3cWAEU8pdu+s/OxOF6GEho6hvARqdIVazKDcV3DpDonBeBl1tAUePsz9/
         /UQvd3Hasw60nkmKDeJipj5lNQ2yanJQI/9v4OV8zzUZhzSvqZLSrL3JqxXRncuqS0lI
         /dPVOCxBbSsJB6TOUASFUTcSwOYerNKKd4Zd5AmC9afT5r1N1CIVabB92yLEwgMnmOAc
         Xz85sUaj3Svhn/DVrNVnMc5w4/3661QYBX+d5ZhxXwruTigMIm2CyizwflXU850hDZSv
         Awig==
X-Forwarded-Encrypted: i=1; AJvYcCUxIT+3tVKDz1rS67eqvo+2dnCTXl0v9eusmy2ed2wE2TmMXIferVkIM5QwBmyo+QXVhiuWG683yzIm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SA2fKmS63mFOpiVh5owsa/gIGs8ME+MN0CDZCqdLFgetOgqs
	0I3Cd6AgVaE/xweVOfnGDqITMHGDaBFkaMbgmvcWQJam71qbImDHUmLLnmaBOaIvssLsTMWrtni
	AgFbuth1ZOw6hoWLthUkAaGtF3qJnUx4rCNT60oeO9g==
X-Gm-Gg: AeBDieu+XqDjbH95XMqC0DuVEaz5MkFsNqJrfokfnRi1e9s91OC2wxALqZZcsNVOKic
	/CJPXb8bap8ThOCl/QGSKwgOBrmftE9g4baAB/w8Fg8w7CZforonvRoZdL7XQEPCcXw9V4cMumx
	LZeX3ezNIrGE3SXTLXQgcApwGycX6b0c2u2yZ5X1tD1qGtCgkPqRP0gwTSK1geOdsLgnR2ZBTu4
	/l+lxe6ohwDzM8QS6eVOLVVk7oeQFjLic9TZSITBHf88oHFB01b/+LFLICR7HCjcFhNMxg8cvh2
	ffhx
X-Received: by 2002:a05:7022:6097:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c34f069f8mr2159203c88.34.1775835130696; Fri, 10 Apr 2026
 08:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 11 Apr 2026 00:31:59 +0900
X-Gm-Features: AQROBzAnX-XEClLFV-qWYFUzCuq4P43sNZviESiWFI1yCPXm2VtVZ2QkaUGJoPY
Message-ID: <CAFr9PXk7qK8-2JWrrfgXHoS9JWTRL+WobLjmAesyCE9VLL8ZyQ@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 10 Apr 2026 at 21:39, Thomas Gleixner <tglx@kernel.org> wrote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.

I have built and booted this on my Amiga 4000 and it apparently still
works so FWIW:

Tested-by: Daniel Palmer <daniel@thingy.jp>
