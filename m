From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 13 Mar 2006 04:30:13 +0000
Subject: Re: ESP busted
Message-Id: <20060312.203013.78137614.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060309.131637.114886710.davem@davemloft.net>
In-Reply-To: <20060309.131637.114886710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Sun, 12 Mar 2006 20:14:25 -0700 (MST)

> With gcc-3.3.5 and gcc-3.3.6, esp works fine with or without the patch on 
> 2.6.16-rc6.  If gcc-3.4.5 is used to compile 2.6.16-rc6, the patch does 
> not really appear to change anything as the esp errors happen with or 
> without it.

I thought the ESP errors appeared with gcc-3.3.x, why were
you testing any of my patches with that compiler if that was
not the failure case to begin with?

My time is wasted yet again...
