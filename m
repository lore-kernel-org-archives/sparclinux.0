From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 26 Jan 2007 22:05:29 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <1169849129.4809.21.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2007-01-21 at 17:25 +0200, Meelis Roos wrote:
> TS> Warning: unable to open an initial console.
> 
> Try to use network console if the native console is not supported.
> netconsole=..., see Documentation/networking/netconsole.txt

It was a good idea, but unfortunately:

eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c8 
eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c9 
eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:ca 
eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:cb 
netconsole: eth0 doesn't support polling, aborting.

Yes, I have an e10k too. :)

~spot

