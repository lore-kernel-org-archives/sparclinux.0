From: Dennis Jenkins <dennis.jenkins@sbcglobal.net>
Date: Thu, 03 Mar 2005 23:39:08 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <20050303233908.77803.qmail@web81309.mail.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


--- Chris Newport <crn@netunix.com> wrote:

> I have no idea about Gentoo versions, but Splack 8.0
> has a working 2.2 
> kernel with soc and socal modules. Everything you
> need to experiment 
> with 2.4 is there, but the toolset and compiler are
> too old for 2.6
> In general, you should not need to have the Sun
> firmware in your
> drivers, just upload them to the card and array from
> Solaris and they
> will stay there in nvram. This avoids contaminating
> Linux with Sun's code.
> The procedure for socal is similar to my procedure
> for soc, take a look 
> at the Solaris man pages for luxadm etc.

Ah.  I just did some reading and learned that 'splack'
is a slackware distro for Sparc.  Cool.  I've been
using Slackware for x86 since 1995 (I remember booting
kernel 1.2.13 on a 486sx25 with 2M ram!)  I recently
moved to Gentoo because I like the "portage" thingy. 
Anyway....

I will try booting splack on the box too.  And
flashing the socal drivers, and running "luxadm".

Thank you for your help.  I really do appreciate it.


==Dennis Jenkins
