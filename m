From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 06 Dec 2005 23:39:58 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051206.153958.65921378.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051205.181732.34234732.davem@davemloft.net>
In-Reply-To: <20051205.181732.34234732.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Zimmermann <madroach@zakweb.de>
Date: Tue, 6 Dec 2005 16:08:10 +0100

> I'm not sure, if this is the same problem, but since 2.6.15rc3 my X11 broke
> too. I'm working on an Ultra2 Creator. This is what my X11 says on 2.6.15rc5:
> 
> Call Trace:
>  [0000000000439de4] copy_process+0x8e4/0xe40

This was fixed in 2.6.15rc4 and later.
