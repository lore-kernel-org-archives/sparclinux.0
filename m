From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue, 05 Jan 2016 16:36:47 +0000
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
Message-Id: <568BF11F.1060507@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
In-Reply-To: <1452007387-626-1-git-send-email-rabin@rab.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/05/2016 04:23 PM, Rabin Vincent wrote:
> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> instructions since it XORs A with X while all the others replace A with
> some loaded value.  All the BPF JITs fail to clear A if this is used as
> the first instruction in a filter.  This was found using american fuzzy
> lop.
>
> Add a helper to determine if A needs to be cleared given the first
> instruction in a filter, and use this in the JITs.  Except for ARM, the
> rest have only been compile-tested.
>
> Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Excellent catch, thanks a lot! The fix looks good to me and should
go to -net tree.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

If you're interested, feel free to add a small test case for the
SKF_AD_ALU_XOR_X issue to lib/test_bpf.c for -net-next tree. Thanks!
