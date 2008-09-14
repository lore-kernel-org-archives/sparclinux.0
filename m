From: Robert Reif <reif@earthlink.net>
Date: Sun, 14 Sep 2008 14:13:55 +0000
Subject: Re: [PATCH]: Updated PROM sun4m IRQ register patch.
Message-Id: <48CD1C23.6030900@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080913.214526.47086017.davem@davemloft.net>
In-Reply-To: <20080913.214526.47086017.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Robert Reif wrote:
> David Miller wrote:
>> Please give this a spin:
>>
>> sparc32: Use PROM device probing for sun4m irq registers.
>>   
> This one works too!
I just tried SMP and I got a Watchdog Reset.  I'll back this one out and 
see if the first one works SMP.
