From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 08 May 2008 18:18:07 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.LNX.4.44L0.0805081410290.2127-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 8 May 2008, Greg KH wrote:

> On Thu, May 08, 2008 at 12:35:10PM -0400, Alan Stern wrote:
> > On Wed, 7 May 2008, David Brownell wrote:

> > > Possibly related:  On an x86 box that's currently running
> > > 2.6.25 (and unrelated patches), the OHCI controllers are
> > > dead in the water since they never seem to have left the
> > > RESET state after a resume from hibernation.
> > 
> > Looks like the "USB: OHCI: host-controller resumes leave root hub 
> > suspended" commit (43bbb7e015c4380064796c5868b536437b165615) may need 
> > to go into 2.6.25-stable.
> 
> I have no objection to doing that, just let me know if you really want
> that to happen.

That patch won't apply to 2.6.25 as is.  I'll post a rebased version to 
stable@kernel.org.

Alan Stern

