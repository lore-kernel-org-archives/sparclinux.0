From: "David S. Miller" <davem@redhat.com>
Date: Thu, 26 Aug 2004 20:19:46 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <20040826131946.35ae3d97.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 26 Aug 2004 13:01:36 -0400
Ben Collins <bcollins@debian.org> wrote:

> > I'm supposed to be asleep right now, and I won't be back in front of the 
> > E450 until about midnight Central Time.  I'll boot 2.6.6 then and post 
> > the results.  Would it help to try any of the 2.6.7 release candidates?  
> > It grinds out kernels fairly fast...:)
> 
> Yeah, if you can narrow down when this problem started, that would be
> the easiest way to pinpoint the problem.

I was under the impression that this sunsab kernel log output
problem had always been present.  Anyways, if you can find
a 2.6.x where it worked, that would be great :)

Ben, to answer your question, the difference in output for
the console vs. userland is mainly in the setup of the chip.
In particular the initialization of the line.

The big clue is that once userland starts up, and thus opens
the serial line, the output gets sane.  My theory was therefore
that chip init had everything to do with the garbled output.
The actual console character writing code is identical between
2.4.x and 2.6.x in the SAB driver so I really do not think
that is to blame.

Instead, I noticed that hw flow control settings were not being
made in the SAB chip for console init, whereas in 2.4.x they were.
Then I also noticed a hack added to the SunZILOG 2.6.x driver
console code which explicitly set the RTS/DTR properly, and thus
I added it to sunsab.c too in hopes that was the problem.

To wit, two questions for people seeing this problem:

1) Did it work find in some previous 2.6.x version, and if so
   which one?

2) Once userland starts up, the userland messages print out fine
   but are kernel messages still garbled?

Thanks.
