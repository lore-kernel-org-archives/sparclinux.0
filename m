From: David Miller <davem@davemloft.net>
Date: Sun, 04 Nov 2007 08:07:21 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071104.010721.246525234.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 2 Nov 2007 17:21:06 +0100

> Great. Here you go, three of them, while the load was 3 and this process was
> stuck:
> 
> buildd   10813  100  0.8 987368 17504 ?        RN   14:44 155:49 dpkg-query --search libpthread.so.0 libdl.so.2 libstdc++.so.6 libm.so.6 libgcc_s.so.1 libc.so.6 libFLAC.so.8 libid3tag.so.0 libz.so.1 libmad.so.0 libglib-2.0.so.0 libmikmod.so.2 libsndfile.so.1 libvorbis.so.0 libogg.so.0 libvorbisfile.so.3
 ...
Nov  2 17:02:04 lebrun kernel:   CPU[  0]: TSTATE[0000000080009604] TPC[0000000000407924] TNPC[0000000000407928] TASK[dpkg-query:10813]
Nov  2 17:02:04 lebrun kernel:              TPC[sparc64_realfault_common+0x8/0x20]

It looks like dpkg_query is stuck on a page fault.  Typically
this means the fault processing is not putting a valid
translation into the TLB to satisfy the fault, so we loop
forever never making forward progress.

I've had to debug something similar to this before, so I'll
piece together a debugging patch you can use to get more
information.
