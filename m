From: David Miller <davem@davemloft.net>
Date: Sun, 05 Sep 2010 04:59:42 +0000
Subject: Re: [2.6.34.5] Parport panics
Message-Id: <20100904.215942.186311214.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4C82626D.2050108@systella.fr>
In-Reply-To: <4C82626D.2050108@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 5 Sep 2010 00:00:43 +0200

> On Sat, Sep 04, 2010 at 05:14:53PM +0200, BERTRAND Joel wrote:
>> 	Hello,
>>
>> 	One of my UltraSparc Blade 2000 has crashed during an apt-get  
>> dist-upgrade. Panic is reproductible. Kernel is 2.6.34.5 from  
>> kernel.org. I never see any panic with 2.6.34.1.
>>
>> 	I have check difference between 2.6.34.1 and 2.6.34.5 without success.
> 
> What do you mean "check difference"? Did you try git bisect?

If you guys have PARPORT_PC_SUPERIO enabled in your kernel configs you'll
need to turn that off on sparc64.

He's getting this now because we've recently added the necessary device
ID for the parport chip to get detected properly on his SunBlade-2000.

But if you have PARPORT_PC_SUPERIO enabled it tries to do things which
only work on x86-like machines (direct I/O port accesses in ISA space
poking around for chip presence, etc.).  I should probably add
something to the Kconfig dependencies to prevent this.
