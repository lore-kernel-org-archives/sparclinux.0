From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 23 Nov 2009 22:34:00 +0000
Subject: Re: Sun fire V890 UltraSparc server kernel panic, offertoassist
Message-Id: <20091123223400.GA29054@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20091122220621.GA16620@orion.carnet.hr>
In-Reply-To: <20091122220621.GA16620@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 23, 2009 at 11:16:59AM +0200, Aaron Scheiner wrote:
> I don't know who's going to do this, but if it's me does anyone have a
> guide lying around ? :P
> 
> ...or some useful links.

Yeah, the problem is, if you had just a single working Linux version on the
machine, you could try these things on your own; but since you don't, you're
depending on either cross-compiling or someone else compiling the kernel,
*AND* building it into a bootable image.

Maybe if you could plug the machine into a network with another machine
which could serve the boot image over PXE or something...

-- 
     2. That which causes joy or happiness.
