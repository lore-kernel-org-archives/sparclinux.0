From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 10 Feb 2021 14:51:32 +0000
Subject: Re: [PATCH bpf 1/4] net: add SO_NETNS_COOKIE socket option
Message-Id: <a922e31d-efce-35c3-c584-cf1bdcf93c5d@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20210210120425.53438-1-lmb@cloudflare.com>
 <20210210120425.53438-2-lmb@cloudflare.com>
In-Reply-To: <20210210120425.53438-2-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenz Bauer <lmb@cloudflare.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: kernel-team@cloudflare.com, linux-api@vger.kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org



On 2/10/21 1:04 PM, Lorenz Bauer wrote:
> We need to distinguish which network namespace a socket belongs to.
> BPF has the useful bpf_get_netns_cookie helper for this, but accessing
> it from user space isn't possible. Add a read-only socket option that
> returns the netns cookie, similar to SO_COOKIE. If network namespaces
> are disabled, SO_NETNS_COOKIE returns the cookie of init_net.
> 
> The BPF helpers change slightly: instead of returning 0 when network
> namespaces are disabled we return the init_net cookie as for the
> socket option.
> 
> Cc: linux-api@vger.kernel.org
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

...

>  
> +static inline u64 __sock_gen_netns_cookie(struct sock *sk)
> +{
> +#ifdef CONFIG_NET_NS
> +	return __net_gen_cookie(sk->sk_net.net);
> +#else
> +	return __net_gen_cookie(&init_net);
> +#endif
> +}
> +
> +static inline u64 sock_gen_netns_cookie(struct sock *sk)
> +{
> +	u64 cookie;
> +
> +	preempt_disable();
> +	cookie = __sock_gen_netns_cookie(sk);
> +	preempt_enable();
> +
> +	return cookie;
> +}
> +
> 

I suggest we make net->net_cookie a mere u64 initialized in setup_net(),
instead of having to preempt_disable() around reading it.

(Here and in your patch 2/4)

Your patches would be much simpler.

Cleanup patch :

https://patchwork.kernel.org/project/netdevbpf/patch/20210210144144.24284-1-eric.dumazet@gmail.com/
