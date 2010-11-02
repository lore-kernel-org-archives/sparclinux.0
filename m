From: David Miller <davem@davemloft.net>
Date: Tue, 02 Nov 2010 13:54:05 +0000
Subject: Re: Linux 2.6.36-rc8 won't boot
Message-Id: <20101102.065405.226772209.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 2 Nov 2010 14:48:49 +0100 (CET)

> I tried bisecting today, booted a number of kernels already, and upon 
> the latest reboot I only get this - very frustrating.
> 
> SPARC Enterprise T1000, No Keyboard
> Copyright (c) 1998, 2010, Oracle and/or its affiliates. All rights 
> reserved.
> OpenBoot 4.30.4.b, 8064 MB memory available, Serial #81908004.
> Ethernet address 0:14:4f:e1:d1:24, Host ID: 84e1d124.
> (T1000 firmware 6.7.10)
> 
> {0} ok boot
> Boot device: disk  File and args: 
> SILO Version 1.4.14
> ERROR: Last Trap: Illegal Instruction
> {0} ok

Type "dis" and ".registers" so that you can see where it crashed
and what the register values were at the time of the crash.
