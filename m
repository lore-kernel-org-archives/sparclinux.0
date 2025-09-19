Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD917A2EA
	for <sparclinux@vger.kernel.org>; Fri, 19 Sep 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297782; cv=none; b=tviTqMHNEPjImh0/N1KqeVPvWb4CndH71VQpp5r3IlLFaIlG2ORBl6QkF4j1UbliORxg+ipbrOnkL9T3VGetQuEtNLMd+0jBSJ196jIr0rniioxP6fxlWg3LGzBQteh182Fty3bz3C+GCLEmh0c5AISw46LsGonY/xlIK5+glgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297782; c=relaxed/simple;
	bh=/dAZGMosSJom4zYvLgxeyhzW7zkijHPh+HnrGAibjAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfBgU4T9VdL4yoEsQUYh3Zeh5gZMB1KiAkK5dlW+VH0a+hnfbparDBXvrLEUXxHPipfYfTksbeP7LYXhEqtbGMxfusAQDeRrp9xZ1jnecn3C50ivjzyZYySGcL+EtfbCGvd3LNt+OT0ZVdQfZ6BTzf3X6SneeKK4Rz3bXUi4uAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TV5QXVqD; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TV5QXVqD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=jW/H8fadf2VVLWp6nqqUt63o8z6DnMlC2SPW2N11arE=; t=1758297778;
	x=1758902578; b=TV5QXVqDBjB1YEh9SmYkbVwILpqsLO3sR6cy36gDupzY8LdGtwLLNp9DNvCbb
	gqq5mBgwKqn3iMcUNzk9AhJJ0JApsTMr4B6z6Q4nNrUw6deW4xtAyTXScgGSkTLQawd9LLPTOLS/K
	kbZKzf6d94zlntoOEkso0Bm21rdFFnh+o4c/GXsIXRBIT8kD07rDxTgHvekL7fAD+coJ85bVvspYg
	K16GfIuTB496Fr3elJkVQmQeheA/5grg2K2clZPoEFDwrqMmuo/tjSZYmVOjEG9oAgoPSiWKFKsTm
	6WIq4iNqk4K2Sc/rSmNMSWHnWNU4glN/08luJ0S/7Wrb52bLTw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uzdZY-00000002XkO-36o8; Fri, 19 Sep 2025 18:02:56 +0200
Received: from [45.156.240.112] (helo=[10.14.120.148])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uzdZY-00000002i0L-1xfZ; Fri, 19 Sep 2025 18:02:56 +0200
Message-ID: <aafc9d1ea293ac095137d224849447082206a1c4.camel@physik.fu-berlin.de>
Subject: Re: New test kernel - second attempt
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Riccardo Mottola <riccardo.mottola@libero.it>, 
 "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Fri, 19 Sep 2025 18:02:42 +0200
In-Reply-To: <c3c82ca3-5e6f-fb7d-3e93-60ed9bd37098@libero.it>
References: 
	<9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
	 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
	 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
	 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
	 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
	 <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
	 <c3c82ca3-5e6f-fb7d-3e93-60ed9bd37098@libero.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Riccardo,

On Fri, 2025-09-19 at 17:06 +0200, Riccardo Mottola wrote:
> At this point I am worried, but the NetBSD 10.1 Hard disk back in the=20
> tray, perform a cold start... and get a login prompt: Console is smooth=
=20
> and no funny chars.

As I said before, different operating systems and kernels can behavior
differently and one operating system working doesn't prove the hardware
doesn't have any issues.

For example, NetBSD allocates memory from bottom to top while Linux
allocates memory from top to bottom. Thus, it can be that NetBSD runs
fine because it doesn't access any of the faulty memory right after
startup.

It could also be that Linux uses more performance-optimized code than
NetBSD which may trigger problems on your hardware while the unoptimized
code does not.

For example, the patches that we are testing here are addressing issues
with performance-optimized code for copying code between the kernel and
userspace. It could be that NetBSD doesn't have such optimizations.

I can therefore only recommend to verify your hardware first and address
any issues with empty NVRAM batteries which may lead to incorrect NVRAM
contents. We have had one user reporting stability issues resolved after
resetting the SP on his T5240, see [1].

So, it's really not too far fetched to think your problems may indicate
a problem with your hardware. That's why you have to make sure everything
is working properly, including the NVRAM.

> Interesting is that the Netra T1 and Fire 120 are quite similar in=20
> hardware... the latter is a bit higher spec'd (e.g. accepts double=20
> memory) but essentially differs=C2=A0 with the lower-spec'd embedded=20
> UltraSparc IIe vs high-performance IIi.
> (the advantage is that the IIe just needs a simple CPU cooler with fan,=
=20
> no air ducts and is so much quieter... almost like a workstaiton).

All variants of the UltraSPARC I and II CPUs use the same assembler
optimizations in the Linux kernel. There is no code optimized specifically
for UltraSPARC II or even variants of it.

Adrian

> [1] https://lists.debian.org/debian-sparc/2025/09/msg00062.html

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
