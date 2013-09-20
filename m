From: Bob Picco <bpicco@meloft.net>
Date: Fri, 20 Sep 2013 15:32:18 +0000
Subject: Re: [PATCH 0/4] sparc64 page table
Message-Id: <20130920153218.GB29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1379339199-9388-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1379339199-9388-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Wed Sep 18 2013, 06:32:08PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Wed, 18 Sep 2013 17:59:59 -0400
> 
> > To Summarize:
> > 	1) Dynamically patch PAGE_OFFSET.
> > 	2) Remain at three level page table.
> > . So effectively remain at a single binary for sparc64 without the aid of
> > a config option. Do I have this correct? 
> 
> I don't think remaining at a three level page table for 48 bit
> physical addresses is feasible.
> 
> Let's start one thing at a time, namely dynamic PAGE_OFFSET.  I'm
> working on that right now.
This UltraSPARC - older sparc64 - issue will arise in other work that is
engaged. Would you be willing to suggest an UltraSPARC System which would
cover most issues? My desire is to avoid burdening you with my future
efforts.

I have this recommendation: http://www.berkcom.com/ for refurbished equipment.

This would be for home office computer rack.

thanx,

bob
