From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 19 May 2005 14:35:08 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6
Message-Id: <1116513308.3502.226.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0505190111530.13987@bobcat>
In-Reply-To: <Pine.LNX.4.61.0505190111530.13987@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2005-05-19 at 01:20 -0400, Jurij Smakov wrote:
> Hi again,
> 
> I have now tried the pristine 2.6.11.10 kernel and it fails on mounting 
> initrd too on my Hypersparc-powered SS10. The last messages (same as with 
> Debian kernels) I see are:

I'd suggest that you try the 2.6.12-rc kernels instead. Sparc32 is
anything but stable, and lots of fixes aren't going into that "stable"
patchset (but are going into the rc patches).

I'm not even going to spend any cycles with the 2.6.11.* patchese
because I know they're missing at least 10 or so of my fixes.

~spot
-- 
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

