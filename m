From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 20 May 2007 05:06:57 +0000
Subject: Re: [PATCH] removes mismatch section warnigs in sparc time.c file
Message-Id: <46512B45.5050208@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <4650813D.8020105@wp.pl>
In-Reply-To: <4650813D.8020105@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

> Why in the world do you have CONFIG HOTPLUG enabled on sparc32?
> That's the only way I see that you could trigger this warning.
> No hotplugging is possible with any device type at all
> on that platform :-)
> 

I have checked. The CONFIG_HOTPLUG is y by default and is selectable (visible option) only 
if CONFIG_EMBEDDED is set.

Simply, I cannot disable it with menuconfig so I never thought about it.

Regards,
Krzysztof
