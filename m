Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275161;
	b=LylpQB/Dc6IsI2LDY9nZnA1OX2KvJdCvnxENG8pEtYi+2fvy+50gcFgy/jKzTxXqQWJI
	 OXn1+5DfCmUS31zaNVx2r0ysWpp80FlOpQzITMhtw0btwwwBstIekZni9ZncXaeqS3lT1
	 ovHL8q3cqnORC+s/0+E4t2v8/w5GdzuxxH1YRb+b57CPni29K+bGeeqWsMPgXiavlb5lt
	 zFlVorNr9W6pERnOG31ibMEQD066etb5j1Z9155bkeQ52NxnTp9RjMQ6c4qszhiwstW5V
	 NEaE3gOhanXrWt4zYGuBapOCW5BFCR8VdKkiPyyvkmCd6v3cRbYZK+twu/tJWNwu8Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BHbu7DtxTaCJENrjxojIT37r05A0OE9kUrheliounuY=;
	b=Qi1C8KcVnYjlRJhuHMafL7Lqovh/KK2BMhfyi2AfmaPwfA/S5BcDEb8X68fsUChqqcX5
	 D/BbpGaIf5M9agCbLHrgH+5S6aclwF6xEnbdyF0cK7fUNRGjSS7Q/uKBrvUccafh1rMZs
	 upLG6GHA8Cv0pnoqzKfpe+klIkKOHz9kYMW22fv+eJzK86TzcQr/QP8eEcLEqpcYSjBji
	 742t+11M/DDcWHX+bxU0Gx3qb6pTtl3ABf7JNZ5ls/n0xz/Am6w096nFWiOLOVoWaSPgD
	 85mEtxXUKjgxyU1Kxu7JAYNz9E0KKFwhLt3PwNf6dPrDhHgz93lZhnaGbfYGciOfQpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjbBnWxq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC9606A326
	for <sparclinux@vger.kernel.org>; Tue, 10 Nov 2026 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjbBnWxq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B571F008A1;
	Tue, 10 Nov 2026 01:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275160;
	bh=BHbu7DtxTaCJENrjxojIT37r05A0OE9kUrheliounuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjbBnWxqzhXBvxMobGkPbWk+IWQiRrO/gxaB4cH3H14KjE5kExTwvX41s2IoNUjgh
	 wg3MfYmA2rt0iGNUtm7/SNVbQu0OJPOhQ4W4G+6Fcm+EPi/ABRPQz1ZiSJDjmh37N8
	 JxRZhTpk+B9iXOWIB9LUPtrl2AjsgRDO++qKFbONr6z6Uuz7J15vUQ42cpZWendhtY
	 Zem0u1SEak/2QxRuurmySFVMxquAjBDRsFyZvsq3hMDkswdNi2eLI/Gg9f8mF6OhJq
	 RQzNY4lbRiy1pfpl7sgzbzrDpehHS2x9RGFZSJdrX4osV9PmxAiMsNFyHh6v+pDndl
	 O+0sj04Ywl7Gw==
Message-ID: <sashiko-outbox-205984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: add SO_BYPASS_RFS to exclude a socket
 from RFS and aRFS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Zuevsky" <vitaly.zuevsky@gcore.com>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261109014547.81555-1-vitaly.zuevsky@gcore.com>
References: <20261109014547.81555-1-vitaly.zuevsky@gcore.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:45:59 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: race in sk_setsockopt() deleting RFS flow before setting
  sk_bypass_rfs
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] net: file descriptor leak in sk_getsockopt() [1]
--

commit 0bb55ec9420355430d450dec603d8adf895ff281
Author: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>

net: add SO_BYPASS_RFS to exclude a socket from RFS and aRFS

This commit adds the SO_BYPASS_RFS boolean socket option and a skc_bypass_r=
fs
bit in struct sock_common to exclude a socket from RFS and aRFS flow record=
ing
and deletion.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index e2401d735c5a7..00808217aebf1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
[ ... ]
> @@ -1597,6 +1598,14 @@ int sk_setsockopt(struct sock *sk, int level, int =
optname,
>  		reuseport_update_incoming_cpu(sk, val);
>  		break;
> =20
> +#ifdef CONFIG_RPS
> +	case SO_BYPASS_RFS:
> +		if (valbool)
> +			sock_rps_delete_flow(sk);
> +		sk->sk_bypass_rfs =3D valbool;
> +		break;
> +#endif
> +
>  	case SO_CNX_ADVICE:
>  		if (val =3D=3D 1)
>  			dst_negative_advice(sk);

[Severity: Medium]
Can a concurrent receive or send re-record the flow between
sock_rps_delete_flow() and setting sk->sk_bypass_rfs?

Callers such as inet_recvmsg() invoke sock_rps_record_flow() without
holding the socket lock:

CPU0                              CPU1
sk_setsockopt(SO_BYPASS_RFS, 1)
  sock_rps_delete_flow(sk)
    _sock_rps_delete_flow(sk)
                                  inet_recvmsg()
                                    sock_rps_record_flow(sk)
                                      /* sk->sk_bypass_rfs is still 0 */
                                      _sock_rps_record_flow(sk)  <-- re-rec=
ords flow
  sk->sk_bypass_rfs =3D 1;

Once sk->sk_bypass_rfs is set, sock_rps_delete_flow() returns early, so
the re-recorded entry stays in rps_sock_flow_table while SO_BYPASS_RFS is
enabled and is not cleared when the socket closes.  Setting
sk->sk_bypass_rfs before calling _sock_rps_delete_flow() would avoid
leaving a stale entry if a concurrent reader races with setsockopt().

> @@ -2118,6 +2127,12 @@ int sk_getsockopt(struct sock *sk, int level, int =
optname,
>  		v.val =3D READ_ONCE(sk->sk_incoming_cpu);
>  		break;
> =20
> +#ifdef CONFIG_RPS
> +	case SO_BYPASS_RFS:
> +		v.val =3D sk->sk_bypass_rfs;
> +		break;
> +#endif
> +
>  	case SO_MEMINFO:
>  	{
>  		u32 meminfo[SK_MEMINFO_VARS];

[Severity: Medium]
This problem wasn't introduced by this patch, but can sk_getsockopt() leak
a file descriptor via sk_getsockopt_peerpidfd() [1] when optlen is
smaller than sizeof(int)?

net/core/sock.c:sk_getsockopt_peerpidfd() {
	...
	if (len > sizeof(pidfd))
		len =3D sizeof(pidfd);
	...
	pidfd =3D pidfd_prepare(peer_pid, flags, &pidfd_file);
	...
	if (copy_to_sockptr(optval, &pidfd, len) ||
	    copy_to_sockptr(optlen, &len, sizeof(int))) {
		put_unused_fd(pidfd);
		fput(pidfd_file);

		return -EFAULT;
	}

	fd_install(pidfd, pidfd_file);
	return 0;
}

len is capped at sizeof(pidfd) without checking that it is at least
sizeof(pidfd).  If a caller passes a smaller optlen, copy_to_sockptr()
copies a truncated value into optval and fd_install() installs the new
pidfd into the process's file descriptor table without the caller
receiving the full descriptor number needed to close it.

[1] https://sashiko.dev/#/bug/linux-49f253f1-047b-482f-9138-26dfe35242e3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109014547.8155=
5-1-vitaly.zuevsky@gcore.com?part=3D1
