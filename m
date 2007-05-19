From: David Miller <davem@davemloft.net>
Date: Sat, 19 May 2007 19:02:52 +0000
Subject: Re: [PATCH] removes mismatch section warnigs in sparc time.c file
Message-Id: <20070519.120252.79068182.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4650813D.8020105@wp.pl>
In-Reply-To: <4650813D.8020105@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 20 May 2007 19:11:25 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch removes mismatch section warnings in the sparc/kernel/time.c 
> file.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Why in the world do you have CONFIG HOTPLUG enabled on sparc32?
That's the only way I see that you could trigger this warning.
No hotplugging is possible with any device type at all
on that platform :-)

But of course the patch is correct so I'll apply this, thank
you.
