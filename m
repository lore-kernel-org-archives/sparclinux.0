From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 31 Mar 2004 01:49:25 +0000
Subject: Re: [PATCH] Add config option for '-mcpu=v8'
Message-Id: <20040331014925.GE6522@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040331013528.GA6522@artsapartment.org>
In-Reply-To: <20040331013528.GA6522@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 30, 2004 at 08:37:48PM -0500, Ben Collins wrote:
> On Tue, Mar 30, 2004 at 07:35:28PM -0600, Art Haas wrote:
> > Hi.
> > 
> > Here are two small patches that allow you to configure your kernel build
> > so that an '-mcpu=v8' option is passed to the compiler. I've built the
> > 2.6.5-rc3 stuff with this flag in the compile command, and the kernels
> > both run. I'd hacked the flag in initially; this patch makes it a nice
> > configuration option. Comments on the Kconfig wording welcomed.
> 
> As Dave told me before when I tried this, it is pointless. The sparc
> kernel patches in the hw versions of the muldiv functions at kernel
> startup anyway, so passing -mcpu=v8 is just a waste.
> 

That must explain why this option isn't already available. :-)

Thanks.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
