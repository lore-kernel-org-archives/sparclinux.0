From: Meelis Roos <mroos@linux.ee>
Date: Thu, 19 Aug 2004 14:28:59 +0000
Subject: Re: Sun4d progress
Message-Id: <E1BxnuV-0006Aj-SW@rhn.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

WLII> Okay, what gcc/binutils is everyone using and can we start slinging
WLII> binaries compiled from the same kernel compiled by different gcc's
WLII> around so I can diagnose this? Thanks.

gcc 3.3.* on Debian and this doesn't work for 2.4.22+ kernels on SMP
SS10 - under load, processes hang in wait_on_page.

-- 
Meelis Roos
