Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447992;
	b=aDES7JFBAHPh3vwhdEQXlGOsYfmPdfd/1fUg6vEuAqv4QAAYZf/crJ880yreTdHR7NK+
	 JXgWi8FsAApnjAJG6e++xEGVDS1H3VSUS6PIm1fuRAO1fAE2QEMNu/fFA5Nex3L1c9Qyj
	 55ZcT9xbyU2nUnY9cGRMGllH480gOjPOIX85QkhpmkV2QcXHZVwlmMaADADDPGpRip95M
	 Q+LH2LnpMfb+0SnSXPCc3LbQdQTDxGg0pHdj5adxrDEWrtV5f+WDSS93blamJVHmE838O
	 ZbeeyonuQYMVGO+kD6X6FdQAzgPk0L+55lxdsvQBPcKXaY1GHIvcu4Lq6ZLtimSJmNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447992;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=f+XkNcgdG0Sy9wKL/HCuBDFw6WXi30Rm2xWjumq4AE8=;
	b=eAWzdNjByBcOBKpuMwjJq6CMs3KyiUrN6Bl+tks7KI1twdocV4uacAFgUDza1d6502nK
	 gPMRMx1pyB4Fxv9ObCWodWzaS5xB/LpD//h/I6KYkM9VaMhxbuxVLHitK+FDXJ1qTOoHI
	 xuqNZLJMbHq8f0L1eOC+zkW5SPs6T1ZFsQ5puu8gbpO0chnfIm9lWQBLwY0y8iwtfaTfA
	 9l8kT8McI7naPzIpvDHcD5i1Uh17xq6VtTiDokgNTchH/Hxee2tBFIX4jj31BESLSv6gF
	 ZQ6e89tBrfOnoEk3JmP+GsGV0Hfmlxrukek9MBFoxSeZ0s4cQIS1Eq5rpoEd0EsjIwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnKsYILe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7E606A338;
	Thu, 12 Nov 2026 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnKsYILe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAC21F00A05;
	Thu, 12 Nov 2026 01:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447991;
	bh=f+XkNcgdG0Sy9wKL/HCuBDFw6WXi30Rm2xWjumq4AE8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VnKsYILesXYWEYm/qO+C8ozkPFtrbagYux+N40hoTqwuraizfOxhaum/g8oqq/+us
	 AiAL1pywFeUQbSJOjQL96kktN1RInFGf64VRezBLUW3aDXw1nnpYM7SPfAiNpctDgj
	 EA3NzG/LCUXQ0Lm0Od27k9DSdXxzE7lIJjnRdwyW3GDQ0pNWycQBJ5mtZpdjxYhGeC
	 j6HWcL+rXoSUoxxJzG0Pi229MK+cIx+Vkyt5Rnd9nFiLfjzTlpyKT+Mqy+YVdOSXf6
	 NOAmjC/spTQLBhA6fYJp5qFjGaEIN+FHKLm/BH6XZ//YerAS6hM2HM6yvLgDvZ3GNG
	 iqfm9bM8ko59Q==
Subject: Re: [PATCH net-next v2] net: add SO_BYPASS_RFS to exclude a socket
 from RFS and aRFS
From: netdev-bot+sashiko@kernel.org
To: vitaly.zuevsky@gcore.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 deller@gmx.de, andreas@gaisler.com, kuniyu@google.com, willemb@google.com,
 arnd@arndb.de, brauner@kernel.org, andrew@amutable.com, jkoolstra@xs4all.nl,
 alexander@mihalicyn.com, tariqt@nvidia.com, saeedm@nvidia.com,
 nashuiliang@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Date: Thu, 12 Nov 2026 01:46:29 +0000
Message-ID: <179444798912.2199510.16652368770211815180@kernel.org>
In-Reply-To: <20261109014547.81555-1-vitaly.zuevsky@gcore.com>
References: <20261109014547.81555-1-vitaly.zuevsky@gcore.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says setting SO_BYPASS_RFS on a socket that
  was already recorded means the flow "stops being steered with the next…
- [Medium] Setting SO_BYPASS_RFS does not reliably remove the socket's
  rps_sock_flow_table entry, and an entry re-recorded in a race is never…
- [Low] The commit message says that setting SO_BYPASS_RFS on a listening
  socket "excludes every connection accepted from it".
- [Low] SO_BYPASS_RFS is added as a generic SOL_SOCKET option, but
  MPTCP's SOL_SOCKET handler was not updated.
- [Low] sk_bypass_rfs is a 1-bit bitfield in sock_common
  (include/net/sock.h:186).

--

net: add SO_BYPASS_RFS to exclude a socket from RFS and aRFS

This adds a boolean SOL_SOCKET option, SO_BYPASS_RFS, that keeps a
socket out of rps_sock_flow_table, so neither RFS nor aRFS steers its
flow. The state is a new bit in sock_common that sock_copy() copies to
children, and setting the option clears any existing table entry. Close
time deletion is skipped for bypassing sockets.

> diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
> index 6c9836000a8d1..b23c874056225 100644
> --- a/Documentation/networking/scaling.rst
> +++ b/Documentation/networking/scaling.rst
> @@ -428,6 +428,21 @@ queues. So for instance, if rps_sock_flow_entries is set to 131072 and there
>  are 16 configured receive queues, rps_flow_cnt for each queue might be
>  configured as 8192.
>  
> +Excluding individual sockets
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +RFS is configured per host and per queue, but whether it pays off
> +depends on the traffic pattern. SO_BYPASS_RFS keeps a socket's flow
> +out of rps_sock_flow_table, so neither RFS nor accelerated RFS acts on
> +it: packets stay on the CPU chosen by RSS or RPS, and no filter is
> +programmed into the NIC. The option is inherited through accept(), so
> +a listening socket that sets it excludes every connection it accepts
> +while the sockets the process connects itself remain steered. It may
> +be set at any time; an entry already recorded is removed. This suits

[Severity: Low]

Is "inherited through accept()" accurate? The bit sits in the copied
part of sock_common. It reaches the child through sock_copy() in
sk_clone() when the child is created at handshake completion, not at
accept():

	memcpy(nsk, osk, offsetof(struct sock, sk_dontcopy_begin));

Setting the option on the listener does not walk the accept queue. A
connection whose handshake finished before the setsockopt() therefore
has sk_bypass_rfs == 0. When that connection is accepted later,
__inet_accept() still does:

	sock_rps_record_flow(newsk);

so the flow is recorded and steered.

The commit message says "setting it on a listening socket excludes
every connection accepted from it". Should both texts say that only
connections established after the option is set inherit it?

[ ... ]

> diff --git a/include/net/rps.h b/include/net/rps.h
> index e33c6a2fa8bbc..7c62ae607d182 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -149,7 +149,7 @@ static inline void sock_rps_record_flow_hash(__u32 hash)
>  static inline void sock_rps_record_flow(const struct sock *sk)
>  {
>  #ifdef CONFIG_RPS
> -	if (!rfs_is_needed())
> +	if (!rfs_is_needed() || sk->sk_bypass_rfs)
>  		return;

[Severity: Low]

Will KCSAN report this read? sk_bypass_rfs is a 1-bit bitfield. It
shares a byte with skc_reuse, skc_reuseport, skc_ipv6only,
skc_net_refcnt and skc_bypass_prot_mem.

sk_setsockopt() writes it with a plain read-modify-write under the
socket lock. sock_rps_record_flow() reads it without the lock on the
per-packet paths (inet_recvmsg(), inet_send_prepare(),
mptcp_rps_record_subflows() and others). sock_rps_delete_flow() and
sk_getsockopt() also read it without the lock.

Bitfields cannot be wrapped in READ_ONCE()/WRITE_ONCE(), and none of
these accesses use data_race(). Nearby lockless fields such as
sk_rxhash and sk_incoming_cpu use READ_ONCE()/WRITE_ONCE(), and the v1
sk_flags approach used atomic bitops. Would non-bitfield storage or
data_race() annotations be better here?

[ ... ]

> diff --git a/net/core/sock.c b/net/core/sock.c
> index e2401d735c5a7..00808217aebf1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c

[ ... ]

> @@ -1597,6 +1598,14 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		reuseport_update_incoming_cpu(sk, val);
>  		break;
>  
> +#ifdef CONFIG_RPS
> +	case SO_BYPASS_RFS:
> +		if (valbool)
> +			sock_rps_delete_flow(sk);
> +		sk->sk_bypass_rfs = valbool;

[Severity: Medium]

Can a concurrent recvmsg() or sendmsg() put the entry back here? The
delete runs while sk_bypass_rfs is still 0. inet_recvmsg() and
inet_send_prepare() check the bit and write the table without the
socket lock:

CPU0 (setsockopt, lock_sock held)    CPU1 (recvmsg, no socket lock)
                                     sock_rps_record_flow()
                                       sees sk_bypass_rfs == 0
sock_rps_delete_flow()
  slot = RPS_NO_CPU
                                       _sock_rps_record_flow()
                                         slot = hash | cpu
sk->sk_bypass_rfs = 1

After this, every sock_rps_record_flow() and sock_rps_delete_flow() on
the socket returns early on the bit. That includes the close-time
cleanup in inet_unhash(), udp and sctp.

Does the stale entry then keep steering the flow through RFS after the
socket is closed, until a colliding hash overwrites it? With aRFS it
would also keep the NIC filter active, since rflow->last_qtail keeps
advancing.

Setting the bit before the delete would only narrow the window, unless
the record side re-checks after a paired barrier or the close-time
delete is kept for this case.

[Severity: Medium]

Does this stop steering for a flow that accelerated RFS has already
steered? The only cleanup here is
sock_rps_delete_flow()->_sock_rps_delete_flow(), which writes
RPS_NO_CPU into the rps_sock_flow_table slot. The per-rxqueue
rps_dev_flow entry and the filter installed by ndo_rx_flow_steer()
stay in place.

The driver removes that filter only when rps_may_expire_flow() returns
true:

net/core/dev.c:rps_may_expire_flow() {
    ...
		if (READ_ONCE(rflow->filter) == filter_id &&
		    rps_flow_is_active(rflow, log, cpu))
			expire = false;
    ...
}

Once the socket entry is cleared, get_rps_cpu() sends this flow to
try_rps:

		ident = READ_ONCE(sock_flow_table[flow_id].ent);
		if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
			goto try_rps;

At that point rflow->last_qtail stops advancing. Expiry then depends
only on unrelated backlog traffic on the target CPU. If that CPU sees
little RPS/RFS backlog traffic, can the flow stay hardware-steered
indefinitely?

With software RFS, the flow also moves to the RSS/RPS CPU at once. It
skips the input_queue_head vs last_qtail check that get_rps_cpu()
normally uses to hand off in order. If the option is set mid-flow, can
packets still queued in the old CPU's backlog be delivered out of
order?

The commit message says "a flow recorded earlier stops being steered
with the next packet". scaling.rst says "no filter is programmed into
the NIC" and "It may be set at any time; an entry already recorded is
removed". Should the documentation describe these effects, or should
the rps_dev_flow and filter state be handled too?

> +		break;
> +#endif

[Severity: Low]

Should MPTCP be covered as well? mptcp_setsockopt_sol_socket() accepts
a fixed list of SOL_SOCKET options and ends with:

	return -EOPNOTSUPP;

so setsockopt(SO_BYPASS_RFS) on an MPTCP socket fails. The option is
also not in the comment there that lists unsupported options.

MPTCP records RFS entries per subflow through
mptcp_rps_record_subflows()->sock_rps_record_flow(ssk), which tests
ssk->sk_bypass_rfs. sync_socket_options() copies sk_incoming_cpu to new
subflows but has nothing for sk_bypass_rfs. So allowing the option on
the msk alone would not affect the subflows.

SO_INCOMING_CPU is handled in mptcp_setsockopt_sol_socket(),
mptcp_sol_socket_sync_intval() and sync_socket_options(). Could
SO_BYPASS_RFS be handled the same way, or at least be listed as
unsupported?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109014547.81555-1-vitaly.zuevsky%40gcore.com
