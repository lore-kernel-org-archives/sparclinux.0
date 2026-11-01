Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793532830;
	b=cifxn1N+asp5r8W/3vn8mMWygkgv2dMFjsO8e16wDBCwySI8UhX86zJVP5MYng7P9uJN
	 IK0Umq9Fr9tuKhZgVBIXvujAby6cFbvIC0rPtqXj0Vj6+yC1gTRTtl1vwmZPxZZxmpKoU
	 vp63wSM+enq+n46GSdhDeSrreG51yXTjy2cKmy08qrdX2PUolrcsy/I3CSKqQKG3lbesG
	 dhL8o3XymY0y1FRz+grjGlQop4GMqiTlS+KvdIURixm6MDfl8avHkigwX8cfN+A9tP9Cy
	 RDXj3/C/ccCbq3pAsLl+rQszLs/2PAtm3QYxXTT/oC3MPZRlHJzujphmaha7frGbdHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793532830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cW5S00mfOSZBFIARwmlb2s49g3zLcUVv2ulbxaVAVy4=;
	b=iCTRgTNV7zFTfPQBo8ZvQUS4IToZdciF5wJqpvsUgB07oIuft1nzHkQUWV7pDe4uCMuB
	 IUo2m1YkcuSiQh7K5ceZ1GD35fe9WNrwqm10rq6hUP8fyH/CDPdD5mD4Sk/PfwhVHoT/9
	 vj7i3nwmE4x5N2MVQGzl7T26/dXNhhNXKbZsd1a2R5lEIbHKM+tjwX77U/eAZIuAO5aIo
	 Ob4WXHZLTDogx0VuzyhbQ5g7mbG8VQbYn8E8VdMdjfYua0NHE1VDWr+XHRlo9dMzSRdAo
	 S2iKPwJ64fnVifylq8WNCCBqKBwvbxKhazB6U+Ap1q4nX/IdiWqvkhFnaOJQRbvQqgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaTM1Ulh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6D606A325
	for <sparclinux@vger.kernel.org>; Sun,  1 Nov 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaTM1Ulh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4415C1F00919;
	Sun,  1 Nov 2026 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793532830;
	bh=cW5S00mfOSZBFIARwmlb2s49g3zLcUVv2ulbxaVAVy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WaTM1Ulh7K18zwsoIPpo9jdW2aMN4e0n8UInPxX5WmtrMfq6Eqj2Fqwa+fL4zEB57
	 OJg0jx8Tsa6noPdgTxVJspn3xq93YXTcyw/8fjEqpFHjdIWIsEvilGBJHHPX1zMw+o
	 GFMkRfIh8a9BK9U0tV9i03Cac1xvMpgeF0j72I7Or/gsJrquZ9M8UAMlUHREDZMw8/
	 BuEnZqjJT6m3qEVpWgeNWXcYGp57rbc2G+PJOjvZnHJ4pGCVZx468zMUA/r1buuyHI
	 ERiObxs1xHHFmhuw6X503Q/1SshFcobrHaLC3NBa6HoqyTgjVOO3zBPCrMVxugAI/m
	 hg66GIONkRD1A==
Message-ID: <sashiko-outbox-192382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next v1 2/2] Documentation: networking: document
 SO_NO_RFS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Zuevsky" <vitaly.zuevsky@gcore.com>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261031113330.45704-3-vitaly.zuevsky@gcore.com>
References: <20261031113330.45704-1-vitaly.zuevsky@gcore.com>
 <20261031113330.45704-3-vitaly.zuevsky@gcore.com>
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
- [Medium] net: stale rps_sock_flow_table entry when SO_NO_RFS set on activ=
e socket
--

commit 42cabc51ee3ece5cddea8fc01572ac23fc041dc0
Author: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>

Documentation: networking: document SO_NO_RFS

This commit documents the SO_NO_RFS socket option in the networking scaling
documentation, describing how it disables RFS and accelerated RFS for
individual sockets and is inherited across accept().

> diff --git a/Documentation/networking/scaling.rst b/Documentation/network=
ing/scaling.rst
> index 6c9836000a8d1..54c7a72da5632 100644
> --- a/Documentation/networking/scaling.rst
> +++ b/Documentation/networking/scaling.rst
> @@ -428,6 +428,20 @@ queues. So for instance, if rps_sock_flow_entries is=
 set to 131072 and there
>  are 16 configured receive queues, rps_flow_cnt for each queue might be
>  configured as 8192.
> =20
> +Excluding individual sockets
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +RFS (and therefore accelerated RFS, see below) can be switched off for
> +a single socket with the SO_NO_RFS socket option. Flows of such
> +sockets are never recorded in rps_sock_flow_table and stay on the CPU
> +selected by RSS or RPS.

[Severity: Medium]
Does enabling SO_NO_RFS on an already-accepted or active single socket
actually prevent its flow from being present in rps_sock_flow_table?

When a passive connection is accepted from a listening socket that does not
have SO_NO_RFS set, __inet_accept() records the flow before returning the n=
ew
socket to user space:

net/ipv4/af_inet.c:__inet_accept() {
	...
	sock_rps_record_flow(newsk);
	...
}

Similarly, any connected TCP, UDP, SCTP, or MPTCP socket records its flow in
net_hotdata.rps_sock_flow_table as soon as poll(), sendmsg(), or recvmsg()
calls sock_rps_record_flow().

If the application then enables SO_NO_RFS on that socket, sk_setsockopt()
only sets the SOCK_NO_RFS flag without deleting the existing entry from
rps_sock_flow_table:

net/core/sock.c:sk_setsockopt() {
	...
	case SO_NO_RFS:
		sock_valbool_flag(sk, SOCK_NO_RFS, valbool);
		break;
	...
}

Because the slot in rps_sock_flow_table remains populated, get_rps_cpu()
continues matching the socket's flow hash on incoming packets and continues
software RFS steering and ndo_rx_flow_steer() hardware filter programming to
the previously recorded CPU, while _sock_rps_record_flow() returns early on
subsequent CPU migrations.

Furthermore, when the socket is later closed and inet_unhash(),
udp_lib_unhash(), or sctp_unhash() calls sock_rps_delete_flow(),
_sock_rps_delete_flow() sees SOCK_NO_RFS set and returns early without
resetting the table slot to RPS_NO_CPU:

include/net/rps.h:_sock_rps_delete_flow() {
	...
	/* Never recorded, so never clear a slot that may belong to
	 * another flow.
	 */
	if (sock_flag(sk, SOCK_NO_RFS))
		return;
	...
}

Should sk_setsockopt() call sock_rps_delete_flow(sk) before setting
SOCK_NO_RFS (or restrict SO_NO_RFS to unestablished sockets), and should the
documentation clarify the behavior when SO_NO_RFS is set after a flow has
already been recorded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031113330.4570=
4-1-vitaly.zuevsky@gcore.com?part=3D2
