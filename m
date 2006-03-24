From: Dennis Jenkins <dennis.jenkins@sbcglobal.net>
Date: Fri, 24 Mar 2006 04:08:33 +0000
Subject: Re: Sun Enterprise 6500. 10xUltraSPARC/400MHz, 10Gb mem
Message-Id: <20060324040833.78336.qmail@web81302.mail.mud.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87d5gegxf3.fsf@pumba.bayour.com>
In-Reply-To: <87d5gegxf3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



--- Turbo Fredriksson <turbo@swe.net> wrote:

> How does this sound as a Linux machine? Stability?
> Scalability?
> How good is Linux/SPARC64 in taking advantage of
> this amount
> of CPU's? I've heard that Linux scales up to 32
> CPU's (old number?)
> but I guess that's on x86, not SPARC64?
> 
> 
> Would it (Linux) even run on such a machine? I've
> tried getting
> it to work on a E3000, but is getting huge problems
> with the SCSI
> interface (esp if I remember correctly)...
> This was a friends machine, and I was only called in
> as help. Never
> got it to work correctly with any of the standard
> Debian GNU/Linux
> kernels we tried. Next step was to make a custom
> kernel, but friend
> travels a lot so there's little time to work on
> this.
> Now he's shopping for a E6500 (eBay). But I'm a
> little skeptical
> on getting it to work (at all and/or good). Any
> pointers? Ideas?
> -
> To unsubscribe from this list: send the line
> "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> 

I have a 8 processor E3500.  Linux (Gentoo for me)
works great, except that it CAN NOT use the internal
Fiber Channel disk array.  (I've been told that the
2.2 kernel series used to work, but I don't want to
run a kernel that old).  Really sucks two, as my box
as 8x 18.2G drives.

The damn thing could probably heat my house in the
winter.  The power supply is almost 2 Kilowatts.  The
little air vents at teh bottom make nice foot warmers.

Doing a "make -j8" is very satisfying.

Just remember that the CPUs themselves run at 334MHz
or 400 MHZ.  An E6500 only does 334MHz b/c the
back-plane is too long to support faster CPUs.  Not
sure why yours does 400MHz.  The backplane can move
3GB/s.  The box is not super fast at raw # crunching. 
The total bogomips are only twice that of my AMD
Athlon 1.4GHz.  However, the sun box can do termendous
I/O.  In my opnion, the box would make a great
database server, but would not be useful for high-end
math or 3-d applications.



Dennis Jenkins
