From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 22:06:45 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.150645.453331452623285259.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 23:57:53 +0200

> On 09/19/2017 10:24 PM, David Miller wrote:
>> davem@patience:~/src/GIT/sparc-next$ dpkg -S /usr/sbin/prtconf 
>> sparc-utils: /usr/sbin/prtconf
>> 
>> Come again?
> 
> David, seriously, are you arguing about Debian packages with me?

As long as you keep spouting falsehoods, yes I will.

> sparc-utils is part of the *unreleased* distribution because *I*
> put it there. *unreleased* is *not* an official part of Debian.
> 
> sparc-utils is *not* part of Debian unstable.

Come again?

davem@patience:~/src/GIT/sparc-next$ cat /etc/apt/sources.list
# 

# deb cdrom:[Debian GNU/Linux testing _Wheezy_ - Official Snapshot sparc NETINST Binary-1 20121216-21:35]/ wheezy main

deb http://debian.osuosl.org/debian/ wheezy main
deb-src http://debian.osuosl.org/debian/ wheezy main

deb http://security.debian.org/ wheezy/updates main
deb-src http://security.debian.org/ wheezy/updates main
