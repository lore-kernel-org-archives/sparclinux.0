From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 27 Oct 2004 17:56:12 +0000
Subject: Re: Would a JTAG port help with sun4d SMP work?
Message-Id: <20041027175612.GI2653@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b476569a041027060861767e78@mail.gmail.com>
In-Reply-To: <b476569a041027060861767e78@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 27, 2004 at 01:08:06AM -1200, Adam Hunt wrote:
> I was just sitting here at 5:56am PST looking around my bedroom when
> my SPARCserver 1000E caught my eye.  I got it from a guy who's wife
> was making him clean out the garage.  I've never had any real Sun
> equipment (I did have a little MicroSPARC box that was made by someone
> other then Sun but I never got the chance to fire it up).  I'd really
> like to get this unit up and running with all of it's processors fired
> up.  For whatever reason I decided to pull it apart.  After I removed
> the front covers I found what I assume is an EEPROM reset button and a
> DB25 connector on the control board (part 501-1979).   Wondering what
> the connector could be for I searched the web for it's board label
> (J0101) and found that it is a JTAG port.
> What does this have to do with all of you?  Well I know that there are
> a couple of people (William Lee Irwin and C. Newport) that were
> working on getting the sun4d line to boot in SMP mode and I thought
> that access to the main JTAG might just help with that.
> I appologize for the noise if everyone already knows the above
> information or if it is of no help.

The use of the JTAG would allow rather immediate and enormous advances
if we had any notion of how to use it. I suspect this is not an entirely
uncommon state of affairs, as I've heard that e.g. Exy00's all have open
JTAG ports, none of which we have any notion of how to use AFAIK.

-- wli
