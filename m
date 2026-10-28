Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181551;
	b=im3OTRuO/pVso8efWX7BbZatsJ0wrL94S8q82ewl/yXO9go2/IXDIdk8zRMjDqt+ARwW
	 zlfjcVE4f2aJNHtj/huinxMG9n+X/b5LRfJ4igiwzXMWMs/9BvB0/ggHJ5rZqwxbZ35Kx
	 7PT5tEdHb/PCBkTl8baO5rvOb3r+JKVB8I1EtUNYCywuD3rOwJcrmYlD7C3c8/4C4cuQ9
	 NcovgSaB/jzydVy1Aa5A57eAPhvgpuK/P2MxC2HEZTjnqynM2yJgsUfN/q6mYTWTqR56h
	 Q38FQNjJKjiruQay7ARe5W3IRp+Q/UHXmC6IH9TdSJ9pRqbFdkyTujLRG/PAtXr0CqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181551;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=W4v1koaYCedVk/4Qr3RSyIVEy9SCXdn2NBPrmVyCL58=;
	b=nZ7IOavXWlZeSpf8EDXbVAVhHE1OevyYMBbmjw6pnf5Fsft8dlefk3Qp1kEi3i3Skwc1
	 nti5R+wuzEyCxLT3StU8uKGbgC1frNu/+fpWa4eGPIVw53D538lvgUiGKIci08kk2Z94m
	 bNsEbct8pYp2FypoGVoTco16njVnSg31S+FBrZxD7EkXqpvUpAi2BfUpUZqqnfe0JAuQs
	 u+rt/fji2tCqD03kWVBuKeNvQmdKCWCWAgj2olWfTymZ76kDH6hxKInO75ebmtqINmdh/
	 u/Lmd2uNrsPSKxYGcOZCxzStIKG9ngL9CsEsc6tPpDZfVkZ96tpCr6itE+bEX1FIGUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b="py/B7reN";
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318560A2604;
	Wed, 28 Oct 2026 09:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C318560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=py/B7reN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=W4v1koaYCedVk/4Qr3RSyIVEy9SCXdn2NBPrmVyCL58=; t=1793181549;
	x=1793786349; b=py/B7reN5OeLy05WqcFptCoVOYxNlpZFTTdfj7SXvvipfqzahiFhX9ULdw5o6
	eZODY4anRA9kY5jXEA41yETnvnHd7/E3zloFxfijM+cxz/Ef+3eGTlVUef2QwUphrbOYUhZe4kOVF
	5KpTRW4HT4jZ67RdS/ae5NFC0RBl4SKuA5UNHjmmgLFoo+r/YNuk9PF/YiIz7YA03LfhrIvhCueYi
	lo+mzsdLnnQqPuRbiu+YC1DO5kq260UJ0ui8cKUjGzXWWvpsiFnq/5grpO47x9Bx8aoiJHXOBmWaq
	2LiqKfBTgYkBzIVTQy2DAIf981XPyfukOyYSw8Ln05wu+rF1NA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xM0Qr-00000001bPL-1ezN; Wed, 28 Oct 2026 10:58:57 +0100
Received: from dynamic-077-183-189-206.77.183.pool.telefonica.de ([77.183.189.206] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xM0Qr-000000029hA-0ZlA; Wed, 28 Oct 2026 10:58:57 +0100
Message-ID: <8d4993cb2f2e5c3300514f1e2616e4a101488883.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Imre Kaloz
 <kaloz@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson	
 <andreas@gaisler.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 "Mike Rapoport (IBM)"	 <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett"	 <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka	 <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato	 <pfalcato@suse.de>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko	 <mhocko@suse.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 28 Oct 2026 10:58:56 +0100
In-Reply-To: <25f5cbed-9126-4870-a81e-65099155bc9d@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org>
	 <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
	 <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org>
	 <20261027212610.6798-1-kaloz@kernel.org>
	 <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org>
	 <20261028091631.8072-1-kaloz@kernel.org>
	 <25f5cbed-9126-4870-a81e-65099155bc9d@kernel.org>
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

Hi David,

On Wed, 2026-10-28 at 10:22 +0100, David Hildenbrand (Arm) wrote:
> On 10/28/26 10:16, Imre Kaloz wrote:
> > Hi David,
> >=20
> > On 10/28/26 09:49, David Hildenbrand (Arm) wrote:
> > > But that's too complicated, requiring page table walks ....
> > > People running museum piece hardware and complaining about performanc=
e of mremap
> > > or memory reclaim should reconsider life choices.
> >=20
> > I'm one of the museum folks myself, though more the kind who loves
> > running a modern kernel on old hardware than the kind who complains
> > about it :) A lot of these machines are still doing real work, and
> > these days not everyone can, or wants to, just buy a new computer.
> >=20
> > Some of us spend our time keeping these platforms working, and I'm
> > not asking anyone else to carry that, which is why I tried to keep
> > all of it in sparc.
>=20
> Okay, so mremap() and reclaim memory performance concerns make you sleep =
bad at
> night? :)
>=20
> Don't get me wrong, I know that running new kernels on old HW is fun.
>=20
> Last week a got upstream Linux running on a 32bit x86 notebook from 2007 =
with
> the snap of a finger. Everything just works (using Alpine).

That's cool!

> I couldn't care less about performance. Nobody should.

Well, try to put it into some perspective: For some people, old hardware
is all what they have and given the current high prices, I assume many
people will be stuck with old hardware for a while now. Think of developing
countries as well.

> The biggest problem all of us with supporting old hardware is the maintan=
ance
> cost. Not just core-mm, but also things like ad-hoc page table walkers yo=
u are
> adding we (from core-mm) might have to touch at some point.

Well, but if people are using it in the end, I think it's justified to supp=
ort it.

> If there is no good reason for the complexity, out it goes.

The patch doesn't really look that complex though. It adds an additional pa=
rameter
to move_pte() which adds a few more lines of code. Not really overly comple=
x, I think.

> Because otherwise people will push more and more for removing legacy supp=
ort
> completely, and that's not what you want, right?

I don't think it's fair to make the kernel exclusive to very recent hardwar=
e only.

Adrian
>=20

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
