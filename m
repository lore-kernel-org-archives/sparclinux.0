From: Pete Zaitcev <zaitcev@redhat.com>
Date: Wed, 31 Dec 2003 23:35:02 +0000
Subject: Re: socal
Message-Id: <20031231233502.GA2051@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 31, 2003 at 03:19:03PM -0800, Aaron Wirtz wrote:
> On Wednesday 31 December 2003 15:07, C.Newport wrote:
> >
> > Have you tried checking the firmware Fcode ?.
> > http://www.splack.org/fibrechan.html has the procedure for the soc
> > cards, the socal stuff is very similar.
> 
> Given that the Solaris driver (and ucode) work with it under Solaris 9, I 
> don't think the fcode version is currently an issue.  One thing I had 
> considered was that if I have to use an older ucode version, I may have to 
> roll back the fcode to match.

This just makes no sense. FCode carries its own ucode,
which has nothing to do with the one a driver carries.
For one thing, FCode always carries a debugging ucode,
which tops at about 1000 IOPS. A driver carries a normal
microcode, which reaches 5500 IOPS with small blocks,
17000 IOPS with null ops (for IP-over-SCSI, for instance).
They are different and do not have to match, even their
ABI may be slightly different.

-- Pete
