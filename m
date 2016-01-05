From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 05 Jan 2016 16:00:45 +0000
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
Message-Id: <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
In-Reply-To: <1452007387-626-1-git-send-email-rabin@rab.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2016-01-05 at 16:23 +0100, Rabin Vincent wrote:
> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> instructions since it XORs A with X while all the others replace A with
> some loaded value.  All the BPF JITs fail to clear A if this is used as
> the first instruction in a filter.

Is x86_64 part of this 'All' subset ? ;)

>   This was found using american fuzzy
> lop.
> 
> Add a helper to determine if A needs to be cleared given the first
> instruction in a filter, and use this in the JITs.  Except for ARM, the
> rest have only been compile-tested.
> 
> Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---


