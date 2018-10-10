From: David Miller <davem@davemloft.net>
Date: Wed, 10 Oct 2018 17:08:57 +0000
Subject: Re: sparc64 mystery with Cheetah+ D-cache parity error (n_tty_set_termios, bpf_check, cheetah_copy_p
Message-Id: <20181010.100857.951754034539960711.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4391645-0c4f-bd99-7371-b0e2cb505542@linux.ee>
In-Reply-To: <a4391645-0c4f-bd99-7371-b0e2cb505542@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sparclinux@vger.kernel.org, netdev@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 10 Oct 2018 16:24:59 +0300

> I have seen multiple strange messages like this, on multiple sparc64
> machines:
> 
> [ 55.523882] CPU[1]: Cheetah+ D-cache parity error at
> TPC[0000000000707e8c]
> [   55.626033] TPC<n_tty_set_termios+0x2c/0x3c0>
> 
> This specfic one ise from n_tty_set_termios and it is currently
> repeatable on a Sun V210.
> I have seen these on V245 and V445 too, with different addresses. On
> V445, the same address caused
> errors on multiple CPUs so it does not seem like a hardware problem,
> rather something software releated,
> that's why I am reporting it here.
> 
> On V445 it is gone with my current custom kernels but was there with
> 4.16.0-1-sparc64-smp Debian kernel package,
> probabaly because I do not have bpfilter compiled in:

I just started getting my older machines up again and I get these
kinds of errors sometimes too, usually in the TSB copy routine.

I'll definitely be looking into this and thanks for the report and
data.
