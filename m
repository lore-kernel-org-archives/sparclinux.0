From: Ben Collins <bcollins@debian.org>
Date: Tue, 15 Mar 2005 12:34:16 +0000
Subject: Re: fc-al and A5000
Message-Id: <20050315123416.GA3857@internal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Yep, I've been given access to an e4500 with a T3 array. So far, I've only
been able to try the drivers that are currently available. I've gone back
to 2.2.4 where socal first appeared, and still can't get things working. I
can only get the socal driver to recognize the live port. Proc shows that
the device (this T3) failed to respond, usually with a RJT.

Haven't gotten beyond that yet. I'm in the middle of buying a new house,
so I wont have time to work on this for another week or two. I do intend
to get it working though.

If anyone has information they want to dump on me about their experience
in this driver and trying to get this working, please do so. I'm going
into it blind, without any docs, and no reference point for a working
system.

On Mon, Mar 14, 2005 at 10:17:57PM -0800, David S. Miller wrote:
> On Tue, 15 Mar 2005 01:00:40 -0500
> Morten Pedersen <camaro468@gmail.com> wrote:
> 
> > does anyone know where to find some information or know how to make my
> > E4500 talk to my A5000?
> 
> Unfortunately, you are currently out of luck.  The SBUS
> fc drivers are in a very poor state and don't work for
> most people.
> 
> Ben Collins is trying to get the SOC/SOCAL driver working
> with his array on his E4500.  He'll certainly post results
> if he makes any progress.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
