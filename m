From: Lamar Owen <lowen@pari.edu>
Date: Thu, 23 Mar 2006 19:29:38 +0000
Subject: Re: Sun Enterprise 6500. 10xUltraSPARC/400MHz, 10Gb mem
Message-Id: <200603231429.40056.lowen@pari.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <87d5gegxf3.fsf@pumba.bayour.com>
In-Reply-To: <87d5gegxf3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 22 March 2006 15:20, David S. Miller wrote:
> From: Turbo Fredriksson <turbo@swe.net>
> Date: Wed, 22 Mar 2006 19:13:36 +0100
>
> > Would it (Linux) even run on such a machine?
>
> It should run just fine.  I highly recommend the current
> Ubuntu dapper drake release, due to the Niagara port a lot
> of bug fixing and stress testing on high arity SMP systems
> has occurred for the kernel being used there.

For others who might not know of the Ubuntu SPARC porting project, please see 
https://lists.ubuntu.com/archives/ubuntu-announce/2005-October/000040.html

Looks nice; something I'll end up testing, probably, being that I have a a 
trio of large Enterprise boxes in my server room for such purposes.  They are 
all currently running Aurora 2.0beta2.

However, Dave, I wouldn't call Dapper a release as yet; I know you are excited 
and thrilled at Linus pulling the Niagara patches into the main tree 
(woohoo!), and having a nice distribution like Ubuntu available for these 
venerable SPARC beasts is marvelous, but having to netboot and netinstall 
means to me that it's probably not ready for production (this is, again, 
mostly for the edification of others on the list).  Nor for that matter is 
Aurora 2.0beta2, or CentOS 4.2beta, or much of the other modern Linuxen for 
SPARCs.  YMMV.

In my case, Aurora 2.0beta2 has proven stable on my E6500 and E5500 in my 
server room; to the OP I say that yes it works fine, but over 8 CPU's with 
the Aurora 2.0beta2 kernel is thought to potentially be unstable;  I can't 
confirm that, as I've run with up to 14 CPU's at a time, but had some 
hardware problems with a couple of CPU/RAM boards.
-- 
Lamar Owen
Director of Information Technology
Pisgah Astronomical Research Institute
1 PARI Drive
Rosman, NC  28772
(828)862-5554
www.pari.edu
