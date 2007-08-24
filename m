From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Date: Fri, 24 Aug 2007 17:00:06 +0000
Subject: Re: errno codes intertwined
Message-Id: <20070824170006.GA3543@filer.fsl.cs.sunysb.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
In-Reply-To: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org

On Fri, Aug 24, 2007 at 06:24:48PM +0200, Jan Engelhardt wrote:
...
> If a file does not have the requested attribute, the syscall will 
> produce ENODATA. On x86_64, that is mapped to the value 61. Back on the 
> sparc side, 61 is mapped to ECONNREFUSED, and that gives odd errors 
> when ls tries to query xattrs:
 
I'd think that passing the raw error code is a bad idea, and that you
probably want to have your own set of codes that you use in the trasport and
map value to/from the host's errno values.

> the values are exactly swapped (mips is another oddball not portrayed 
> here). Since these header files propagate into /usr/include, this 
> affects userspace programs too.

Yep, and it kind of sucks.

> So I'm just asking: can I rely on the same errno across Linuxes?

I wouldn't - Linux on different different architectures seems to have
different errno codes.

> And should the errno values be fixed up?

It would break userspace :-/

Josef 'Jeff' Sipek.

-- 
*NOTE: This message is ROT-13 encrypted twice for extra protection*
