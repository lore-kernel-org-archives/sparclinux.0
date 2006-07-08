From: David Miller <davem@davemloft.net>
Date: Sat, 08 Jul 2006 00:06:36 +0000
Subject: Re: sparc32 sunzilog prom walk patch
Message-Id: <20060707.170636.13747990.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Thu, 22 Jun 2006 14:08:45 -0700 (PDT)

> The current sun4d prom walk for serial ports is missing it's last leg,
> The "bare bone" attachment is a brute force fixit, the "alternate"
> attachment recovers a chunk of code space
> 
> Either one would work

The current 2.6.18-rc1 tree should attempt to address all of these
sunzilog probing bugs in a cleaner way, with the of_device framework.

I have that other email from you, Raymond, detailing how the sun4d
crashes in the current 2.6.18 tree and I'll look into that soon.

Thanks.
