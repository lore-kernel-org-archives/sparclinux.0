From: David Miller <davem@davemloft.net>
Date: Thu, 24 Nov 2016 16:10:49 +0000
Subject: Re: SILO Issues on an E4900
Message-Id: <20161124.111049.1280348645499346383.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
In-Reply-To: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 11:00:29 +0100

> For SILO, Oracle has created several patches which port SILO to 64-bit (I extracted
> that patch and applied it to the Debian package) and other packages which improve
> SILO on modern sun4v machines.

All of the changes which were submitted to this list I reviewed and
either they were poorly formed or did not apply cleanly at all.

Everything fell to /dev/null and the developers made no effort
whatsoever to address the feedback and make the patches actually apply
to the SILO git tree properly.

The patches were not only poorly formed, or not able to apply to the
GIT tree, they were also extremely poorly documented with either a
very terse and vague commit message provided or none at all.  When
I would ask why a change was doing X or Y, I received no response
at all.
