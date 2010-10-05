From: David Miller <davem@davemloft.net>
Date: Tue, 05 Oct 2010 20:38:09 +0000
Subject: Re: [PATCH]SPARC v9: __tsb_context_switch - demap old tsb_map_vaddr
Message-Id: <20101005.133809.90784268.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1286308676.11216.4.camel@hp>
In-Reply-To: <1286308676.11216.4.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 05 Oct 2010 23:57:56 +0400

> When TSB context switches in the function switch_mm() the following
> situation could occur. We have old mapping between physical address
> and tsb_map_vaddr in uTLB, and new mapping is written in fDTLB.
> Because uDTLB has more priority than fDTLB, all transformations
> occur through it, and TSB Pointer in tl0_damiss will be formed with
> the wrong physical address. To prevent this, we need to flush old
> tsb_map_vaddr (TSB_BASE) in TLB. Kernel version 2.6.35.7.
> 
> 
> Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>

By all pieces of documentation that exist, the uTLB only handles
instruction stream accesses.

Therefore, this patch should not be necessary.

Unless you can show me where in the UltraSPARC documentation it states
that the uTLB is used for data accesses, I am not applying this patch :)
