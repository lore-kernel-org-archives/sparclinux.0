From: Andres Salomon <dilinger@queued.net>
Date: Sat, 26 Feb 2011 06:41:32 +0000
Subject: Re: [PATCH v5] of/promtree: allow DT device matching by fixing
Message-Id: <20110225224132.0c15eb8a@queued.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110224165917.3760.24493.stgit@localhost6.localdomain6>
	<20110224093341.5a809a13@queued.net>
	<20110224194234.GA8907@angua.secretlab.ca>
	<20110224120109.0ed9f473@queued.net>
	<AANLkTimc37=azh11sYYi6x7gTE=0ybud5tXgxa1TDUMT@mail.gmail.com>
In-Reply-To: <AANLkTimc37=azh11sYYi6x7gTE=0ybud5tXgxa1TDUMT-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 24 Feb 2011 23:06:06 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Thu, Feb 24, 2011 at 1:01 PM, Andres Salomon <dilinger@queued.net>
> wrote:
> > On Thu, 24 Feb 2011 12:42:34 -0700
> > Grant Likely <grant.likely@secretlab.ca> wrote:
> >> If firmware is buggy, then pkg2path must deal with it.  It is not
> >> okay for it to return NULL.  (I know that pkg2path is an OFW
> >> command, but in this context it really means the linux wrapper to
> >> pkg2path which has the semantics, "give me the unique, full and
> >> accurate path for this node").  If OFW pkg2path doesn't work, then
> >> the platform code must work around it.  I'm pushing back on this
> >> because I do not want to see platform workarounds in the common
> >> code.
> >
> > I'm fine with that, I just don't want to see BUG() happening that
> > early.  I think a workaround should be handled in common code.  I
> > agree that heroic workarounds for firmware bugs should be handled in
> > arch-specific pkg2path hooks, but a simple workaround in common code
> > is better than just crashing early in boot (imo).
> 
> Alright, you've swayed me a bit.  I've made this change and pushed it
> out to devicetree/experimental.  I've also picked up your other patch.
>  Let me know if it works for you.


Thanks, that looks good.  Feel free to push into next.

