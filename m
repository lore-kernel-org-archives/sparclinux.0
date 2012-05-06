From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 06 May 2012 06:37:12 +0000
Subject: Re: sparc sun4c support - time to drop it?
Message-Id: <20120506063712.GB15004@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120505162104.GA14563@merkur.ravnborg.org>
In-Reply-To: <20120505162104.GA14563@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 06, 2012 at 05:01:20AM +0100, Mark Fortescue wrote:
> On Sat, 5 May 2012, Sam Ravnborg wrote:
>
>> Is anyone having any sun4c boxes alive and running Linux?
>
> I have not had much time to do any more work on Linux + sun4c but I do  
> have a sun4c box waiting for a new external disk to put Linux on (the 
> last one stopped, I thing due to a ded PSU).

I have come a long way using tftpboot.img and a ram-dsik.
This allows me to keep Solaris on the disk, and booting
Linux. It is a bit slow as I always fetch the full kernel via the
network but this is acceptable.

I hacked busybox to support sparc32 - patches are upstream.

	Sam
