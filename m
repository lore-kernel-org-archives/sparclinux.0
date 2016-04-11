From: David Miller <davem@davemloft.net>
Date: Mon, 11 Apr 2016 19:04:07 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160411.150407.154811179841116038.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 11 Apr 2016 09:30:54 +0200

> Hi Dave!
> 
> We have had issues when installing Debian's sparc64 port on SPARC
> machines with virtualization support. In order to be able to install
> Linux into an LDOM container, both the modules sunvdc and sunvnet
> need to be loaded to enable block device and networking support
> within the virtual machine.
> 
> Unfortunately, these modules are never loaded automatically despite
> being present and the hardware supporting it. After some discussion
> in Debian's bug tracker [1], Ben Hutchings, Debian's kernel maintainer,
> mentioned that this is a result of the VIO bus implementation on
> sparc/sparc64 not supporting module aliases and consequently automatic
> loading.
> 
> Ben has provided a minimal and dirty patch which enables aliases
> for vio on sparc/sparc64, but he says the better solution would
> be to merge VIO implementations on both sparc/sparc64 and PowerPC,
> the latter already supporting module aliases and auto loading.
> 
> A quick hotfix as Ben suggested would be great for the time being
> as it would unbreak the Debian installation within LDOMs, so
> I was wondering whether you could merge the patch?
> 
> Any other suggestion?

Thanks for bringing this up.

Although I wonder, I was able to successfully install debian just fine
a couple years ago in LDOM guest nodes without any special changes
whatsoever.  Were there autoload hacks placed in /etc or similar
before?

Either way, I'll look at this patch, thanks.

