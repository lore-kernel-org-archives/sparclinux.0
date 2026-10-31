Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793459705;
	b=Nw3aXwmmS1WQdcr1sFwbSZVMjtIj6KrYqM062r3ZA4kK/F6BGPRp05fkIbzRx+yOCsUT
	 EAWS37RewefD2HLHJ2XSm3ZxvasSzMImB13F+hK8XVF72POn+jYQDD7NE6dpDz9t3crN9
	 dNNe3C15gCYHu2hZKfF6mc86a0R7BreVqlKjkXAgXJcLgQg3WebgiJCGoYtm4/PQCuP0p
	 o5F2By5Nd7s8QAoT3yAFLlKIE77jQxBto0oz4UkOyV+p5WrZXXxXuluk8PTiDwdd2PpAk
	 wpftvgR9p9aIanxj58I7hACx1gDZOfwFQILOVNkD69nY96mka+pNjXNgO3OTkupnwEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u4AoREHEWHwqK+9vsy9N5I/xo3mEZgUmU5DSaNM6uCY=;
	b=HMFOUx9eZ6X96kZLNr9u/OIt23DlbGMFoylz4UEKDd5s4H4S0xgxaGS0fFIbZIFVrLrF
	 BJNl9yrBzCqnOyKgcwCKzm+CxIfZF0F11lw2GS70yYzM7MCNMvuAArBh5Nuer9BBSldQZ
	 smuvOGt/G018b6R6Kz7FOPNCQnyEckWBp+bK710zqtOVygKs2dKsw+9tvoLPeClphchr3
	 wXB1FCsdkx7+7r6G8a7uw8C7Y8G2MuLqPK12aLPuqTJ6kdCZEEG/4cScYt1STdNk08id6
	 3FyevRlAZFMmAHybm1tfJIZL1PFszUx21xVwwXtMjLH4p4aeRg4ht93NEJCE9cUCj4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PhqPg/E2";
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4D606A329
	for <sparclinux@vger.kernel.org>; Sat, 31 Oct 2026 15:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD4D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhqPg/E2
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eabf243d05so635950e0c.2
        for <sparclinux@vger.kernel.org>; Sat, 31 Oct 2026 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793459704; x=1794064504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u4AoREHEWHwqK+9vsy9N5I/xo3mEZgUmU5DSaNM6uCY=;
        b=PhqPg/E24VOKRLpfl1ae1ubh4CKpCn29JqhLZjBp/MR26TAAiPCusNfbhZKqTqe7Xj
         KcQq5Lydqkv/yxQqi5C7ZY3ZDqurJIdEnXH0ucUJaLRRdFFYKlc9/hSNt/FBOqLJJqI7
         p6jj64s7228VWY/vk1afOCOip01plUgqwJps6dk4WwMDU5fMSszkrzQk+rwDSKDYE+HI
         68LbUdDAtL6NWwfUTf5zsmuxjMBjVb0I019RVHKueoF64p2AswdpFejX62Xr+afWIrOW
         DgPY165zFFs16BXhBuygZX7vyRNjKllQEoev9+VtxIjjr17scodCqljZafdWsq6sK09A
         Fhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793459704; x=1794064504;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4AoREHEWHwqK+9vsy9N5I/xo3mEZgUmU5DSaNM6uCY=;
        b=qeUSztm0lXJ2UmIIueolOL1kHlvs2wh7k1Jww4MRqNSSzKOfPuIogwovfvkFaTtFjN
         APQf5CVcHj0+CYrbcAgWBQLwRw4KY4QnRtYVR+DDJ6P0M9JrLrOq1YrI7fniMyV3EnHc
         he4Z9d2Dz9fkKAiWFl+TusOK6IrHZpw0VnoxdPacPuYTXWL9xdNVt6X39ejh1tTtw7cY
         VcIIe/N7MwX+dV6I/FKmxB/2nSmb4mt8wU+K34sf6WqcYhLgP2WRWf6eDwL9ZcF182dE
         D66HPmDkETbvBKKExPp7sdE5k+d0sUgkhQrWYeOfssp0hZbdgKm0LAdasqX0APiJDqAj
         ILwg==
X-Forwarded-Encrypted: i=1; AKwUvBz9T1JlV2iwn3xNeElET+HiscwSP0ijw6NpDFgj7/jzQpvUgdAzg+qBp100V6fYGAO9JlSapw8Cm4hC@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8HdPoUvJQZOmV+SDyRsgk89PwcxOHZ0gwCm0Tx+VM7DLkVcvJ
	aZ0+nJLM3s/KcmOOjuYs5HCRYbu+X+IM3YffT+zBc5HzD5NCcCetplD2
X-Gm-Gg: AYBFou2e2m7c2Mc9dB6aJ5gLtKWWGOdMUcDrv7VSoeDESdQBe2xrfHambJ+aBYdgIt6
	csXFYovktrpqpLqgS6zCob8aqPdY2yTpypeQlD2uddZXtnIthI6VTwQ6ylnvQEGX0Uu2fC38t2N
	mHuZS8hp0ik4pl1wS+A3nu6V1gFifWM6enzXwci7mGMwVqr7InzKH+QxoACRuhSQymb+XCdh8bt
	oXpy8hvAclXK05ILtd29jSM/WrGhSZ/26COmGCeYizWTtFgFSHqMqS4+TGkHV/GKvI/fbk4x9kI
	6hpZkSora7mEIqCN7ZOyOdeHTa2Cnt3RMntktYV2C4p/2VhfHfz+CwjCue17wguWn/xGxQ6wDVz
	9HFCk8LfYgRw+9Zqn0PpY3L7Vs50lJIb9Kj6NVDSxBhI5cTpbECKbT05TvOL+NJjeFNOVR4cM/L
	gB0oa9kAVGd7ta7dhbq+9LiYC5RY7IyyVUE6RwMYntf9x+GR+emXmcn61+NwrcTpkb4N3xiFvwS
	zzwsBbg2PxPE+AoVRiF/p7/iKEpQwmlYwiN3/jgQh35/Vxj7X2Xa0cgvELCaV3opS2DFGIkSSyB
	hcZT7Vsj88VdX2HaNsQHMTwa7LAwph74zfLPM2YYAwoTbAnPBv6WzAK6IsqeCuYeVRpQoJuESni
	FDmxk+4xqt0oOmh693UdpIj6bAUaQsx0inXnIq4Dqlbf0hxmENUHqYj+lBn8L4m+FSYjK
X-Received: by 2002:a67:e116:0:b0:7a1:fa0f:1106 with SMTP id ada2fe7eead31-7d072d759a9mr2050864137.36.1793459704527;
        Sat, 31 Oct 2026 08:15:04 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c5d183sm6032016e0c.13.2026.10.31.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:15:03 -0700 (PDT)
Date: Sat, 31 Oct 2026 11:15:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, 
 Magnus Lindholm <linmag7@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
 Jori Koolstra <jkoolstra@xs4all.nl>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Chuang Wang <nashuiliang@gmail.com>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 linux-arch@vger.kernel.org
Message-ID: <willemdebruijn.kernel.e08dc63db124@gmail.com>
In-Reply-To: <20261031113330.45704-2-vitaly.zuevsky@gcore.com>
References: <20261031113330.45704-1-vitaly.zuevsky@gcore.com>
 <20261031113330.45704-2-vitaly.zuevsky@gcore.com>
Subject: Re: [RFC PATCH net-next v1 1/2] net: add SO_NO_RFS to exclude a
 socket from RFS and aRFS
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vitaly Zuevsky wrote:
> RFS and accelerated RFS are enabled per host and per rx queue, but
> whether steering helps is a property of the flow. A host that carries
> a few long-lived flows which benefit from steering alongside a large
> churn of short-lived flows has no way to express that today.
> 
> Add a boolean socket option, SO_NO_RFS. When set, sock_rps_record_flow()
> does not record the socket in rps_sock_flow_table, so get_rps_cpu()
> finds no match and neither software RFS nor ndo_rx_flow_steer() acts
> on the flow; it stays on the CPU chosen by RSS or RPS.
> 
> The option is kept in sk_flags so that sk_clone_lock() copies it to
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

The Documentation change can/should be included in the main patch.

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

Avoid verbose comments. Bots comment a lot more than kernel style.

Also arguably incorrect as TCP_ESTABLISHED is the common case.

> +		if (unlikely(sock_flag(sk, SOCK_NO_RFS)))
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

Never is too strong here: can be set during socket lifetime.

Even if it had been correct, still another example of unnecessary
verbosity.

> +	 */
> +	if (sock_flag(sk, SOCK_NO_RFS))
> +		return;
> +

Both here and _sock_rfs_record_flow: probably should be in their
callers, like the other precondition check rfs_is_needed.

>  	hash = READ_ONCE(sk->sk_rxhash);

Optionally maybe also skip writing sk_rxhash if this is the only user.

>  	if (!hash)
>  		return;
