From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 23:28:10 +0000
Subject: Re: 16550 serial support
Message-Id: <20080911.162810.176344089.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 12 Sep 2008 01:15:43 +0200

> Oh, it's definitely a build issue, after I wiped out the modules directory
> and re-ran modules_install, depmod warned about the same issue.
> 
> So I did a make clean and rebuilt, rebooted, and it still has the same
> problem :/

Strange.  Maybe make clean isn't powerful enough?  Perhaps try
"make mrproper".  It could be that some module signature file is
not being rebuilt.

The thing you're seeing can happen if the module symbols are being
versioned, 8250.c does exports using versions but 8250_pci.c is
referencing those symbols without versions, or vice versa.

> Could it be that the sunsu driver is somehow disturbing 8250?

I doubt it.  The sunsu driver does not export nor reference symbols
with those names.

> (Should we Cc: this to some other mailing list?)

Right now we're not sure if sparc64 or a corrupted build is to blame
or not, so not yet :)
