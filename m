From: Ben Collins <bcollins@debian.org>
Date: Thu, 26 Feb 2004 13:08:50 +0000
Subject: Re: Linux 2.6.3 still doesn't boot on UltraSparc I
Message-Id: <20040226130850.GB651@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040224144245.GA468@phunnypharm.org>
In-Reply-To: <20040224144245.GA468@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Feb 26, 2004 at 10:12:05AM +0100, Lucas Nussbaum wrote:
> On Wed, Feb 25, 2004 at 12:28:53AM -0800, "David S. Miller" <davem@redhat.com> wrote:
> > On Tue, 24 Feb 2004 09:42:45 -0500
> > Ben Collins <bcollins@debian.org> wrote:
> > 
> > > Why it's looping with prom_init(), I'm not sure. Maybe the prom cif
> > > handler and stack aren't getting setup properly. Dave, any ideas?
> > 
> > Nothing jumps to my mind, it might even be just looping inside the
> > OBP itself, ie. in the prom_printf() call.
> 
> Ok. Now, what's next ? I understand fixing a problem with some very old
> Sparcs isn't one of your priorities. Do you want to drop support for
> them in 2.6 ? Or there is still something you/we could do to try to fix
> this ?
> 
> The box is a quadriprocessor with 1.6GB RAM, so we really are interested
> in using it : it isn't _that_ slow.

Well, in the meantime, you can downgrade to silo prior to 1.4.0. Check
http://www.sparc-boot.org/pub/silo/old/

Get one of the silo-loaders tarballs, and unpack it. Put the second.b in
/boot and run "silo -f".

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
