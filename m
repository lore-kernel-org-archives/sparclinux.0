From: Igmar Palsenberg <maillist@jdimedia.nl>
Date: Mon, 22 Mar 2004 10:19:45 +0000
Subject: Re: temp solution: sun fire v100 / gcc 3 woes
Message-Id: <Pine.LNX.4.53.0403221118420.4711@jdi.jdimedia.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0403212214380.24178@passoa.internal>
In-Reply-To: <Pine.LNX.4.58.0403212214380.24178@passoa.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> After spending 3 days tweaking, I figured it out! Gcc 3.2 / 3.3 seems
> unable to build a kernel for my Sun Fire V100. It compiles without fatal
> errors, but upon booting the Sun crashes:
> 
> SILO Version 1.4.4
> boot: 2.4.25 -p
> Allocated 8 Megs of memory at 0x40000000 for kernel
> Loaded kernel version 2.4.25
> Illegal Instruction
> ok

You're sure you end up with a 64 bit binary ? I'm running a 2.4.25 kernel 
compiled with gcc 3.3. (this all assuming your CPU is a sparc64)/


	Igmar
