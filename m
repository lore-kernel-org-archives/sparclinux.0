From: David Miller <davem@davemloft.net>
Date: Tue, 17 Sep 2013 16:13:09 +0000
Subject: Re: [sparc64] Sparse cpu_possible_mask
Message-Id: <20130917.121309.1910820573703893030.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <275591379424217@web19h.yandex.ru>
In-Reply-To: <275591379424217@web19h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 17 Sep 2013 17:23:37 +0400

> I booted recent kernel on Ultra2, while probing CONFIG_RCU_NOCB_CPU_ALL option
> enabled, and found that cpu_possible_mask is sparse. The cpuinfo is:
> CPU0:		online
> CPU2:		online
> 
> Other info is:
> PROMLIB: Sun IEEE Boot Prom 'OBP 3.11.25 1998/01/16 12:22'
> Sun Ultra 60 UPA/PCI (2 X UltraSPARC-II 296MHz)
> 
> Who knows what's the reason of it's sparse?

Because that's how the cpus are numbered physically on these
systems.
