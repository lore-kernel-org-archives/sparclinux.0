Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220628;
	b=AZ7IFgN5GJ7QcJy9wOPwpENbWQZTy8FJEcp2LTYLnh70V6zGKx8uxygmhurS8o3LH7bq
	 gRIpg7ILbtSlnEudcanhxei6Cmx12wu3aTwAg1vYFSoNKKPAwPlJPZRBg/2l0i4xtn+kN
	 UvGzq401kjJelRpXbh7pbWr9Sd9105D3BufT67aO6sKHGRvhWfUelVyw25x8gFMFlfItZ
	 3FGUtObQqsVGHoxCBB/1P092rf0iBBDblmnomrmthqymb9RuCIKWAv2LC5OxmwB74K+2q
	 1ozLzymwVTdr2ciR2xblrUPQ1bT5A8zx7P/4XhQSkrtUHxg/kytSwZ0PQAptAKb2igQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220628;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=9pX1g/iklzjrFfdOAyXiLeRMjX0W6ZaApW2OAWacHQI=;
	b=BHfawGtXIVwl9MC6Yp6F51bquVI100J12LFekscqx7WFySCnA21II+fxdF1kAiN4qwEQ
	 /eEPFRSAFEMbfaRg/pWfFhsB6yruocyINuc8P5zE3sZ/DVLcD+gEmCjXxw5OuPWYDVlRF
	 bh7JxjXEKfCIaCXhaZrEJ3XAww2rnsooE8RBuWrPJjMwFfuFdjIaL8+mFmfM5fjtz9afR
	 jYgm4oI5Hz5vqkwKVvwW4bqOtcoCK99+4EWlVPT9v2E4Q5qgV+ESjhzmjVaYN6Q/xknRZ
	 twlmnz4Jyt9wSPSE8keNqaquzFoCVNc6kI0cJYFaUnebpqu5lbRNMIDnK5zsUAA681g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b="M3/Eb9Gx";
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA9606A321;
	Wed, 28 Oct 2026 20:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29DA9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=M3/Eb9Gx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9pX1g/iklzjrFfdOAyXiLeRMjX0W6ZaApW2OAWacHQI=; t=1793220627;
	x=1793825427; b=M3/Eb9GxaTMnEAhgsREa7EI5cRBxkc1oBlwcSIxes9ZqqP/04gAQSqDYzxk0m
	CI5+fYlzV9DZUiGt9jrLNb2bj+ClAaOWRQjuCK3eD7icuI4lgRhuCU0muJQXG9Z+uXA7kkBdNiFbM
	j6dwZqVOhdYyyfNQjNTbm7rgY94JFaM8rg6uFOGP8zxBJ4RaAUZOEzbR+wnLen0YDpYQ20kxxVHEt
	LpdedB43GaeQTF/gA2xj9k0ekaj02Es/GEYg6CIKuJ+hY5ztAm/4YjPaaJKpilrf3Lcg42O8K3qr8
	lE6A9l1u2UDu0I4ImtLbhkCyP4ENM3t6ow8fWBQP89LvKRekWw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xMAbH-00000001TAs-3gSv; Wed, 28 Oct 2026 21:50:23 +0100
Received: from dynamic-077-183-189-206.77.183.pool.telefonica.de ([77.183.189.206] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xMAbH-00000000MZJ-2nWC; Wed, 28 Oct 2026 21:50:23 +0100
Message-ID: <6dae1312a957da6e140d684a04ea69e15c21647a.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] sparc updates for v7.4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Larsson
	 <andreas@gaisler.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 28 Oct 2026 21:50:22 +0100
In-Reply-To: <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
	 <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

On Wed, 2026-10-28 at 07:03 -1000, Linus Torvalds wrote:
> On Wed, 28 Oct 2026 at 03:44, Andreas Larsson <andreas@gaisler.com> wrote=
:
> >=20
> > This includes the following changes related to sparc for v7.4:
>=20
> Send them for 7.5
>=20
> This is the second week, and the commits are all apparently basically
> just a couple of hours before your pull request.

I think this was actually accidental. Andreas had most patches already
merged before the merge window opened as my local checkout shows:

glaubitz@node54:/data/home/glaubitz/linux> git log --graph --pretty=3Dforma=
t:'%C(auto)%h%d (%cr) %cn <%ce> %s' | head -n20
* a9e88d617a25 (HEAD, alarsson/for-next) (3 weeks ago) Andreas Larsson <and=
reas@gaisler.com> sparc32: remove redundant memset in srmmu_nocache_init()
* 077e15cf545a (3 weeks ago) Andreas Larsson <andreas@gaisler.com> selftest=
s/seccomp: add sparc64 support
* 60b5c9eda5a3 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc64:=
 add seccomp filter support
* 9840f43c3d09 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc: N=
MI: Remove obsolete comment
* e77e845f7226 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 drop sp_banks
* 0a8f5903b456 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 move early memory setup to setup_arch
* 91c897e01883 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 drop unused valid address bitmap
* 6b2510b9d8f7 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 populate memblock from the PROM memory map
* a33ec04570f3 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 use memblock to find available system memory
* ccdc278b61c2 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 use memblock when mapping the kernel
* 22a749706e3b (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc64:=
 decide the TSB huge-page window fixup before the bank switch
* f1c0029fd6bf (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc64:=
 use the fault address for si_addr on window fixup faults
* 80fd9c765ddc (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc64:=
 restore %asi in user_rtt_fill_fixup_common
* 1ea502a48efc (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc64:=
 remove dead THREAD_SIZE branches for non-8K pages
* ca0a9905074e (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc64:=
 increase kernel thread stack size to 32K
* 6982cb1c57c8 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc64:=
 Fix comparator problem with timer interrupts
* 01d609628750 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 advertise relocatable kernel with HdrS 0x0300
* 7c0a0dda3830 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 derive phys_base from the PAGE_OFFSET mapping
* 494e0351b740 (3 weeks ago) Andreas Larsson <andreas@gaisler.com> sparc32:=
 honour phys_base in the viking cache flush routines
* cee9395acd80 (tag: v7.3-rc1, alarsson/for-linus) (8 weeks ago) Linus Torv=
alds <torvalds@linux-foundation.org> Linux 7.3-rc1
glaubitz@node54:/data/home/glaubitz/linux>

It seems that Andreas rebased his tree today and therefore bumped all
the commit dates.  I unfortunately don't have a newer pull of Andreas'
tree, so I'm missing some commits.

Andreas, do you happen to have a local backup from before?

Adrian


--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
