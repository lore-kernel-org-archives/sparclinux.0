From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 23 Nov 2009 22:56:23 +0000
Subject: Re: Sun fire V890 UltraSparc server kernel panic, offertoassist
Message-Id: <20091123225623.GA2002@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20091122220621.GA16620@orion.carnet.hr>
In-Reply-To: <20091122220621.GA16620@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Nov 24, 2009 at 12:52:21AM +0200, Aaron Scheiner wrote:
> My home network has DHCP server on it (Smoothwall) and two other
> machines running Ubuntu. One of the Ubuntu machines has been configured
> as a TFTP server (used it to hack a Mikrotik router a while back). In
> other words, I should(?) have the environment to boot this Sun machine
> via the network.
> 
> As for the kernel, I found a guide today that should put me on the right
> track : http://wiki.debian.org/DebianInstaller/Modify/CustomKernel .
> 
> I'll work on it a little later today :) .

While we're at it, you mentioned earlier that you tried Ubuntu Dapper (6.06)
with 2.6.15 which also failed miserably - Ubuntu shipped a few more sparc
releases other than that one, so you may get lucky with another one. A quick
Google tells me that their 7.04 and 7.10 releases still had sparc, so try
and find installer images from those.

-- 
     2. That which causes joy or happiness.
