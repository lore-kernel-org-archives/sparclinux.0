From: "C.Newport" <crn@netunix.com>
Date: Fri, 27 Aug 2004 21:20:08 +0000
Subject: Re: [PATCH] export more symbols on sparc32
Message-Id: <200408272220.08884.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cgo2on$h2$1@sea.gmane.org>
In-Reply-To: <cgo2on$h2$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 27 August 2004 8:41 pm, Joshua Kwan wrote:

> Now, re: the pci hunk, it may not be worth applying; a better solution
> might be to turn off PCI for sparc32.. I have never seen a PCI-gifted
> sparc32

You only need PCI sparc32 for Javastations, but they need a special 
nfsroot setup anyway and are best dealt with separately with their
own minimised kernel and pre-installed root filesystem. No installer
is required, just the ability to add packages.


