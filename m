Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568165;
	b=zTOxglK8KgtN1pXk7E6s68xfHVgeGdXWpf8zk53WgioN6/shpKbDMUOqu2lzKbpXBtMX
	 Mxr9RkQy/Wj3md+F16Xn6SXf99+GP2yyZrdcrymnLgyB+CWm3NjX9Sz9rVirheuGoAU5X
	 k96r3CAdHUoGljFBbvgOKYFnP3TVPAfjwJLQ5OGnGAWVJSaedpe3LrcVQz9PI8sBEtm5z
	 NDnsDb8Yf2C3zDyRowrmfg+b7cIizZxAVsXvJ5xQfd+pgcJyb58gNU7O+WHj3cNae0+Ki
	 AM14+MApfODgciwHdaXT6hHLeD5iCFD+0u7CGTuqhuGOewczyIjM8wmr0PshJzu1K7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568165;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=YkrPJYGuN22LqlhtaKzTis883sMPr2P4NmJrMmHDtd0=;
	b=shaqKqiRqlV+5B/1XicQwr9Dn0KN/K6mfBjsv6B9j/HtMQD6CK4JMPpSCjUMp7hrylkf
	 yWX4sFQaAkAqT+5QTdvcwMzA+rnWoBYefMQ+ItBejl37pqdDIB3ooKEYyAJnvGn6CRzs/
	 MbLIf/OxNmpNccNWOErHsBJ5omH1H4wIkElwL7J+5AX3r9skXj5+tBSGHX5vNF2m5gDVA
	 L1dGBA9gs2BPMRG1NIRUL3JkJy6cOzifwxRv1qKZWwUcCHeLxeqDpnoCgb/N71jEiasBS
	 G/eDXmNjGURYov513u9+PJHFN/M8qc4xcydxiCldRHo/THrPf2738myLqTPGGq8YkNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=osdAobZl;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450D606A881;
	Fri, 13 Nov 2026 11:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D450D606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=osdAobZl
Message-ID: <8f50f1b1bcbb1e1ebeb97e23e0896bfdf92b47a7.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794568156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkrPJYGuN22LqlhtaKzTis883sMPr2P4NmJrMmHDtd0=;
	b=osdAobZlSOYt2lgfqIAHmeZhYvkkmnZbHSsSMYykPqOL/3MjTmUTtlpPnuGp5ArhYhJsha
	G48LQUgvbWKq61f8j46U34kccqLrvZ7dmCgdcse32Ut1ol3OS1xNM9SWNF+EWA0H3Xfmiv
	7oZ+wtEO7RiKp/OmUqV1ROtfh4MEkaM=
Subject: Re: [PATCH 1/4] sparc64: kprobes: Single-step from an executable
 instruction slot
From: Stian Halseth <stian@itx.no>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
	 <andreas@gaisler.com>, Naveen N Rao <naveen@kernel.org>, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 12:09:15 +0100
In-Reply-To: <undine-1794562347340141345-b03249069e19e203@undined.local>
References: <20261009180336.1315684-1-stian@itx.no>
	 <20261009180336.1315684-2-stian@itx.no>
	 <undine-1794562347340141345-b03249069e19e203@undined.local>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gVucIkXZSnn+fNtu2DLT"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-gVucIkXZSnn+fNtu2DLT
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Masami,

On Fri, 2026-11-13 at 18:32 +0900, Masami Hiramatsu (Google) wrote:
>=20
> With this change, the p->ainsn.insn becomes NULL here when kill_kprobe()
> calls this function because (1) init.text is removed or (2) probed module
> is unloaded.
>=20
> If another module is loaded at the same region and another kprobe
> is registered at the same address, register_aggr_kprobe() ->
> init_aggr_kprobe() -> flush_insn_slot(NULL) is called. This can
> cause a problem because it is defined as:
>=20
> #define flush_insn_slot(p)		\
> do { 	flushi(&(p)->ainsn.insn[0]);	\
> 	flushi(&(p)->ainsn.insn[1]);	\
> 	flushi(&(p)->ainsn.insn[2]);	\
> } while (0)
>=20
> Since the flush_insn_slot() is only needed if p->ainsn.insn is
> embedded in the struct kprobe, as this changed it to insn_slot,
> we don't need this macro anymore.
> So you should update it as same as other arch like:
>=20
> #define flush_insn_slot(p) do { } while (0)

Thanks for the review, I'll test and adopt that change in v2.

I'll check for any other feedback, then prepare the v2 later today.

/Stian


--=-gVucIkXZSnn+fNtu2DLT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCavbv2wAKCRDoeAEuJe36
Vn5tAP0WLfGIZ+2j1Jm/D4EbZn/oASoN5OasDMZ7QO9Pv7Mo7gEA5jM2+qvMKjjl
T9/2JGJex+ASHhpfpNjMYz26VVYxBAw=
=l2oT
-----END PGP SIGNATURE-----

--=-gVucIkXZSnn+fNtu2DLT--
