From: "David S. Miller" <davem@redhat.com>
Date: Thu, 08 Apr 2004 18:42:21 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <20040408114221.0f77d57c.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 8 Apr 2004 07:56:54 -0400 (EDT)
Vincent Cojot <coyote@step.polymtl.ca> wrote:

> On Thu, 8 Apr 2004, Alexey Nezhdanov wrote:
> 
> > Unfortunately it seems that I've already tryed it with the same result. Can
> > you please send me md5 of your file?
> > Mine is
> > b85b3eb7ba3176745b60fa1f47b03bc3  aurora.img
> 
> raistlin@thorbardin:[~][1008]$ md5sum  /tftpboot/tftp64.img
> b85b3eb7ba3176745b60fa1f47b03bc3  /tftpboot/tftp64.img
> 
> It's the same image.. (Sorry, I had missed that part in your message...)

I think it's the graphics card, you probably are using one we
don't have any drivers for yet.  What's in the machine?
