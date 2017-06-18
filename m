From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 18 Jun 2017 22:42:14 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <ef30bbf2-d88f-e12c-2cea-d19edf49803a@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
In-Reply-To: <20170531193431.GA26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/18/2017 09:59 PM, John Paul Adrian Glaubitz wrote:
> According to Eric Botcazou from gcc upstream, we most likely know the
> culprit now. Eric noticed that the issue occurred within the cilk-plus
> testsuite and by passing --disable-libcilkrts to configure, the testsuite
> finished without problems, even with -j32.

The machine just crashed with this being the last message during the build:

FAIL: g++.dg/cilk-plus/CK/catch_exc.cc  -g -fcilkplus execution test

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
