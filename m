From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 21 Oct 2004 05:19:17 +0000
Subject: Re: [PATCH] sunsu.c
Message-Id: <20041020221917.135bbc36.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4175D5D4.3090702@starhub.net.sg>
In-Reply-To: <4175D5D4.3090702@starhub.net.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 20 Oct 2004 11:04:52 +0800
RChan <rspchan@starhub.net.sg> wrote:

> The following patch fixes an oops in the serial subsystem
> when using a agetty/login on ttyS[01] reported by me on the
> mailing list. I suspect member values from the uart_sunsu_port structure are
> not correctly transferred to the uart_port structure?

Thanks a lot, I'll take a closer look at your bug fix
soon.  I think the propagation should be occuring
automatically and I want to find out why that might
not be occuring.
