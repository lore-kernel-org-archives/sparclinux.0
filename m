From: David Miller <davem@davemloft.net>
Date: Sun, 14 Feb 2010 18:40:10 +0000
Subject: Re: soft lookup
Message-Id: <20100214.104010.40616143.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213170856.GA8334@pcpool00.mathematik.uni-freiburg.de>
In-Reply-To: <20100213170856.GA8334@pcpool00.mathematik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Bernhard R. Link" <brlink@debian.org>
Date: Sun, 14 Feb 2010 12:43:34 +0100

> * Bernhard R. Link <brlink@debian.org> [100213 18:31]:
>> The process itself is shown as using the full cpu (i.e. 100% in top).
>> Attaching gdb, strace or ltrace causes those to hang.
>> The process cannot be killed, not even by kill -KILL.
>> After this process is thus stuck, other processes seem to get then
>> problems too and rebooting needs reboot -n -f to actually happen).
>>
>> What can I do to get narrow this down? Retry with a vanilla kernel?
>> Find out at what operation the script (run by bash) starts to hang?
> 
> Looking at some of the addresses and a disassembled kernel, that seems
> to be in sparc64_realfault_common within sparc64_realfault_common
> within for example a call in setup_frame32 (inlined in do_signal32),
> so I guess this is related to the signal stack misalignment and will
> retest once I have a kernel with those patches applied.

It has nothing to do with that.

For some reason the fault isn't being resolved by the fault
handler, so we keep faulting forever on the same instruction.
