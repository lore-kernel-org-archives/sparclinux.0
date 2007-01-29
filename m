From: David Miller <davem@davemloft.net>
Date: Mon, 29 Jan 2007 17:34:25 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <20070129.093425.35015899.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 29 Jan 2007 10:52:40 -0600

> This is the question I'd really like to hear the answer to. I can't find
> anything at all, either in the Sun docs or in the Internet tubes.

The starfire boxes have an SRAM area on the bootbus.

This is a shared communication area between the running system and the
SSP.  There is a receive buffer, a send buffer, and a 16-bit count for
each of those 2 buffers.  The receive side is polled, you just wait
for the count to become non-zero and that means console input is
available.

The console output buffer is 1024 bytes, the console input buffer
is 256 bytes.  However, the final 2 bytes of each of those buffers
contains the 16-bit count, so essentially you have 1022 bytes for
console output and 254 bytes for console input.

Another oddity is that the buffers are filled at the tail.  So, for
example if you have 16 characters to output, you copy them to the
final 16-bytes of the buffer area (right before the 2-byte count)
and then you write the count to be 16.

So the memory layout is essentially, offsets in bytes:

0	Console output buffer
1022	Console output buffer count, 16-bit
1024	Console input buffer
1278	Console input buffer count, 16-bit
1280	Control register, 8-bit

So, again, to write a 16-byte console output chunk, you'd
copy to the tail 16-bytes of the output buffer (offsets
1006 to 1021) and then write the 16-bit count of 16 at
offset 1022.

You can't write another console message until the SSP takes
it in, at which point the count will hit zero.  So you'll
have to have some polling scheme for output too, and I guess
a good heuristic would be to wait for a newline character or
some timeout before trying to toss things into this buffer.
But initially you can just write whatever you get.

The control register contains either zero (means nothing to do)
or another value which indicates certain events have occurred,
you poll this when you poll for console input.  The possible
values are:

0	nothing
1	Stop-A break sequence
2	SSP hung up on us and disconnected
3	Console switch to network, stop posting output bytes to SRAM
4	Console switch to SRAM, resume posting output bytes to SRAM
5	Console via network closed

Ignore values 3, 4, and 5 for now, there is a way to redirect console
output over the network with the SSP but we'll not support that yet.

drivers/serial/sunhv.c is probably a good model to start
with.

The physical address to get at the bootbus SRAM area is different on
each cpu.  It is calculated as:

	0x100f8000000 + (hwmid << 33) + 0x10000000000

hwmid is defined as:

	hwmid = ((cpuid & 0x3c) << 1) |
		((cpuid & 0x40) >> 4) |
		(cpuid & 0x3);

and cpuid is of course smp_processor_id().  You can see an existing
use of these calculations in

	arch/sparc64/kernel/starfire.c:starfire_hookup()

You can then use upa_{read,write}{b,w,l,q}() from asm/upa.h to
access this area using the physical addresses.

I don't know if the machine is OK with multiple cpus accessing
the bootbus SRAM area.  If not, it might be necessary to start
up a polling thread, which is the only entity accessing the SRAM
area, and force bind it to a particular CPU.  I don't think it
will be necessary, just something to keep in mind.

Hope this helps.
