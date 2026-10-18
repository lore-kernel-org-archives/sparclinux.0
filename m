Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE64AD4CF;
	Sun, 18 Oct 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328975; cv=none; b=n8z3mdBtC6zMcp5B/Lku6jm4NysZZQgLzwK2+qmzGjRFXURkkFJW7RzvalBJUFBvTYOP4kH15VAFItasXJDhxx9q/wg9bnZshfjuQErwKAw7PC8KJi2vgwG/Vk3PT5N2NnIr4hA73LOrTrk68vfGbdi/+KasOnvj+gX3gnTNifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328975; c=relaxed/simple;
	bh=xcyTIog8Jdl1tJpqSZ+OUCnYAH8IJvWEMvkHMafWm+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acSsWLkStJaqIzZvT03f4MRSS+Nbda1jX5nftapByUMxD5OqrPPm4RLG6aLocy1IvGkzI6gChSC3QVB5t9pDX8wfPF6dkaXRol/EGvcwvoyyJfhNJfAAPlyJ/s4yQu6+deFrzHv7fpyNDsmP/lkOsAtXhlYyJM+6V4MP0M5XCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=kigMjTXk; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="kigMjTXk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Ad+KRCeiTeq89I8EAoLhJ8IoqMcKydtjkjF0jccydEg=; t=1792328971;
	x=1792933771; b=kigMjTXkUwSp+SrcwtX2xz96or7lgbM65MstGbLtdfjB70lSJwcdldny0d73e
	FZR8WopBvH+uYXXcy0bPHX/N5RhbcnNeBTUOWTTJz32EAWWN5C2IQo94I1T4Xgq6+6hAdvAjRzNZf
	KbA+mBYv3ARhVLrv2GvuHSR6hFaMGsvebQYtk3XNmfmh1JEUKgIBf1rLduwqbGLxU71Vp0uVkhu1R
	yZQ0c7JJc2HLoiEbVA02sCsHIhj3UNw5+aSH2/WPH1fkbt/QWZaEE94XPq48wkEzsE4v2qnufF2/u
	Da3sr3VA/vUji/RFbSY1gbZdR6COJtwEfRaM0+ZkfIsS7IZ6eg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xIQdh-00000001xYw-3xcj; Sun, 18 Oct 2026 15:09:25 +0200
Received: from [45.156.240.96] (helo=[10.13.52.99])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xIQdh-00000002g1r-18WS; Sun, 18 Oct 2026 15:09:25 +0200
Message-ID: <e3068b5c97884032e7cbd12c78f6b5534d75e30c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 0/3] sparc64: Randomize mmap base and PIE executables
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Stian Halseth <stian@itx.no>, Andreas Larsson <andreas@gaisler.com>, 
 "David S . Miller"
	 <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>, Michel Lespinasse <michel@lespinasse.org>, 
 Jan Engelhardt
	 <jengelh@inai.de>, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 15:09:22 +0200
In-Reply-To: <20261018122734.2594904-1-stian@itx.no>
References: <20261018122734.2594904-1-stian@itx.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Stian,

On Sun, 2026-10-18 at 14:27 +0200, Stian Halseth wrote:
> On sparc64 a 64-bit process gets little address space randomization:
> the stack moves, but shared libraries, anonymous mappings, PIE
> executables and the brk heap land at the same address on every run.
>=20
> Patch 1 makes arch_get_unmapped_area() start at the randomized
> mm->mmap_base again, which it has ignored since v3.8. Patch 2 moves the
> 32-bit PIE base out of the legacy mmap area, so that patch 3 can select
> ARCH_HAS_ELF_RANDOMIZE and randomize PIE executables and brk as on
> other architectures.
>=20
> Found while adding PIE support to the sparc64 Go port:
> https://github.com/sparclinux/issues/issues/119
>=20
> Tested on a T4-1 and a T7-1 (sun4v) and a V240 (sun4u), with 64-bit and
> 32-bit userland. With the series the program image, brk, shared
> libraries and mmap base move between runs, and with
> randomize_va_space=3D0 or setarch -R the layout is the same as before.
> The exec and mm selftests, glibc's elf and nptl tests, the Python test
> suite and a kernel build give the same results with and without the
> series.

What about sparc32? Does it use address base randomization at all?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
