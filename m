From: Finn Thain <fthain@telegraphics.com.au>
Date: Wed, 13 Jan 2021 00:12:06 +0000
Subject: Old platforms never die, was Re: Old platforms: bring out your dead
Message-Id: <alpine.LNX.2.23.453.2101131035500.6@nippy.intranet>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de> <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
In-Reply-To: <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, 12 Jan 2021, John Paul Adrian Glaubitz wrote:

> 
> There has to be a healthy balance between hobbyist and commercial use.
> 

Yes, both of those, and everything in-between, including for-profit 
businesses that serve mostly hobbyists. Also start-up companies that may 
never be commercially viable (which is most of them).

And don't forget government and non-government organisations, 
not-for-profit organisations, charities, etc.

> I understand that from a commercial point of view, it doesn't make much 
> sense to run Linux on a 30-year-old computer.

It ain't necessarily so. I would be surprised if there are no Linux VMs 
running on old corporate mainframes right now. But the age of the hardware 
is largely irrelevant.

If you're a museum interested in cultural artifacts from decades past, or 
if you're a business doing data recovery, you're going to need to operate 
those platforms.

Once removed from mainline Linux, a port becomes basically frozen, and may 
not be compatible with future emulators, which are a moving target. I say 
that because last year I fixed bugs in Linux/m68k that made it incomatible 
with recent QEMU releases (it was only compatible with old QEMU releases).
