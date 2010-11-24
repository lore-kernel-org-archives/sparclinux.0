From: Timur Tabi <timur@freescale.com>
Date: Wed, 24 Nov 2010 15:44:52 +0000
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <AANLkTikiTdw1rTxO-wxmutm=vvcxGdTKKCs_roEA7uE-@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
In-Reply-To: <1290607413.12457.44.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michael@ellerman.id.au
Cc: linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org

On Wed, Nov 24, 2010 at 8:03 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:

> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> it would be nice to get rid of, but it's a lot of churn.
>
> So I'm hoping people with either say "YES this is a great idea", or "NO
> this is stupid".

Well, my vote is "no".  I wouldn't call it stupid, but I do think it's
a bad idea.

In general, I don't like renaming functions, because it causes
complications with merges and porting code across kernel versions.  It
also forces me to re-remember things.

And especially in this case, the churn is too great.  You're affecting
files across multiple subsystems and architectures.

-- 
Timur Tabi
Linux kernel developer at Freescale
