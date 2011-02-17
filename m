From: David Miller <davem@davemloft.net>
Date: Thu, 17 Feb 2011 22:20:51 +0000
Subject: Re: How do we allocate virtual floppy irq on sparc64
Message-Id: <20110217.142051.28805328.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110217205747.GA25027@merkur.ravnborg.org>
In-Reply-To: <20110217205747.GA25027@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 17 Feb 2011 23:17:40 +0100

>> 
>> So I will look up "SUNW,fdtwo" + "fd" to find the platform_device
>> for floppy.
>> And in that platform_device I can find the already allocated irq.
> 
> Looks like this in patch format.
> Not tested yet as I still need to adapt irq_32.c...

Sure, that'll work.

Eventually both floppy_{32,64}.h should be converted to proper OF
probing code.

