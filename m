From: Aaron Wirtz <awirtz@novapointe.com>
Date: Wed, 31 Dec 2003 23:49:24 +0000
Subject: Re: socal
Message-Id: <200312311549.24585.awirtz@novapointe.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 31 December 2003 15:35, Pete Zaitcev wrote:
> On Wed, Dec 31, 2003 at 03:19:03PM -0800, Aaron Wirtz wrote:
> > On Wednesday 31 December 2003 15:07, C.Newport wrote:
> > > Have you tried checking the firmware Fcode ?.
> > > http://www.splack.org/fibrechan.html has the procedure for the soc
> > > cards, the socal stuff is very similar.
> >
> > Given that the Solaris driver (and ucode) work with it under Solaris 9, I
> > don't think the fcode version is currently an issue.  One thing I had
> > considered was that if I have to use an older ucode version, I may have
> > to roll back the fcode to match.
>
> This just makes no sense. FCode carries its own ucode,
> which has nothing to do with the one a driver carries.
> For one thing, FCode always carries a debugging ucode,
> which tops at about 1000 IOPS. A driver carries a normal
> microcode, which reaches 5500 IOPS with small blocks,
> 17000 IOPS with null ops (for IP-over-SCSI, for instance).
> They are different and do not have to match, even their
> ABI may be slightly different.

Oh.  So the ucode is a full replacement for whatever fcode is installed then?  
That would mean that the soc driver would normally use the fcode (because it 
doesn't load the ucode unless you compile it in), while the socal driver 
always uses ucode (because it never worked with the fcode, so you have to 
compile it in).  That means if I get the driver working with the ucode 
compiled in, I don't have to worry about the fcode at all?

-Aaron Wirtz

