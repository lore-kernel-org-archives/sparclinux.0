From: David Miller <davem@davemloft.net>
Date: Wed, 08 Aug 2007 10:15:31 +0000
Subject: Re: 2.6.22.1 kernel grinds...to......a............halt......
Message-Id: <20070808.031531.76773776.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46B98697.8090802@walrond.org>
In-Reply-To: <46B98697.8090802@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Walrond <andrew@walrond.org>
Date: Wed, 08 Aug 2007 10:02:15 +0100

> Having got over the gcc 4.2 issue, I booted a seemingly good 2.6.22.1
> kernel compiled with gcc 4.1.2.
> 
> However, after starting a big (whole distro) compilation job (several
> make -j12 jobs in parallel), the machine begins to really slow down,
> eventually becoming unresponsive. I notice build jobs beginning to fail
> and my ssh connection is dropped.
> 
> I managed to login directly from the ALOM console, and typed dmesg.
> Eventually, after a _long_ wait, I got the output below.
> 
> This is a 2Gb machine with 2Gb of swap running a distro (<1Gb) out of
> initramfs. It has plenty of free ram at the start of the build (~1Gb)
> so it really shouldn't be invoking the oom-killer I suspect.
> 
> Any clues as to what is going on? I can supply my .config if that will help.

Doing "several make -j12" jobs with only 2GB of real ram is
going to make you swap like crazy, at best.  If you push things
too far, memory gets extremely fragmented to the point where
non-zero order pages are hard to come by.  Order 1 pages are
needed to fork() a new process or thread, and you have almost
none of them even after the kernel works hard to reclaim pages
to try and put pairs together.

Tone down the parallelization to something that is more sensible for
the amount of ram you have.  I don't have a suggestion, sorry.
