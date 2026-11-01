Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793532830;
	b=nHM1rVgWzfXlM6+BYJD6QRtWyhOYyfPw6QCDwWgbNybEpLfwK3atvSSTvsN5BEhMRIgL
	 BNZv+mi4DyM7SREIORnxSsiOcK05RfXA1EndRBIayKW99DJjsGgUTFkdpH0oQEmPaHb0x
	 18UpNa0onj8GZqHL712qPnI7iv6TyrhYjGfqsFER2Y4C1epiMkrxqyz48cyFH7juWqVbN
	 Dyv+3n+WAQa/5pjkL83yZVCzKt8GQ5/dKv+3hVAlZcAnfT3JzOy9afQEmIZOJgmj05wIT
	 tDD999EAyz1mx+eOcajPs6Ij/0YVinYmrcSUxNkZlfRgUhV1O6Ht5a8MxnXwbP4N/gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793532830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZucjxcIOZT96+ifnpo9/4UgFfTeoAmr1i+BH06TsIRw=;
	b=pOAkjsmZS+3nJs7LJnu5ZO5Avt+VnbQs0JAEmw+c6lBt2qs1fVWRXh3OTImc1eVpCe/Z
	 8GanI/bEBJT9n0CrPu5vr2PL++MUJUQp/rlWI1VTYeyd0YU24hfNX6x+O4cGJSr5F5scQ
	 H/J3dS99a5eSCtfzzv+Zt/OCTR64lIoGVP2NZ0QH5G98LQErB8EOWfXoOcU6OAmQSgeJu
	 zwkh9Cnw/HvHqpeuR1lbn5IFV6kRx94qnykGOEDtuc386W7XEq1Xa0HN3MoO7ALPMpANT
	 g27S5yxCvoAdnCRLBoUnpvc7QC815YOazcUS7hKLHjcnbZtSbel9yUr4wARzWsfueng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKMEwJAE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39539606A324
	for <sparclinux@vger.kernel.org>; Sun,  1 Nov 2026 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKMEwJAE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E021F000C1;
	Sun,  1 Nov 2026 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793532829;
	bh=ZucjxcIOZT96+ifnpo9/4UgFfTeoAmr1i+BH06TsIRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKMEwJAEVkHL+rAGjxwEZVwRSOvYTgHsVYLtll3qVwPvKNw4skAlccxj7UKCGiyUI
	 UHrHvevg84tkKMjHZntCi3Qhv/1kKCpIxQX9BXpSe0Cb8dwrTFMVJhsEwYeIRfg7FX
	 GZzQGJvpOfEtMEUqAtsjLw1EwAO0OmAMcHK3Fn7URNIzOTmuWuMV1Do9ilpIvrtobc
	 dkParMI0FnSDcXa7OIdxLq3FjNAYLk1S/x1kk2lldsRgje+V0pV3oZSkkjSTZBCI1O
	 xGPJdTCOYc5avy/6aaFUghchfusPqxZ1lglEtzKKPIVrZ0fX6q8U8HIlpRRlz4s9x7
	 hBvcScjbPmFYw==
Message-ID: <sashiko-outbox-192381@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next v1 1/2] net: add SO_NO_RFS to exclude a
 socket from RFS and aRFS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Zuevsky" <vitaly.zuevsky@gcore.com>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261031113330.45704-2-vitaly.zuevsky@gcore.com>
References: <20261031113330.45704-1-vitaly.zuevsky@gcore.com>
 <20261031113330.45704-2-vitaly.zuevsky@gcore.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 11:33:49 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: stale rps_sock_flow_table entry when SO_NO_RFS set in sk_se=
tsockopt()
--

commit f945cdda3b76cd51e3536a08a7c03f44d3ce0486
Author: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>

net: add SO_NO_RFS to exclude a socket from RFS and aRFS

This commit adds the SO_NO_RFS boolean socket option and corresponding
SOCK_NO_RFS socket flag to allow excluding a socket from RFS and aRFS flow
steering. When set, _sock_rps_record_flow() and _sock_rps_delete_flow() ret=
urn
early without updating net_hotdata.rps_sock_flow_table.

[ ... ]

> diff --git a/include/net/rps.h b/include/net/rps.h
> index e33c6a2fa8bbc..5afa488682360 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -98,6 +98,13 @@ static inline void _sock_rps_record_flow(const struct =
sock *sk)
>  	 * [1] : sk_state and sk_prot are in the same cache line.
>  	 */
>  	if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
> +		/* SO_NO_RFS: application asked us to never steer this flow.
> +		 * Tested after sk_state so the common case stays on one
> +		 * cache line.
> +		 */
> +		if (unlikely(sock_flag(sk, SOCK_NO_RFS)))
> +			return;
> +
>  		/* This READ_ONCE() is paired with the WRITE_ONCE()
>  		 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
>  		 */
> @@ -111,6 +118,12 @@ static inline void _sock_rps_delete_flow(const struc=
t sock *sk)
>  	rps_tag_ptr tag_ptr;
>  	u32 hash, index;
> =20
> +	/* Never recorded, so never clear a slot that may belong to
> +	 * another flow.
> +	 */
> +	if (sock_flag(sk, SOCK_NO_RFS))
> +		return;
> +
>  	hash =3D READ_ONCE(sk->sk_rxhash);
>  	if (!hash)
>  		return;

[ ... ]

> diff --git a/net/core/sock.c b/net/core/sock.c
> index e7405be8941f9..02b8cc4bc1c44 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1597,6 +1597,10 @@ int sk_setsockopt(struct sock *sk, int level, int =
optname,
>  		reuseport_update_incoming_cpu(sk, val);
>  		break;
> =20
> +	case SO_NO_RFS:
> +		sock_valbool_flag(sk, SOCK_NO_RFS, valbool);
> +		break;

[Severity: Medium]
What happens if userspace enables SO_NO_RFS on a socket after it has already
recorded an entry in net_hotdata.rps_sock_flow_table?

For example, when a listening socket does not have SO_NO_RFS set,
inet_accept() -> __inet_accept() records the newly accepted socket before
returning the file descriptor to userspace:

net/ipv4/af_inet.c:__inet_accept() {
	...
	sock_rps_record_flow(newsk);
	...
}

The same applies if setsockopt(SO_NO_RFS) is called on a connected socket
after an initial sendmsg() or recvmsg().

Because sk_setsockopt() sets SOCK_NO_RFS without calling
sock_rps_delete_flow(sk), the existing entry remains in
net_hotdata.rps_sock_flow_table, so get_rps_cpu() and set_rps_cpu() continue
steering the flow to the previously recorded CPU. When the socket is later
unhashed, _sock_rps_delete_flow() sees SOCK_NO_RFS set and returns early
without resetting table[index].ent to RPS_NO_CPU, leaving a stale entry in
rps_sock_flow_table.

Conversely, because sock_rps_save_rxhash() still populates sk->sk_rxhash wh=
en
SOCK_NO_RFS is set, if a socket receives packets while SO_NO_RFS is enabled
and later clears SO_NO_RFS before closing, wouldn't _sock_rps_delete_flow()
see a non-zero sk->sk_rxhash with SOCK_NO_RFS cleared and clear
table[index].ent even though the socket never recorded itself?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031113330.4570=
4-1-vitaly.zuevsky@gcore.com?part=3D1
