From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 26 May 2007 05:14:39 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <1180156479.6254.401.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2007-05-25 at 22:00 -0700, David Miller wrote:
> Sparc 32-bit barely has PCI let alone 3D graphics cards.
> 
> If it's a build issue, simply disallow DRM to be turned on for
> SPARC32. 

I was really wondering about this one. I'd assumed DRM was already
conditionalized out for sparc32.

~spot

