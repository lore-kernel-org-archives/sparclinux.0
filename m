From: Andrew Walrond <andrew@walrond.org>
Date: Wed, 17 Oct 2007 12:14:32 +0000
Subject: Re: GCC 4.2.1 produces broken 2.6.22.1 kernel.
Message-Id: <4715FCA8.4090507@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
References: <46B7600A.3060700@walrond.org>
In-Reply-To: <46B7600A.3060700@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> 
> The dataflow pass doesn't mark global registers correctly, and
> the new thing in gcc-4.2.x vs. gcc-4.1.x is that it uses the
> dataflow pass for the loop optimizers.
> 

I look forward to testing this when you think it's ready. As well as the
kernel, I discovered several other packages which behave oddly and/or
crash when compiled 64bit with 4.2, but seem just fine with 4.1. (My
custom server distro is pure 64bit for simplicity sake (only 1 version
of libs etc etc), so I'm probably the only one to have noticed).

Andrew Walrond

