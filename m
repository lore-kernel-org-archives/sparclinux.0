From: Alexey Nezhdanov <snake@penza-gsm.ru>
Date: Fri, 09 Apr 2004 05:03:10 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <200404090903.10687.snake@penza-gsm.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

8/04/2004 23:52 Vincent Cojot wrote:
> On Thu, 8 Apr 2004, David S. Miller wrote:
> > > On Thu, 8 Apr 2004, Alexey Nezhdanov wrote:
> > > > Unfortunately it seems that I've already tryed it with the same
> > > > result. Can you please send me md5 of your file?
> > > > Mine is
> > > > b85b3eb7ba3176745b60fa1f47b03bc3  aurora.img
> > >
> > > raistlin@thorbardin:[~][1008]$ md5sum  /tftpboot/tftp64.img
> > > b85b3eb7ba3176745b60fa1f47b03bc3  /tftpboot/tftp64.img
> > >
> > > It's the same image.. (Sorry, I had missed that part in your
> > > message...)
> >
> > I think it's the graphics card, you probably are using one we
> > don't have any drivers for yet.  What's in the machine?
>
> Alexey has both an M64 and an Expert3D-Lite in his sb2k machine and
> they're both pretty standard so I guess it -should- work for him, at least
> via a serial install. I suggested to him on #sparc that he removes both
> cards and tries a serial install again..
Removed both video cards along with CNR audio card. Now I did not have any 
boards in my box - except of motherboard. Still the same effect.

-- 
Respectfully
Alexey Nezhdanov



