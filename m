From: Martin Furter <mf@rola.ch>
Date: Thu, 29 Dec 2005 19:25:58 +0000
Subject: Re: Debinan/Sparc UPS control.
Message-Id: <Pine.BSO.4.62.0512292014180.29580@uruz.rola.ch>
List-Id: <sparclinux.vger.kernel.org>
References: <20051229120721.B3192@daves-domain.net>
In-Reply-To: <20051229120721.B3192@daves-domain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi Dave

The following command shows a few packages:

apt-cache search ups | grep -wi ups

The most relevant seem to be the following:

apcd - APC Smart UPS daemon
genpower - Monitor UPS and handle line power failures
upsd - UPS Monitor Program via serial interface
apcupsd - APC UPS Power Management
nut - The core system of the nut - Network UPS Tools

HTH
Martin


On Thu, 29 Dec 2005, Dave Lee wrote:

> Hi all,
> aside from SNMP does anyone know of a package
> to handle this?
> I'm using a Sparc 20 server and a serial-controled UPS (Powerware 5119).
>
> Thanks,
>
> -Dave
> -
