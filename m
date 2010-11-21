From: Alex Buell <alex.buell@munted.org.uk>
Date: Sun, 21 Nov 2010 02:11:53 +0000
Subject: Re: XVR-500
Message-Id: <1290305513.28786.14.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <1289604206.26034.53.camel@lithium>
In-Reply-To: <1289604206.26034.53.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2010-11-14 at 10:42 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Sun, 14 Nov 2010 13:27:30 +0000
> 
> > I will need to install OpenBSD on a spare disk and see how it works.
> 
> I think simply reading the OpenBSD sources will be less painful and
> certainly less time consuming than doing a complete install.
> 
> But that's just me :-)

Yes, I've been delving into the sources, NetBSD and OpenBSD, along with
your console frame buffer driver.

I've never seen such a weird-assed frame buffer, *two* separate buffers
for each of the bit depths; 8 bit depth and 32 bit depth? Probably
useful for page flipping to speed up drawing operations. 

All the open source drivers only support 8 bit depth operations. But I
noticed the presence of 32 bit depth buffers, has anyone ever figured
out a way to use them yet? 

In the meantime I've put together the bare beginnings of a X11 driver
for the XVR-500. It now detects the card and says so. 

The next things to do is to write some code to write into the frame
buffer's memory area and see how it all works together. This'll be fun. 
-- 
Tactical Nuclear Kittens
