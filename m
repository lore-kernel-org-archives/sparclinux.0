From: David Miller <davem@davemloft.net>
Date: Tue, 27 Mar 2012 22:04:23 +0000
Subject: Re: v440 & expert 3D
Message-Id: <20120327.180423.819288654014074159.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1332502667.1755.10.camel@deblnxsrv224.lan>
In-Reply-To: <1332502667.1755.10.camel@deblnxsrv224.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Tue, 27 Mar 2012 17:25:26 +0200

> On Fri, 2012-03-23 at 12:37 +0100, Frans van Berckel wrote: 
>> Does a Expert 3D fits in a SunFire v440 well. Because in it holds at -
>> console [tty0] enabled, bootconsole disabled. It does not switch.
>> 
>> I am running the default kernel 3.2 from Debian testing. With a PGX64 in
>> the same box it runs well! The card is installed in pci2 slot.
> 
> Today I hooked a serial kabel, take off the usb keyboard. And fount out
> the system reboots spontaneously at the switch with a Expert 3D only
> installed. How do I boot a little bit more verbose, getting debug info?

Boot with the "-p" kernel command line option.
