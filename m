From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 07:10:12 +0000
Subject: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <20080821.001012.265401427.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: sparclinux@vger.kernel.org, paulus@samba.org


I'm working on some drivers for I2C bus support on some of my sparc64
workstations (for lm-sensor and eeprom type devices sitting behind
them) so I went back to trying to get of_i2c.c usable on sparc.

Mostly straightforward stuff _except_ for the I2C address encoding.

What I2C IEEE1275 device binding was used to write that code in
of_i2c.c?  Is it some PowerPC specific thing?  Was it "invented"
by the embedded folks (I hope not)?

On sparc, the encoding is either 1 cell or 2 cell.

If it's one cell, it's just the device address.

If it's two cells, it's a bus number (for I2C controllers that
can manage multiple I2C bus segments, think PCI domains) in the
first cell and the device address in the second cell.

And, furthermore, the device address is shifted up 1 bit higher
than the Linux I2C layer expects.  It includes the low direction
bit, bit 0, so we have to shift it down by 1 bit before we give
it to the Linux I2C layer.

Does PowerPC really encode these things differently?  And if so what
IEEE1275 I2C device binding specification covers that?

If PowerPC really does encode the device address in the same format as
the Linux I2C layer expects, that's OK and I used some property tests
and ifdefs to make it all work out.  What I did in these patches is:

1) Check the #address-cells property.  If not present, assume the value
   is "1".  Only accept values of "1" and "2".

2) When CONFIG_SPARC, shift the device address down by one bit before
   giving it to the Linux I2C layer.

I haven't added support to the I2C layer for the bus number yet, that
will come later.

The first patch in this series add the powerpc-compat IRQ probing
interfaces, mostly straightforward stuff as we precompute these
IRQs in of_device objects so we just search for the of_device corresponding
to the device node and return the interrupt, if any.  Dispost is a NOP.

The second patch deals with the addressing issues described above and
lets it be compiled on non-ppc systems.

The third patch adds device modaliases for a couple of I2C chip devices
I've seen on my SunBlade2500 workstation.  More will come later as I
flesh out my I2C sparc64 drivers which are not being posted here yet.
I have a fully functional Sun pcf8584 I2C bus driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
