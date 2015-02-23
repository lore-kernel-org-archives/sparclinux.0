From: David Horner <ds2horner@gmail.com>
Date: Mon, 23 Feb 2015 05:29:25 +0000
Subject: Re: [RFI]: SPARC - use of in-local-out register sets with hardware strands (threads)
Message-Id: <CAFdhcLSgKi5fkrh15PyesjzwF4e99P5L+XDVEbV5H8_c6Wwsng@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I assume each core has a shared set of registers in the circular
buffer of these register, and that each strand allocates from that
pool.

Can you tell me how to find the number of registers in the pool for a
given machine (I'm currently interested in the T4-2)?

If you can send some good urls my way I would greatly appreciate.

I'm hazzy on the control registers per strand for the current pointer,
the high and low threshold points.

I'm certainly interested in how they are managed, and particularly in
Linux and Solaris.


My "use case" is moving Sybase ASE 15.7 to "kernel thread mode"  from
process mode (and engine affinity at the core level) with Solaris 10.

I suspect overallocation of threads reduces the efficiency of register
sets with triggered spills and fills. In addition to the
overhead of maintaining the mostly idle threads, and the cold cache
effects of the round robin task allocation, I suspect the sharing of
register resources especially would cause much poorer performance than
anticipated.

I expect the same would be true in Linux.

Thank you so much.
