From: David Miller <davem@davemloft.net>
Date: Wed, 16 Dec 2015 03:13:39 +0000
Subject: Re: [PATCH] sparc64: Add ADI capability to cpu capabilities
Message-Id: <20151215.221339.1714172700783152724.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1449097600-23288-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1449097600-23288-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 15 Dec 2015 17:25:42 -0700

> adi is the externally visible name for this feature and that is how it
> is referenced in the docs. Firmware encodes it as "adp" for its
> internal use and that is how it shows up in hwcap-list property. So
> this code translates it from firmware internal name to the external
> name which would make sense to someone looking at /proc/cpuinfo.

I totally disagree with changing the string.

If the firmware provides X that's what we should publish in the
cap list.  It doesn't really matter what the docs say.

Otherwise we have this rediculous set of translations whenever
something like this pops up again, and that kind of crud tends
to accumulate.
