From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 21 Apr 2004 19:28:41 +0000
Subject: Re: No luck booting latest 2.6.6-rc kernels
Message-Id: <20040421192841.GA2123@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040421185159.GB7445@artsapartment.org>
In-Reply-To: <20040421185159.GB7445@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 21, 2004 at 11:59:16AM -0700, William Lee Irwin III wrote:
> On Wed, Apr 21, 2004 at 01:51:59PM -0500, Art Haas wrote:
> > Both the 2.6.6-rc1 and 2.6.6-rc2 kernels have failed to boot on my SS20.
> > The 2.6.5 kernel is the latest of the 2.6.X series to succeed in
> > booting. The new -rc kernels show 'Booting Linux...' on the screen, and
> > then things just sit there. The configuration I use hasn't changed
> > between 2.6.5 and the newest kernels is the same.
> > Are others seeing boot failures with the latest 2.6 kernels?
> 
> Is this booting with -p? Must be early if so.
> 

No, I'm not using '-p' as a boot argument. I've found a bit of text
about using a '-p' boot option in arch/sparc/prom/printf.c, but haven't
used it before. The 'Booting Linux...' message seems to come from
device_scan() in arch/sparc/kernel/devices.c.

Art
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
