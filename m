From: Sjoerd Simons <sjoerd@luon.net>
Date: Sat, 20 Nov 2004 15:47:08 +0000
Subject: Re: ioct32 bit compatibilty questions
Message-Id: <20041120154708.GA17467@spring.luon.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041111110024.GA8836@spring.luon.net>
In-Reply-To: <20041111110024.GA8836@spring.luon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Nov 11, 2004 at 11:04:14AM -0800, David S. Miller wrote:
> On Thu, 11 Nov 2004 12:00:24 +0100
> sjoerd@spring.luon.net (Sjoerd Simons) wrote:
> 
> >   After some debugging it seems that some alsa ioctl have a pointer to a
> >   userspace pointer in their argument struct. When doing a copy_to_user in the
> >   native ioctl to that address (thus directly to the 32bit userspace program
> >   while get_fs() = KERNEL_DS), the machine just hangs.  Is this something 
> >   that can't be done on sparc64 ?
> 
> That's right, this action is illegal and will hang the machine.
> Unfortunately, on x86_64 this happens to work and that appears
> to be where most of the ioctl32 compat stuff gets tested and
> developed.
> 
> If get_fs() = KERNEL_DS all "user" pointers are expected to be in
> kernel space and thus access to real user addresses will fail.

Finally had time to finish the patch. With alsaplayer there is now music out of
my U5's speakers :) Unfortunately there is some distortion. But that is
probably the card driver itself. A friend of mine told me he also had
distortions with alsa's oss emulation on an U5..

Patch attached against linux 2.6.9. I haven't done a lot of kernel hacking, so
any comments are very welcome! 

Also for the people interested i've put a patch against alsa cvs in the alsa bug
tracking system so they can have a look at it too.

  Sjoerd
-- 
You can no more win a war than you can win an earthquake.
		-- Jeannette Rankin
