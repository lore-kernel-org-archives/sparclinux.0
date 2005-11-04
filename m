From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 04 Nov 2005 21:23:54 +0000
Subject: Re: PATCH: cs4231 on sbus
Message-Id: <20051104.132354.104647320.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <43527FA3.8090301@triaton-webhosting.com>
In-Reply-To: <43527FA3.8090301@triaton-webhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Sun, 16 Oct 2005 18:28:19 +0200

> here is another cs4231 patch which makes
> it work on my ultra2. Tested by Christopher
> Zimmermann and myself. It introduces some
> sbus_dma routines similar to the ebus_dma
> stuff to make the code look nearly the same
> for both cases. I hope it does not break ebus.
> Patch against 2.6.14-rc2-git4. Thanks to
> Christopher for testing.

Patch applied, thanks Georg.
