From: David Miller <davem@davemloft.net>
Date: Fri, 21 Apr 2017 01:49:34 +0000
Subject: Re: [PATCH 2/2] sparc64: Add eBPF JIT.
Message-Id: <20170420.184934.719100622429060115.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170418.145823.444134784458713460.davem@davemloft.net>
        <58F72F6B.9060808@iogearbox.net>
In-Reply-To: <58F72F6B.9060808@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: daniel@iogearbox.net
Cc: sparclinux@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed, 19 Apr 2017 11:35:39 +0200

> On 04/18/2017 08:58 PM, David Miller wrote:
>> +	if (!prog || !prog->len)
>> +		return orig_prog;
> 
> This condition can be removed, see also 93a73d442d37
> ("bpf, x86/arm64: remove useless checks on prog"), since
> there's no way we could land here under such circumstance.

Ok.

>> +	bpf_flush_icache(ctx.image, ctx.image + image_size);
> 
> Since remaining parts were filled through jit_fill_hole(),
> it would be better / more correct to flush the whole buffer,
> see also the recent ppc64 commit 10528b9c45cf ("powerpc/bpf:
> Flush the entire JIT buffer") that fixed it for their jit.

Ok, I've made that change too, thanks!
