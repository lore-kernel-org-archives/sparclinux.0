From: David Miller <davem@davemloft.net>
Date: Sat, 22 Apr 2017 01:19:37 +0000
Subject: Re: [PATCH RFC] sparc64: eBPF JIT
Message-Id: <20170421.211937.393214469332032143.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170418054444.GA36377@ast-mbp.thefacebook.com>
        <20170418.143732.1494140903085244508.davem@davemloft.net>
        <20170418225707.GA65449@ast-mbp.thefacebook.com>
In-Reply-To: <20170418225707.GA65449@ast-mbp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexei.starovoitov@gmail.com
Cc: sparclinux@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Apr 2017 15:57:09 -0700

> Alternative idea: can the above
> 'add FP, STACK_BIAS, one_of_local_regs' be done once in prologue
> and that register used as substitue for R10 ?

After much consideration I think this is what I'm going to end up
doing, I should have listened to you from the beginning :-)

It will simplify the JIT significantly.

Now I will just have to completely trust that the verifier has audited
all the FP accesses properly. :-)
