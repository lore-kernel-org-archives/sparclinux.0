From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 31 Mar 2004 00:09:24 +0000
Subject: Re: Compiling sunlance as a module
Message-Id: <20040331000924.GC5439@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040330234412.GB5439@artsapartment.org>
In-Reply-To: <20040330234412.GB5439@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 30, 2004 at 05:00:25PM -0700, Jason Wever wrote:
> On Tue, 30 Mar 2004 17:44:12 -0600
> "Art Haas" <ahaas@airmail.net> wrote:
> 
> > I'm still fiddling around with my configuration for my SS20, and I found
> > that compiling the sunlance.c file as a module has problems. When
> > booting up and the various init scripts are running, the eth0 interface
> > fails to start correctly. By doing 'modprobe sunlance' after I log in I
> > am able to start eth0 and things move smoothly, but I'm an curious to
> > find out why having this code as a module fails
> 
> I'm currently doing this on a ss4 and my first guess would be is that
> nothing is loading the module before the init scripts try to make use of
> the network device.  As long as I have the module loaded *before* the
> network dependent init scripts run, everything is fine.  Not sure which
> distribution you are using or I'd make a suggestion as to where to setup
> the module to load.
> 
> Additionally network drives don't seem to fall under the drivers the
> kernel will auto-load as needed (since it probably can't determine what
> you may have or in the case of multiple NICs, which one you want to use).
> 

My main computer is an old Pentium computer, and I have an ethernet card
using the 8139too driver, and this machine doesn't have any problem
loading the module, and I haven't (knowingly) done anything special to
load it prior to the machine bringing up the eth0 interface. It would
not be surprising if my problem is a configuration error, but when I
compare my sparc-configuration to the i386-configuration, things look
similiar in the networking type areas.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
