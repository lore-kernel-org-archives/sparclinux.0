From: Adam Hunt <kinema@gmail.com>
Date: Wed, 27 Oct 2004 13:08:06 +0000
Subject: Would a JTAG port help with sun4d SMP work?
Message-Id: <b476569a041027060861767e78@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I was just sitting here at 5:56am PST looking around my bedroom when
my SPARCserver 1000E caught my eye.  I got it from a guy who's wife
was making him clean out the garage.  I've never had any real Sun
equipment (I did have a little MicroSPARC box that was made by someone
other then Sun but I never got the chance to fire it up).  I'd really
like to get this unit up and running with all of it's processors fired
up.  For whatever reason I decided to pull it apart.  After I removed
the front covers I found what I assume is an EEPROM reset button and a
DB25 connector on the control board (part 501-1979).   Wondering what
the connector could be for I searched the web for it's board label
(J0101) and found that it is a JTAG port.

What does this have to do with all of you?  Well I know that there are
a couple of people (William Lee Irwin and C. Newport) that were
working on getting the sun4d line to boot in SMP mode and I thought
that access to the main JTAG might just help with that.

I appologize for the noise if everyone already knows the above
information or if it is of no help.

--adam
