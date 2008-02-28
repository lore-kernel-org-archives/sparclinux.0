From: Jarod Wilson <jwilson@redhat.com>
Date: Thu, 28 Feb 2008 18:42:05 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <200802281342.06493.jwilson@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802272221.38985.jwilson@redhat.com>
	<1204179959.15052.372.camel@pasglop>
In-Reply-To: <1204179959.15052.372.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

On Thursday 28 February 2008 01:25:59 am Benjamin Herrenschmidt wrote:
> > Under Mac OS X, system.log says "FireWire (OHCI) Apple ID 31 built-in now
> > active". Could still be lucent though, judging by the subsys device ID of
> > 5811, which matches up w/the Lucent/Agere FW323. But no, apparently I
> > don't have the interesting one.
>
> Well, it's interesting in the sense that it's a "normal" OHCI then on a
> BE machine :-) My Pismo, which had the weirdo one, unfortunately died a
> while ago. I'll see if I can find another machine with that one in.

Ah, the pismo has it, eh? I think I may actually know of someone in the office 
that still has one of those that I might be able to borrow and poke at...


-- 
Jarod Wilson
jwilson@redhat.com
