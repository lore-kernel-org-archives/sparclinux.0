From: Greg KH <gregkh@suse.de>
Date: Wed, 18 May 2011 19:55:14 +0000
Subject: Re: [PATCH 2/2] drivercore: revert addition of of_match to struct
Message-Id: <20110518195514.GB28653@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20110518185751.28986.69446.stgit@ponder>
	<20110518192105.28986.53198.stgit@ponder>
In-Reply-To: <20110518192105.28986.53198.stgit@ponder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Milton Miller <miltonm-ogEGBHC/i9Y@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Josip Rodin <joy-TwbeF3gwir6QvBXZIOnqxg@public.gmane.org>

On Wed, May 18, 2011 at 01:21:05PM -0600, Grant Likely wrote:
> Commit b826291c, "drivercore/dt: add a match table pointer to struct
> device" added an of_match pointer to struct device to cache the
> of_match_table entry discovered at driver match time.  This was unsafe
> because matching is not an atomic operation with probing a driver.  If
> two or more drivers are attempted to be matched to a driver at the
> same time, then the cached matching entry pointer could get
> overwritten.
> 
> This patch reverts the of_match cache pointer and reworks all users to
> call of_match_device() directly instead.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
