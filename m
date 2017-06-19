From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jun 2017 01:42:40 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170618.214240.1882109144404814596.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
In-Reply-To: <20170531193431.GA26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 19 Jun 2017 00:42:14 +0200

> On 06/18/2017 09:59 PM, John Paul Adrian Glaubitz wrote:
>> According to Eric Botcazou from gcc upstream, we most likely know the
>> culprit now. Eric noticed that the issue occurred within the cilk-plus
>> testsuite and by passing --disable-libcilkrts to configure, the testsuite
>> finished without problems, even with -j32.
> 
> The machine just crashed with this being the last message during the build:
> 
> FAIL: g++.dg/cilk-plus/CK/catch_exc.cc  -g -fcilkplus execution test

That amount of information puts me lightyears away from being able
to figure out what the problem might be and potentially fix it.
