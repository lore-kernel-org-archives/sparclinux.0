From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 02 Nov 2010 13:48:49 +0000
Subject: Re: Linux 2.6.36-rc8 won't boot
Message-Id: <alpine.LNX.2.01.1011021447010.7622@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

nOn Friday 2010-10-15 19:14, Jan Engelhardt wrote:

>Hi,
>
>
>I just compiled 2.6.36-rc8 and observe a hang on boot. My previous 
>working version was 2.6.34-rc1/gcc 4.4.1, and I checked that gcc isn't 
>at fault by recompiling 2.6.34-rc1 with gcc 4.5.0 (it boots).

I tried bisecting today, booted a number of kernels already, and upon 
the latest reboot I only get this - very frustrating.

SPARC Enterprise T1000, No Keyboard
Copyright (c) 1998, 2010, Oracle and/or its affiliates. All rights 
reserved.
OpenBoot 4.30.4.b, 8064 MB memory available, Serial #81908004.
Ethernet address 0:14:4f:e1:d1:24, Host ID: 84e1d124.
(T1000 firmware 6.7.10)

{0} ok boot
Boot device: disk  File and args: 
SILO Version 1.4.14
ERROR: Last Trap: Illegal Instruction
{0} ok

