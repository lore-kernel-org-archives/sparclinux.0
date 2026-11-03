Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681343;
	b=qsac+/6+ujaNj9dmiVGCnymIBSIN+VEgvhtu1dZlyghmwqhhLy3wOrT4vsFJl+ZTmyrU
	 TvZeJat3x1KPl7LyU+VVBrDEmLbqBTfpR454h+waOrqppKs0ljDuDc0raAHCIgMk6uQW9
	 gWDynNcbOgHscB2iFy8aLTsxd4yVClh4KspuPzpfb2r+CdcyFnbDJZWK4Ma8v/IAyDMx3
	 r5SaM7zWmLwipIxDYR8ntzuRrOqWHvNsfZjUpINzRgF4RUHmjJ1enszXrFYgQ0JeZOgdj
	 /o7X74h4AW+7EQywC/e3ZURuBaYLGjLl32GpGvX+8oBzwussaad3uQg5gsGLjMoS8gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xpPM8d6E2sOmuORX+oJQ/3Yb6xz98T79nukjUCv60w0=;
	b=sWHrlfjN4qsYgXAJ33YTDhZa7xZQqSE3ip+vbVQ29CTA8H+FuN0mdFuEgvUmUXqvM3QH
	 y9sNT6GcYCsBTvjBb5CkkujW/hJICWtHJIXncLQ6l7Ux+nQyEPmYzvTTFtmE8nsWJ8S4S
	 te1lHqtoLz958WSJAigamYjG2ChCkMHNZSy8QxEmKwP73Nvi4Dv2xIt57bUo71qJ4+AuG
	 8uBbsE+rWLhz9Rh9EyKZ52p913LORNeHDTy9Ji8MwCS6NkxRxmpNMh8iCLLqxgCDc/TO5
	 ea2/9NoNQRAoJdFRwoBTVr4XmK7Wx6pfKd/wo0uXfWaJVEapIPgEc4NkAEYKSuq3Wzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N3yb8+oy;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84691606A330
	for <sparclinux@vger.kernel.org>; Tue,  3 Nov 2026 04:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84691606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N3yb8+oy
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adc5b185bfso4011978a91.3
        for <sparclinux@vger.kernel.org>; Mon, 02 Nov 2026 20:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793681342; x=1794286142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpPM8d6E2sOmuORX+oJQ/3Yb6xz98T79nukjUCv60w0=;
        b=N3yb8+oyTXT5JmTpHZoNiyTZDZyViCCgxID1pC+ipOJlnaGTUES+eSgUktKLb6Ed7b
         Bcu40a285vRAYe+p0EBWCbP8XOr475B2EH6Djl7GLJoYXUYnOak+Qc41B04TBNPlJ1Xj
         X0k4g0c4ECEzScqGR83aMPTeecbGzdCJtSuye0sSmqp+B1QYQGfE8KuLEACn5EFeVu7A
         tuZkJhYU0SxS6gn3VJyUrE8wull93UwkmYHM4kAEcOcASepeCgbX6ZkGeZvN1IehLwT2
         mtm8P5HrSKgfxu5TUUyUX/2Dumh0mQK5nuXUhHLDdzDO0Kg08OWhWmCOcRAcA9OmrKVk
         W7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681342; x=1794286142;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpPM8d6E2sOmuORX+oJQ/3Yb6xz98T79nukjUCv60w0=;
        b=PRNeKzis2VrlxeY6xrO8UqOgziYNHpsXDmc+mAEaHLwrOSWRiBcYrdflvKJP2TV66R
         FsXoajMPRUdWaN5Q0mHQ78S+traCPs848l/fn8Sf6x1F/a81ASzC5pEZRPMdevcNwNp7
         EelMZ+kLvZZ3P269o4Bgdg00Et/Z6ik/QmB3bFpdBH6q6pKW1FGNoOcN/yBv48U/HHek
         D9YbFKRU209CoGF+j89fP3VueWPvRGcyO8crTvOQYcwZQ+whsUENi0eIdf7p3H54vbM7
         vyFaoeMladv0mWyueQjI4Za952lULqPx5ghZi6M//tZ1zr+fvdVng5R4xNERzBwqpswk
         b+OA==
X-Forwarded-Encrypted: i=1; AKwUvBzuI1iS5KCkxyiozGswOequKXtcw1w0aMmatq0/QGcp4+sEMcnCGAGREJnxhrFSaKK7dzWkBYRBB0Xa@vger.kernel.org
X-Gm-Message-State: APuU4Z/ROqfPqxBDvteBImKGjiUaMLRBHyeDS4u3QZcw0VyDmHfssIMl
	kgGEbUtMu/ylD4/1AsiE31IOn0U5cSR0w7kxBe8k3LnhCOoVZs4porlGttRecwNlgktcf+H6o5l
	OMM/ITw==
X-Received: from pgbj23-n1.prod.google.com ([2002:a05:6a02:61d7:10b0:ccf:d903:c14c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8b:b0:3ab:c80:9370
 with SMTP id 98e67ed59e1d1-3ae89724ae3mr8703357a91.20.1793681341720; Mon, 02
 Nov 2026 20:49:01 -0800 (PST)
Date: Tue, 3 Nov 2026 04:49:01 +0000
In-Reply-To: <20261031113330.45704-2-vitaly.zuevsky@gcore.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261031113330.45704-1-vitaly.zuevsky@gcore.com> <20261031113330.45704-2-vitaly.zuevsky@gcore.com>
Message-ID: <aulmWD9VUXcwgp6h@google.com>
Subject: Re: [RFC PATCH net-next v1 1/2] net: add SO_NO_RFS to exclude a
 socket from RFS and aRFS
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Willem de Bruijn <willemb@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Andrew Halaney <andrew@amutable.com>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Chuang Wang <nashuiliang@gmail.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, 31 Oct 2026 11:33:29 +0000, Vitaly Zuevsky wrote:
> RFS and accelerated RFS are enabled per host and per rx queue, but
> whether steering helps is a property of the flow. A host that carries
> a few long-lived flows which benefit from steering alongside a large
> churn of short-lived flows has no way to express that today.

FWIW, we have the exact same option in our kernel since 2019,
it was named SO_BYPASS_RFS with skc_bypass_rfs:1.


> 
> Add a boolean socket option, SO_NO_RFS. When set, sock_rps_record_flow()
> does not record the socket in rps_sock_flow_table, so get_rps_cpu()
> finds no match and neither software RFS nor ndo_rx_flow_steer() acts
> on the flow; it stays on the CPU chosen by RSS or RPS.
> 
> The option is kept in sk_flags so that sk_clone_lock() copies it to

I posted this so that you don't need to access to cold cacheline.
https://lore.kernel.org/netdev/20261103044213.1336347-1-kuniyu@google.com/T/#u


> accepted children: setting it on a listening socket excludes every
> connection accepted from it, while sockets the same process connects
> itself remain eligible.
> 
> sock_rps_delete_flow() is skipped as well, because a socket that never
> recorded itself must not clear a table slot that may belong to another
> flow.
> 
> The test sits after the TCP_ESTABLISHED check and inside the
> rfs_needed static branch, so hosts without RFS pay nothing and hosts
> with RFS pay one test_bit() on a cache line tcp_recvmsg() already
> touches.
> 
> Signed-off-by: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 ++
>  arch/mips/include/uapi/asm/socket.h   |  2 ++
>  arch/parisc/include/uapi/asm/socket.h |  2 ++
>  arch/sparc/include/uapi/asm/socket.h  |  2 ++
>  include/net/rps.h                     | 13 +++++++++++++
>  include/net/sock.h                    |  1 +
>  include/uapi/asm-generic/socket.h     |  2 ++
>  net/core/sock.c                       |  8 ++++++++
>  8 files changed, 32 insertions(+)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 5d3524c26b2b..256d37f5b9b0 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -161,6 +161,8 @@
>  
>  #define SO_PEERPIDFD_THREAD    87
>  
> +#define SO_NO_RFS              88
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index 245a43f52fb1..5b477de463a3 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -172,6 +172,8 @@
>  
>  #define SO_PEERPIDFD_THREAD    87
>  
> +#define SO_NO_RFS              88
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index f23710e1c671..b3a4cc2cbc50 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -153,6 +153,8 @@
>  
>  #define SO_PEERPIDFD_THREAD	0x4055
>  
> +#define SO_NO_RFS		0x4056
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index b35b25bdefc2..ba5ed7942570 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -154,6 +154,8 @@
>  
>  #define SO_PEERPIDFD_THREAD      0x0060
>  
> +#define SO_NO_RFS                0x0061
> +
>  #if !defined(__KERNEL__)
>  
>  
> diff --git a/include/net/rps.h b/include/net/rps.h
> index e33c6a2fa8bb..5afa48868236 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -98,6 +98,13 @@ static inline void _sock_rps_record_flow(const struct sock *sk)
>  	 * [1] : sk_state and sk_prot are in the same cache line.
>  	 */
>  	if (sk->sk_state == TCP_ESTABLISHED) {
> +		/* SO_NO_RFS: application asked us to never steer this flow.
> +		 * Tested after sk_state so the common case stays on one
> +		 * cache line.
> +		 */
> +		if (unlikely(sock_flag(sk, SOCK_NO_RFS)))

Move this to just after rfs_is_needed().

With skc_bypss_rfs in the hot bit, access to it and skc_state
adds no cost.


> +			return;
> +
>  		/* This READ_ONCE() is paired with the WRITE_ONCE()
>  		 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
>  		 */
> @@ -111,6 +118,12 @@ static inline void _sock_rps_delete_flow(const struct sock *sk)
>  	rps_tag_ptr tag_ptr;
>  	u32 hash, index;
>  
> +	/* Never recorded, so never clear a slot that may belong to
> +	 * another flow.
> +	 */
> +	if (sock_flag(sk, SOCK_NO_RFS))
> +		return;

Same.


> +
>  	hash = READ_ONCE(sk->sk_rxhash);
>  	if (!hash)
>  		return;
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 173b37b2b8bb..4472dc4ed28e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1024,6 +1024,7 @@ enum sock_flags {
>  	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>  	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
>  	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
> +	SOCK_NO_RFS, /* SO_NO_RFS: never record this flow for RFS/aRFS */
>  };
>  
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 56fed7ab27ab..9bf415b0d470 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -156,6 +156,8 @@
>  
>  #define SO_PEERPIDFD_THREAD	87
>  
> +#define SO_NO_RFS		88
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index e7405be8941f..02b8cc4bc1c4 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1597,6 +1597,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		reuseport_update_incoming_cpu(sk, val);
>  		break;
>  
> +	case SO_NO_RFS:
> +		sock_valbool_flag(sk, SOCK_NO_RFS, valbool);
> +		break;

Guard this with CONFIG_RPS.


> +
>  	case SO_CNX_ADVICE:
>  		if (val == 1)
>  			dst_negative_advice(sk);
> @@ -2118,6 +2122,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  		v.val = READ_ONCE(sk->sk_incoming_cpu);
>  		break;
>  
> +	case SO_NO_RFS:
> +		v.val = sock_flag(sk, SOCK_NO_RFS);
> +		break;

Same here.


> +
>  	case SO_MEMINFO:
>  	{
>  		u32 meminfo[SK_MEMINFO_VARS];
> 
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> -- 
> 2.34.1
> 
