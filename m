From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 19 Feb 2006 18:21:10 +0000
Subject: Re: possible spinlock/esp bug in 2.6.16-rc4
Message-Id: <20060219.102110.04330429.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060219101701.6f2ce579@enterprise.weeve.org>
In-Reply-To: <20060219101701.6f2ce579@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Sun, 19 Feb 2006 10:17:01 -0700

> Getting the below on an Ultra 1 when booting 2.6.16-rc4.  Any ideas?
> This box works fine using 2.4 kernels, and has worked before in 2.6
> (though it is susceptible to what appear to be the same the I/O
> lockup issues on the Ultra 2s).

Please do a "git bisect" from the last known working version
so we can find out exactly what change caused this regression.

The esp driver hasn't been touched in ages so it's probably
a sparc64 or SCSI layer generic change that caused this.

Please get in the habit of using git.  Using "git bisect" allows you
to determine quickly exactly what patch introduced a regression
saving developers and yourself a lot of wasted time analyzing
bug reports.

Thanks a lot.
