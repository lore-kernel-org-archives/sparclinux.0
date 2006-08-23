From: David Miller <davem@davemloft.net>
Date: Wed, 23 Aug 2006 05:26:07 +0000
Subject: Re: Two bugletts on Sparc 64 @ kernel 2.4
Message-Id: <20060822.222607.59468359.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0601569295@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0601569295@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The klogd program needs to be adjusted to determine the data type the
kernel is using for module symbols, just like modutils does.

What modutils does is it asks the system what type it is, 32-bit or
64-bit, by making a uname() call.

Using this information, modutils will adjust the data types it uses
internally, as appropriate.

This handled properly a 32-bit binary running on a 64-bit kernel.

So the kernel change you are proposing is not the correct fix for this
problem.
