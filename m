From: Andrew Walrond <andrew@walrond.org>
Date: Thu, 18 Oct 2007 09:52:43 +0000
Subject: Re: GCC 4.2.1 produces broken 2.6.22.1 kernel.
Message-Id: <47172CEB.6010300@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
References: <46B7600A.3060700@walrond.org>
In-Reply-To: <46B7600A.3060700@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> 
> I just have done some SMP kernel testing on my Niagara-2 systems
> and it looks really good with that gcc-4.2.x patch I posted.
> -

Excellent. I'll give it a whirl here aswell.

Will you be posting the patch to the gcc ML? My little distro is
wonderfully symmetric across x86/x86_64/itanium2/sparc64 except for the
need to use gcc 4.1 on sparc64, so it will be a nice to get a fix merged
for 4.2.3 and 4.3/mainline.

And how are those Niagara2 systems shaping up? Much improvement over
Niagara1 ?

Andrew Walrond
