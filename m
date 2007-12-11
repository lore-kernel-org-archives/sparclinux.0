From: David Miller <davem@davemloft.net>
Date: Tue, 11 Dec 2007 09:47:44 +0000
Subject: Re: [BUG] Kernel unaligned access - tcp_transmit_skb
Message-Id: <20071211.014744.69341916.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <c75cfb180712101406q64d8d242n9eb13aaf7c373eb7@mail.gmail.com>
In-Reply-To: <c75cfb180712101406q64d8d242n9eb13aaf7c373eb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Marcel van Nies" <morcles@gmail.com>
Date: Tue, 11 Dec 2007 10:26:43 +0100

> Hi,
> 
> The '[TCP]: Fix TCP header misalignment' patch fixes it.

Thanks for validating this.
