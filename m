From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 31 Mar 2004 01:42:16 +0000
Subject: Re: Compiling sunlance as a module
Message-Id: <20040331014216.GC6522@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040330234412.GB5439@artsapartment.org>
In-Reply-To: <20040330234412.GB5439@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 30, 2004 at 05:21:08PM -0700, Jason Wever wrote:
> On Tue, 30 Mar 2004 18:09:24 -0600
> "Art Haas" <ahaas@airmail.net> wrote:
> 
> > My main computer is an old Pentium computer, and I have an ethernet card
> > using the 8139too driver, and this machine doesn't have any problem
> > loading the module, and I haven't (knowingly) done anything special to
> > load it prior to the machine bringing up the eth0 interface. It would
> > not be surprising if my problem is a configuration error, but when I
> > compare my sparc-configuration to the i386-configuration, things look
> > similiar in the networking type areas.
> 
> Are you running hotplug on the i386 box?  That can result in the module
> being auto-loaded as well as any other automatic hardware detection
> software.

The machine is configured for hotplug; as I was curious to fiddle around
with the 'udev' stuff in development. I'm still using a static '/dev'
directory, though.

> If the kernel is auto-loading the module without outside assistance, I'd
> be interested to know how that works.

I'm certain that my ethernet driver was being successfully loaded as a
module long before I'd begun to configure the kernel with hotplug
capabilities. I should add a few 'lsmod' statements here and there in
the initscripts and see if I can find just where and when this module is
getting loaded.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
