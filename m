From: Aaron Wirtz <awirtz@novapointe.com>
Date: Mon, 22 Mar 2004 19:05:58 +0000
Subject: Re: temp solution: sun fire v100 / gcc 3 woes
Message-Id: <200403221105.58524.awirtz@novapointe.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0403212214380.24178@passoa.internal>
In-Reply-To: <Pine.LNX.4.58.0403212214380.24178@passoa.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On Monday 22 March 2004 02:19, Igmar Palsenberg wrote:
>> After spending 3 days tweaking, I figured it out! Gcc 3.2 / 3.3 seems
>> unable to build a kernel for my Sun Fire V100. It compiles without fatal
>> errors, but upon booting the Sun crashes:
>>
>> SILO Version 1.4.4
>> boot: 2.4.25 -p
>> Allocated 8 Megs of memory at 0x40000000 for kernel
>> Loaded kernel version 2.4.25
>> Illegal Instruction
>> ok
>
> You're sure you end up with a 64 bit binary ? I'm running a 2.4.25 kernel
> compiled with gcc 3.3. (this all assuming your CPU is a sparc64)/

The V100 is indeed a 64-bit SPARC.  I am running 2.4.25 on a V100, compiled 
with gcc 2.95.  I haven't tried compiling the kernel with another version of 
gcc recently.

-Aaron
