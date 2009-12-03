From: Patrick Finnegan <pat@computer-refuge.org>
Date: Thu, 03 Dec 2009 06:48:12 +0000
Subject: Re: Boot problems on a V880
Message-Id: <200912030148.12737.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 01 December 2009, David Miller wrote:
> From: Patrick Finnegan <pat@computer-refuge.org>
> Date: Mon, 30 Nov 2009 23:04:31 -0500
> 
> > I re-ran prtconf -pv under the 2.6.32-rc3 from your sparc git tree,
> > and have the output here (it looks like it has what you're looking
> > for):
> >
> > http://ned.cc.purdue.edu/prtconf-v880
> 
> Linus's tree has the fix, via my net-2.6 tree, so if you use a pure
> sparc-2.6 tree you won't have it.

Ok. this looks like it fixes the problem with the fiber-port gem, but 
the 10/100 TP gem just bounces back and forth between these messages, 
and never gets link:

[  174.260495] eth0: switching to forced 10bt             
[  194.660290] eth0: switching to forced 100bt            

Ideas?  It does this even with the interface not configured (down 
according to ifconfig), which is kinda annoying on the console... I have 
to do an "ethtool -s eth0 autoneg off" to make it stop.

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
