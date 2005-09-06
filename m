From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 06 Sep 2005 19:34:20 +0000
Subject: Re: PCI device issues between Blade 100 and Blade 100
Message-Id: <20050906.123420.61200329.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050904153024.630204cb@enterprise.weeve.org>
In-Reply-To: <20050904153024.630204cb@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Tue, 6 Sep 2005 10:48:20 -0600 (MDT)

> This appears to have done the trick, both the USB 2.0 controller and the 
> sound card driver load correctly now.

Thanks for testing.  That fix is upstream in Linus's 2.6.x tree now.
I'll push it into 2.6.13-stable as well.
