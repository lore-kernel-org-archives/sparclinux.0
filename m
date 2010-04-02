From: David Miller <davem@davemloft.net>
Date: Fri, 02 Apr 2010 21:45:36 +0000
Subject: Re: Kernel panic - not syncing: Irrecoverable deferred error trap
Message-Id: <20100402.144536.234615496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
In-Reply-To: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 02 Apr 2010 14:43:02 -0700 (PDT)

> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Fri, 02 Apr 2010 22:40:45 +0200
> 
>> Booting a Sun Blade 2000 + XVR-1000, with a XVR-1200 installed into pci
>> as well, prints a kernel panic now. Attaching a full txt boot log.
> 
> I'm going to need a lot more of your kernel log to debug this.

Ignore me, I didn't see your attachment :-)

Can you look up:

0x686af0
0x686aac

in the System.map file for this kernel?  Even
easier you should be able to go:

bash$ gdb ./vmlinux
(gdb) x/10i 0x686af0
(gdb) x/10i 0x686aac

in your kernel build directory to get the same information
for me.

Thanks!
