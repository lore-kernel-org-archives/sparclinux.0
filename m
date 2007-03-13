From: David Miller <davem@davemloft.net>
Date: Tue, 13 Mar 2007 02:50:58 +0000
Subject: Re: [Systems] Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <20070312.195058.78711350.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
In-Reply-To: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Narayan Newton <nnewton@osuosl.org>
Date: Mon, 12 Mar 2007 16:58:56 -0700

> I have been working on the same server/issue as Mike. We have found that
> our kernel without Netfilter support does not have this issue, but the
> moment you enable it in the kernel config this bug is triggered.
> Attached are the two kernel configs. The only difference is
> CONFIG_NETFILTER=y
> 
> Kernel version: 2.6.21-rc2
> 
> Let me know if I can send you anymore information.

Thanks for the datapoint.

I have a hugetlbfs lockup and a few networking things to attend
to, but after that I'll try again to reproduce the problem
locally.
