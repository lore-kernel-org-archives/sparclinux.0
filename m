From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 11 Aug 2004 16:45:23 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <20040811174523.A30087@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de> <200408072013.01168.arnd@arndb.de> <Pine.GSO.4.58.0408072234290.23642@waterleaf.sonytel.be> <200408072341.17721.arnd@arndb.de>
In-Reply-To: <200408072341.17721.arnd@arndb.de>; from arnd@arndb.de on Sat, Aug 07, 2004 at 11:41:17PM +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Adrian Bunk <bunk@fs.tum.de>, Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com, "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sat, Aug 07, 2004 at 11:41:17PM +0200, Arnd Bergmann wrote:
> However, I just tried and found that out of the 23 driver submenus, only
> "Generic Driver Options", "Block devices", "SCSI device support",
> "Multi-device support", "Networking support" and "Character devices"
> make any sense at all. All others depend on some hardware that has
> never been attached to an s390 box. 
> 
> We could of course build some subsystems like MTD, ISDN or FB, but
> there is still little point without any low-level drivers.

That gives this type of code additional build coverage, which is a good
thing.  Just allow it in the menues, no need to add it to your defconfigs :)

