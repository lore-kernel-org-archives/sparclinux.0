From: David Miller <davem@davemloft.net>
Date: Tue, 28 Apr 2009 01:41:52 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090427.184152.93637365.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 27 Apr 2009 23:29:47 +0100

> On Thu, Apr 23, 2009 at 07:09:43AM -0700, David Miller wrote:
>> 
>> 1) Please remove the PROM console driver from the kernel config, it
>>    does nothing but get in the way.  This will fix the "console slow
>>    on bootup" problem everyone reports on niagara boxes.
>> 
>>    Putting "console=ttyHV0" on the kernel command line works as a
>>    workaround but it still clears the screen once using the PROM
>>    console and even that takes nearly a minute (!).
> 
> I'll file a bug against kernel for that. Do you know if removing that
> driver could have any unintended consequences for non-Niagara machines?

No.

>> 2) Please fix the GETTY setup so that it properly uses ttyS0 on
>>    Niagara.  Otherwise people have no console and can't use their
>>    machine at all after installation.
>> 
>>    Ubuntu does this by making sure there is an /etc/event.d/ttyS0
>>    file with a line saying "exec /sbin/getty -L ttyS0 9600 vt102"
>>    or similar.
> 
> Which installer version did you test that with?

I downloaded the tftpboot image provided from the Download
section of the debian.org web site for Sparc.

> I've tested the lenny installer and it worked correctly with serial
> console (I remember we pushed some fixes for it pretty late in lenny
> release cycle).

It's not exactly a serial console, even though the niagara console is
implemented using a driver that sits on top of the serial core layer.

If you test on a non-niagara system with serial console, it's not the
same test.  Not even remotely.  The device name is different, it shows
up differently in sysfs, etc.

> I believe we fixed it in Lenny r1 release, it would be great to it if
> you could upgrade to it and confirm it (or install from scratch using
> 5.0.1 media from http://www.debian.org/releases/lenny/debian-installer).

I'll give it a try and report back.
