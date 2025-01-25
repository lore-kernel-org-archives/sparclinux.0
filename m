Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B27DA93;
	Sat, 25 Jan 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827709; cv=none; b=Kwo15p2/ch5ftK/p1DHha9QE6h2WZU9YglOvg2rqHX9TJYjQAPVBXF5kHjDsFNycM8fpXmVwlJwU0uZ639rFgFYPylnq6Fz63gYE2J5GGvx5429r9EhgHkIiI+TUV93HQEZ1OOaLxxLwYk2vMPo0cUVmZr1IbkfuvueDreOkqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827709; c=relaxed/simple;
	bh=FKOtGkC3Mn3W3eZpHUygkv9D/3wxgqPgfVCM4l7orxI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5mksLf5V3s4itW02h0cxiDSBoQuRvtXnNOH+lwVdHYcZfMCpgD0HoxJMA+jkSEaEVORSNJdqof511BlcdtFF9CQBZJ7Ev8AdCZ38NUTg/tLZMD9BT3ocWLHbj+rRfI62U+iANGJ2JfMdrBh9XV21JEfRKxph/xhIzx8t5qjsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=mNczObCo; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="mNczObCo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HyulpAZXyyjqEmzfX4x/M01Tzctwcyfopbc7hJ0P3Qw=; t=1737827705; x=1738432505; 
	b=mNczObCogfj+jF4jmR6TUY3UZJqJ5ZLlhX4ZvSCUAmC4GBUy3zzOJrtDz1zu5oTIKlcGTPLF0Qd
	VWwJvdUZIWE7gxYFdlnUImRmSmPde9vUYm07D3Wjle2WcxzmWEJyZKa/Zn6aOEmKFg2RNdhGqzVpL
	ONRrJiJzS9d35IqTooQanrMvF8k6RoVBJifUTvSYyKj+Q6oKekqw2qWtdbCvmguj/MQBAUvV/7YXS
	pBfuKLcL+isO5RH4W0XywBq+x8l9nfOE0muHMgmqSqeY2UpzVIeNf/EvFpzNzR1AfM3/nKjc+tBCV
	BwD2Dj4ufBJ2jon2owLAJ7hhPQa3D6InGy8w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tbkMt-00000000qCm-41Gu; Sat, 25 Jan 2025 18:54:51 +0100
Received: from p5dc55cec.dip0.t-ipconnect.de ([93.197.92.236] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tbkMt-00000001wI9-2vIi; Sat, 25 Jan 2025 18:54:51 +0100
Message-ID: <a4e33e0da39e0644dd2579ba0ef3c1482f14ae68.camel@physik.fu-berlin.de>
Subject: Re: sched/debug: Dump end of stack when detected corrupted
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Feng Tang <feng.tang@intel.com>
Cc: akpm@linux-foundation.org, bristot@redhat.com, bsegall@google.com, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
 linux-kernel@vger.kernel.org, 	mgorman@suse.de, mingo@redhat.com,
 peterz@infradead.org, rostedt@goodmis.org, 	vbabka@suse.cz,
 vincent.guittot@linaro.org, vschneid@redhat.com, 	sparclinux@vger.kernel.org
Date: Sat, 25 Jan 2025 18:54:50 +0100
In-Reply-To: <Ztrr10sxYvQQGonC@feng-clx.sh.intel.com>
References: <20231219032254.96685-1-feng.tang@intel.com>
	 <20240906084546.3304-1-glaubitz@physik.fu-berlin.de>
	 <Ztrr10sxYvQQGonC@feng-clx.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Feng,

On Fri, 2024-09-06 at 19:47 +0800, Feng Tang wrote:
> Hi Andrian,
>=20
> On Fri, Sep 06, 2024 at 10:45:46AM +0200, John Paul Adrian Glaubitz wrote=
:
> > Hi Feng,
> >=20
> > > -	if (task_stack_end_corrupted(prev))
> > > +	if (task_stack_end_corrupted(prev)) {
> > > +		unsigned long *ptr =3D end_of_stack(prev);
> > > +
> > > +		/* Dump 16 ulong words around the corruption point */
> > > +#ifdef CONFIG_STACK_GROWSUP
> > > +		ptr -=3D 15;
> > > +#endif
> > > +		print_hex_dump(KERN_ERR, "Corrupted Stack: ",
> > > +			DUMP_PREFIX_ADDRESS, 16, 1, ptr, 16 * sizeof(*ptr), 1);
> > > +
> >=20
> > I would recommend determining the buffer element size with sizeof(unsig=
ned long) for
> > better readability and using "true" instead of "1" to set the value of =
the ascii
> > parameter to print_hex_dump(), see [1]. Otherwise looks good to me.
>=20
> Thanks for the review! Yes, I can make that change.
>=20
> > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >=20
> > PS: Please CC me for a potential v3.
>=20
> Sure.

I was just remembering this patch. Any chance you can put out a V3, so
I can review it and someone can hopefully pick it up in the right tree?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
